import { requireNativeView } from 'expo';
import * as React from 'react';

import { ExpoIosPushProvisioningViewProps } from './ExpoIosPushProvisioning.types';

const NativeView: React.ComponentType<ExpoIosPushProvisioningViewProps> =
  requireNativeView('ExpoIosPushProvisioning');

export default function ExpoIosPushProvisioningView(props: ExpoIosPushProvisioningViewProps) {
  return <NativeView {...props} />;
}
