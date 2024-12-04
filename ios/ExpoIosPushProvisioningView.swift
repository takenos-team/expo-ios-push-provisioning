import UIKit
import PassKit
import SwiftUI

class ExpoIosPushProvisioningViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupApplePayButton()
    }

    private func setupApplePayButton() {
        let passKitButton = PKAddPassButton(addPassButtonStyle: .blackOutline)
        passKitButton.addTarget(self, action: #selector(onEnroll), for: .touchUpInside)
        view.addSubview(passKitButton)
        passKitButton.translatesAutoresizingMaskIntoConstraints = false
        passKitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        passKitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        passKitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
    }
    
    private func cardInformation() -> Card {
      return Card(panTokenSuffix: "4321", holder: "John Doe")
    }

    private struct Card {
      let panTokenSuffix: String
      let holder: String
    }
    
    private func isPassKitAvailable() -> Bool {
      return PKAddPaymentPassViewController.canAddPaymentPass()
    }
    
    private func showPassKitUnavailable(message: String) {
     let alert = UIAlertController(
       title: "Error",
       message: message,
       preferredStyle: .alert)
     let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
     alert.addAction(action)
     alert.present(alert, animated: true, completion: nil)
    }
    
    private func initEnrollProcess() {
     // Obtenemos la información de la tarjeta
      let card = cardInformation()

     // Construimos el objeto PKAddPaymentPassRequestConfiguration, con la configuración que necesita PKAddPaymentPassViewController, la vista que delegamos en la aplicación Wallet.

      guard let configuration = PKAddPaymentPassRequestConfiguration(encryptionScheme: .ECC_V2) else {
        showPassKitUnavailable(
          message: "Apple Pay no está disponible para tu dispositivo por el momento")
        return
      }

      configuration.cardholderName = card.holder
      configuration.primaryAccountSuffix = card.panTokenSuffix

      // El delegate es el encargado de manejar los subsiguientes llamados de Apple.
      guard
        let enrollViewController = PKAddPaymentPassViewController(
          requestConfiguration: configuration, delegate: self)
      else {
        showPassKitUnavailable(
          message: "Apple Pay no está disponible para tu dispositivo. Ocurrió un error al configurarlo")
        return
      }
    // Presentamos la vista de enrollment de Apple Pay al usuario
      present(enrollViewController, animated: true, completion: nil)
    }
    
    @objc private func onEnroll(button: UIButton) {
      //    También puedes evitar mostrar el botón para que el usuario no lo presione.
      guard isPassKitAvailable() else {
        showPassKitUnavailable(message: "Apple Pay no está disponible para tu dispositivo")
        return
      }
    }
}

extension ExpoIosPushProvisioningViewController: PKAddPaymentPassViewControllerDelegate {
    // Listener para contactar al backend y obtener la información que generamos desde Pomelo.
    func addPaymentPassViewController(
        _ controller: PKAddPaymentPassViewController,
        generateRequestWithCertificateChain certificates: [Data],
        nonce: Data, nonceSignature: Data,
        completionHandler handler: @escaping (PKAddPaymentPassRequest) -> Void
    ) {
        let request = IssuerRequest(
           certificates: certificates, nonce: nonce, nonceSignature: nonceSignature,
           cardId: "crd-1234567890")

         let interactor = GetPassKitDataIssuerHostInteractor()
         interactor.execute(request: request) { response in
           // A partir de la respuesta que te damos desde Pomelo, construimos el objeto PKAddPaymentRequest, el cual enviaremos a Apple para que continúe con el flujo con la marca de la tarjeta.
           let request = PKAddPaymentPassRequest()
           request.activationData = response.activationData
           request.ephemeralPublicKey = response.ephemeralPublicKey
           request.encryptedPassData = response.encryptedPassData
           handler(request)
         }
    }
    
    func addPaymentPassViewController(
      _ controller: PKAddPaymentPassViewController,
      didFinishAdding pass: PKPaymentPass?,
      error: Error?
    ) {

      if let _ = pass {
        print("Se pudo agregar la tarjeta a Apple Pay")
      } else {
        print("Ocurrió un error y no se pudo agregar la tarjeta a Apple Pay")
      }
    }

    struct IssuerRequest {
      let certificates: [Data]
      let nonce: Data
      let nonceSignature: Data
      let cardId: String
    }

    struct IssuerResponse {
      let activationData: Data
      let ephemeralPublicKey: Data
      let encryptedPassData: Data
    }

    private class GetPassKitDataIssuerHostInteractor {
      func execute(request: IssuerRequest, onFinish: (IssuerResponse) -> Void) {
        let response = IssuerResponse(
          activationData: Data(),
          ephemeralPublicKey: Data(),
          encryptedPassData: Data())
        onFinish(response)
      }
    }
    }
