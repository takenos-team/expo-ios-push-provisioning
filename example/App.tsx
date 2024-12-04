import { ExpoIosPushProvisioningView } from 'expo-ios-push-provisioning';
import { SafeAreaView, Text } from 'react-native';

export default function App() {
  return <SafeAreaView>
    <Text>Test Takenos</Text>
    <ExpoIosPushProvisioningView />
  </SafeAreaView>
}