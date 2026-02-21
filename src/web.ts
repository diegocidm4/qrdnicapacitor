import { WebPlugin } from '@capacitor/core';

import type { qrdniPlugin } from './definitions';

export class qrdniWeb extends WebPlugin implements qrdniPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
