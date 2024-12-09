import ExpoModulesCore

public class ExpoIosPushProvisioningModule: Module {
    public func definition() -> ModuleDefinition {
        Name("ExpoIosPushProvisioning")

        View(ExpoIosPushProvisioningView.self) {
            Prop("cardInformation") { (view, cardInformation: CardInformation) in
                view.cardInformation = cardInformation
            }
        }
    }
}
