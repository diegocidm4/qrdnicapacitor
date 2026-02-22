import { WebPlugin } from '@capacitor/core';

import type { qrdniPlugin, EstadoLicencia, MiDNIData } from './definitions';

export class qrdniWeb extends WebPlugin implements qrdniPlugin {
  abrirEscaner(): Promise<any> {
    console.log("NOT IMPLEMENTED");
    throw new Error('Method not implemented.');
  }
  configure(options: { license: string; certs?: { [key: string]: string; }; }): Promise<EstadoLicencia> {
    console.log("NOT IMPLEMENTED");
    console.log(options);
    throw new Error('Method not implemented.');
  }
  validaMiDNIQR(options: { data: string; }): Promise<MiDNIData> {
    console.log("NOT IMPLEMENTED");
    console.log(options);
    throw new Error('Method not implemented.');
  }
}
