import { ExpoIosPushProvisioningView } from 'expo-ios-push-provisioning';
import { SafeAreaView, Text } from 'react-native';

export default function App() {
  return <SafeAreaView>
    <Text>Test Takenos</Text>
    <ExpoIosPushProvisioningView cardInformation={{ panTokenSuffix: '1234', holder: 'John Doe' }} style={{height: 200, flex: 1}}/>
  </SafeAreaView>
}