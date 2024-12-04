export type OnLoadEventPayload = {
  url: string;
};

export type ExpoIosPushProvisioningModuleEvents = {
  onChange: (params: ChangeEventPayload) => void;
};

export type ChangeEventPayload = {
  value: string;
};

export type ExpoIosPushProvisioningViewProps = {};
