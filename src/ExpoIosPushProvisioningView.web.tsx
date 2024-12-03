import * as React from 'react';

import { ExpoIosPushProvisioningViewProps } from './ExpoIosPushProvisioning.types';

export default function ExpoIosPushProvisioningView(props: ExpoIosPushProvisioningViewProps) {
  return (
    <div>
      <iframe
        style={{ flex: 1 }}
        src={props.url}
        onLoad={() => props.onLoad({ nativeEvent: { url: props.url } })}
      />
    </div>
  );
}
