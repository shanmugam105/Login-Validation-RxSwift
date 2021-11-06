//
//  LoginViewController.swift
//  Login-Validation-RxSwift
//
//  Created by Mac on 05/11/21.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UITableViewController {

    struct InputValues {
        let value: String
        var required: Bool
        var valid: Bool

        internal init(value: String, required: Bool = true, valid: Bool = false) {
            self.value = value
            self.required = required
            self.valid = valid
        }
    }
    private typealias InputValidator = (_ name: String?) throws -> String
    // MARK: - Outlets
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var firstnameErrorLabel: UILabel!

    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var lastnameErrorLabel: UILabel!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!

    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var countryErrorLabel: UILabel!

    @IBOutlet weak var zipcodeTextField: UITextField!
    @IBOutlet weak var zipcodeErrorLabel: UILabel!

    @IBOutlet weak var submitButton: UIButton!

    let firstNameSubject = PublishSubject<InputValues>()
    let lastNameSubject = PublishSubject<InputValues>()
    let emailSubject = PublishSubject<InputValues>()
    let countrySubject = PublishSubject<InputValues>()
    let zipcodeSubject = PublishSubject<InputValues>()

    let disposeBag = DisposeBag()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configInputFields()
    }

    @objc func submitButtonTapped(_ sender: UIButton) {
//        Observable.combineLatest(firstNameSubject,
//                                 lastNameSubject,
//                                 emailSubject,
//                                 countrySubject,
//                                 zipcodeSubject)

    }

    private func configureSubmitButton(with validator: @escaping InputValidator) {
        // submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)

    }

    private func configInputFields() {
        validateInputFields(textField: firstnameTextField,
                            errorLabel: firstnameErrorLabel,
                            subject: firstNameSubject,
                            validator: InputValidationService.validateFirstName)
        validateInputFields(textField: lastnameTextField,
                            errorLabel: lastnameErrorLabel,
                            subject: lastNameSubject,
                            validator: InputValidationService.validateLastName)
        validateInputFields(textField: emailTextField,
                            errorLabel: emailErrorLabel,
                            subject: emailSubject,
                            validator: InputValidationService.validateEmail)
        validateInputFields(textField: countryTextField,
                            errorLabel: countryErrorLabel,
                            subject: countrySubject,
                            validator: InputValidationService.validateCountry)
        validateInputFields(textField: zipcodeTextField,
                            errorLabel: zipcodeErrorLabel,
                            subject: zipcodeSubject,
                            validator: InputValidationService.validateZipCode)
    }

    private func validateInputFields(textField: UITextField,
                                     errorLabel: UILabel,
                                     subject: PublishSubject<InputValues>,
                                     validator: @escaping InputValidator) {
        textField.rx.text
            .orEmpty
            .subscribe { subject.onNext(InputValues(value: $0)) }
            .disposed(by: disposeBag)

        subject
            .map { try validator($0.value) }
            .catch {
                errorLabel.isHidden = false
                errorLabel.text = $0.localizedDescription
                throw $0
            }
            .retry()
            .subscribe { _ in errorLabel.isHidden = true }
            .disposed(by: disposeBag)
    }
}
