import { ViewStyle } from "react-native";

export type OnLoadEventPayload = {
  url: string;
};

export type ExpoIosPushProvisioningModuleEvents = {
  onChange: (params: ChangeEventPayload) => void;
};

export type ChangeEventPayload = {
  value: string;
};

export type CardInformation = {
  panTokenSuffix: string;
  holder: string;
};

export type ExpoIosPushProvisioningViewProps = {
  cardInformation: CardInformation;
  style?: ViewStyle;
};
