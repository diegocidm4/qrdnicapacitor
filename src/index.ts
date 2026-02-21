import { registerPlugin } from '@capacitor/core';

import type { qrdniPlugin } from './definitions';

const qrdni = registerPlugin<qrdniPlugin>('qrdni', {
  web: () => import('./web').then((m) => new m.qrdniWeb()),
});

export * from './definitions';
export { qrdni };
