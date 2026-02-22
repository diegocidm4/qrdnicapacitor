package com.cqesolutions.qrdnicapacitor;

import android.app.Activity;
import android.content.Intent;
import android.util.Base64;

import androidx.activity.result.ActivityResult;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.cqesolutions.qrdnidroid_project.QRDNIdroid;
import com.cqesolutions.qrdnidroid_project.bean.MiDNIData;

import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

@CapacitorPlugin(name = "qrdni", requestCodes = {12345})
public class qrdniPlugin extends Plugin {
    public static final String KEY_QR_CODE = "qr_code";
    private qrdni implementation = new qrdni();

    @PluginMethod
    public void configure(PluginCall call) {
        String license = call.getString("license", "");
        JSObject certsObj = call.getObject("certs");
        
        // Convertimos JSObject a Map<String, String>
        Map<String, String> certMap = new HashMap<>();
        if (certsObj != null) {
            Iterator<String> keys = certsObj.keys();
            while (keys.hasNext()) {
                String key = keys.next();
                certMap.put(key, certsObj.getString(key));
            }
        }

        JSObject result = implementation.configure(getContext(), license, certMap);
        call.resolve(result);
    }

    @PluginMethod
    public void validaMiDNIQR(PluginCall call) {
        String base64Data = call.getString("data");

        if (base64Data == null) {
            call.reject("No se proporcionó el QR");
            return;
        }

        // Llamamos a la implementación pasando un callback para manejar el hilo principal
        implementation.validaMiDNIQR(getContext(), base64Data, new QRDNIdroid.ResultCallback() {
            @Override
            public void onSuccess(MiDNIData data) {
                JSObject result = implementation.mapMiDNIDataToJS(data);
                call.resolve(result);
            }

            @Override
            public void onError(String errorMessage) {
                call.reject(errorMessage);
            }
        });
    }

    @PluginMethod
    public void abrirEscaner(PluginCall call) {
        saveCall(call);
        Intent intent = new Intent(getContext(), QrCodeScanner.class);
        intent.putExtra("returnString", false);
        // El número 12345 es un identificador cualquiera
        startActivityForResult(call, intent, 12345);
    }

    @Override
    protected void handleOnActivityResult(int requestCode, int resultCode, Intent data) {
        super.handleOnActivityResult(requestCode, resultCode, data);

        if (requestCode != 12345) {
            return;
        }
        // Recuperamos la llamada guardada
        PluginCall call = getSavedCall();

        if (call == null) return;

        if (resultCode == Activity.RESULT_OK && data != null) {
            String base64QR = data.getStringExtra(KEY_QR_CODE);

            // LLAMADA A LA LIBRERÍA
            implementation.validaMiDNIQR(getContext(), base64QR, new QRDNIdroid.ResultCallback() {
                @Override
                public void onSuccess(MiDNIData data) {
                    call.resolve(implementation.mapMiDNIDataToJS(data));
                }
                @Override
                public void onError(String errorMessage) {
                    call.reject(errorMessage);
                }
            });
        } else {
            call.reject("Escaneo cancelado");
        }
    }
}