//
//  UIViewController+Extension.swift
//  Login-Validation-RxSwift
//
//  Created by Mac on 05/11/21.
//

import UIKit

extension UIViewController {
    // MARK: ViewController Instantiation
    static var identifier: String {
        return String(describing: self)
    }

    static var instantiate: UIViewController {
        var viewController: UIViewController = UIViewController()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: .none)

        if #available(iOS 13.0, *) {
            viewController = storyBoard.instantiateViewController(identifier: identifier)
        } else {
            viewController = storyBoard.instantiateViewController(withIdentifier: identifier)
        }
        return viewController
    }

    // MARK: - Present Alert
    private func present(_ dismissableAlert: UIAlertController) {
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
        dismissableAlert.addAction(dismissAction)
        present(dismissableAlert, animated: true)
    }

    func presentAlert(with message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        present(alert)
    }

    func present(_ error: Error) {
        presentAlert(with: error.localizedDescription)
    }
}
