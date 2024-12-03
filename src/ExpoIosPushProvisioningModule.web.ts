import { registerWebModule, NativeModule } from 'expo';

import { ExpoIosPushProvisioningModuleEvents } from './ExpoIosPushProvisioning.types';

class ExpoIosPushProvisioningModule extends NativeModule<ExpoIosPushProvisioningModuleEvents> {
  PI = Math.PI;
  async setValueAsync(value: string): Promise<void> {
    this.emit('onChange', { value });
  }
  hello() {
    return 'Hello world! 👋';
  }
}

export default registerWebModule(ExpoIosPushProvisioningModule);
