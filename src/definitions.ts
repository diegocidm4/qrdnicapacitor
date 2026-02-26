export interface qrdniPlugin {
  configure(options: { license: string, certs?: { [key: string]: string } }): Promise<EstadoLicencia>;
  validaMiDNIQR(options: { data: string }): Promise<MiDNIData>;
  abrirEscaner(): Promise<any>;
}

export interface EstadoLicencia {
  descripcion: string;
  APIKeyValida: boolean;
  lecturaQRHabilitada: boolean;
}

export interface MiDNIData {
  dni: string;
  name: string;
  surnames: string;
  birthDate: string;
  expiryDate: string;
  gender: string;

  address: string;
  nationality: string;
  parents: string;
  supportNumber: string;
  
  birthPlace1: string;
  birthPlace2: string;
  birthPlace3: string;
  
  photoData: string; // Base64
  isAdult?: boolean;
  
  rawSignature: string;
  signedData: string;
  certificateRef: string;
  type?: string;
  verificationResult: {
    status: 'VALID' | 'INVALID' | 'NO_CERTIFICATES' | 'INVALID_QR' | 'EXPIRATED_QR' | 'UNKNOWN';
    certificate?: string; // Solo presente si el status es VALID
  }; 
  qrDataExpiry: string;

  fullBirthPlace: string;
}