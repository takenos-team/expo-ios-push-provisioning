import { NativeModule, requireNativeModule } from 'expo';

import { ExpoIosPushProvisioningModuleEvents } from './ExpoIosPushProvisioning.types';

declare class ExpoIosPushProvisioningModule extends NativeModule<ExpoIosPushProvisioningModuleEvents> {
  PI: number;
  hello(): string;
  setValueAsync(value: string): Promise<void>;
}

// This call loads the native module object from the JSI.
export default requireNativeModule<ExpoIosPushProvisioningModule>('ExpoIosPushProvisioning');
