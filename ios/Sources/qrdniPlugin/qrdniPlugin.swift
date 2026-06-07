import Foundation
import Capacitor

@objc(qrdniPlugin)
public class qrdniPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "qrdniPlugin"
    public let jsName = "qrdni"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "configure", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "validaMiDNIQR", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "abrirEscaner", returnType: CAPPluginReturnPromise),
    ]
    private let implementation = qrdni()
    
    // PROPIEDAD PARA GUARDAR LA LLAMADA (Plan B)
    private var scanCall: CAPPluginCall?
    private var scannerVC: ScannerViewController?

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Si se cierra sin haber emitido resultado, notificar cancelación
        NotificationCenter.default.post(name: NSNotification.Name("lecturaQRCancelada"), object: nil)
    }

    @objc func configure(_ call: CAPPluginCall) {
        let license = call.getString("license") ?? ""
        let certs = call.getObject("certs") as? [String: String]
        let resultado = implementation.configure(license, certs)
        
        var json: [String: Any] = [:]
        json["descripcion"] = resultado.descripcion
        json["APIKeyValida"] = resultado.APIKeyValida
        json["lecturaQRHabilitada"] = resultado.lecturaQRHabilitada
        
        call.resolve(json)
    }

    @objc func validaMiDNIQR(_ call: CAPPluginCall) {
        guard let qrBase64 = call.getString("data") else {
            call.reject("No se proporcionó el QR")
            return
        }

        if let qrData = Data(base64Encoded: qrBase64) {
            if let resultadoJson = implementation.validaMiDNIQR(datosQR: qrData) {
                call.resolve(resultadoJson)
            } else {
                call.reject("La validación del DNI falló o el QR es inválido")
            }
        } else {
            call.reject("Formato Base64 inválido")
        }
    }

    @objc func abrirEscaner(_ call: CAPPluginCall) {
        // 1. Guardamos la llamada en nuestra variable local
        self.scanCall = call
        
        // 2. También la guardamos en el bridge por seguridad
        self.bridge?.saveCall(call)
        
        DispatchQueue.main.async {
            let scannerVC = ScannerViewController()
            scannerVC.modalPresentationStyle = .fullScreen
            scannerVC.inicializa(returnString: false)
            self.scannerVC = scannerVC 

            NotificationCenter.default.addObserver(self, selector: #selector(self.handleScannerResult(_:)), name: NSNotification.Name("lecturaQR"), object: nil)
            
            self.bridge?.viewController?.present(scannerVC, animated: true)
        }
    }
@objc func handleScannerResult(_ notification: Notification) {
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name("lecturaQR"), object: nil)

    // Cerrar el scanner
    DispatchQueue.main.async { [weak self] in
        self?.scannerVC?.dismiss(animated: true)
        self?.scannerVC = nil
    }

    guard let call = self.scanCall else {
        print("ERROR: La referencia local a la llamada es nil")
        return
    }

    // El scanner publica "qrcodeData" (Data) en modo DNI,
    // o "qrcode" (String) en modo texto. Aceptamos ambos.
    var qrData: Data? = nil
    if let userInfo = notification.userInfo {
        if let d = userInfo["qrcodeData"] as? Data {
            qrData = d
        } else if let s = userInfo["qrcode"] as? String {
            qrData = Data(base64Encoded: s)
        }
    }

    guard let datos = qrData else {
        call.reject("Error al obtener datos")
        self.scanCall = nil
        return
    }

    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
        guard let self = self else { return }

        if let resultadoJson = self.implementation.validaMiDNIQR(datosQR: datos) {
            DispatchQueue.main.async {
                call.resolve(resultadoJson)
                self.scanCall = nil
            }
        } else {
            DispatchQueue.main.async {
                call.reject("Fallo en validación")
                self.scanCall = nil
            }
        }
    }
}
