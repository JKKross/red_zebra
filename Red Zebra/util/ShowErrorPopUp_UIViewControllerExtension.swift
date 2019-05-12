import UIKit

extension UIViewController {

    func showErrorPopUp(message: String) {
        
        let alert = UIAlertController(title: "🤔 ERROR 🤷🏽‍♀️", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in return }))
        
        self.present(alert, animated: true)
    }

}
