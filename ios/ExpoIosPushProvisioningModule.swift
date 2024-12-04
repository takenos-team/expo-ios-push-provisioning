import ExpoModulesCore

public class ExpoIosPushProvisioningModule: Module {
    public func definition() -> ModuleDefinition {
        Name("ExpoIosPushProvisioning")

        View(ExpoIosPushProvisioningView.self) {
            // Add any props here if needed
        }
    }
}