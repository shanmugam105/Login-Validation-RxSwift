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
        var valid: Bool

        internal init(value: String, valid: Bool = false) {
            self.value = value
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

    let firstNameSubject    = PublishSubject<InputValues>()
    let lastNameSubject     = PublishSubject<InputValues>()
    let emailSubject        = PublishSubject<InputValues>()
    let countrySubject      = PublishSubject<InputValues>()
    let zipcodeSubject      = PublishSubject<InputValues>()

    let disposeBag = DisposeBag()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configInputFields()
        configureSubmitButton()
    }

    @objc func submitButtonTapped(_ sender: UIButton) {
        print("Success!")
    }

    private func configureSubmitButton() {
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        let allValidObserver = Observable.combineLatest(firstNameSubject,
                                                        lastNameSubject,
                                                        emailSubject,
                                                        countrySubject,
                                                        zipcodeSubject) { (firstname, lastname, email, country, zipcode) -> Bool in
            return firstname.valid && lastname.valid && email.valid && country.valid && zipcode.valid
        }.startWith(false)

        allValidObserver.bind(to: submitButton.rx.isEnabled).disposed(by: disposeBag)
        allValidObserver.map { $0 ? 1 : 0.5 }.bind(to: submitButton.rx.alpha).disposed(by: disposeBag)
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
        let tempSubject = PublishSubject<InputValues>()
        textField.rx.text
            .orEmpty
            .subscribe { tempSubject.onNext(InputValues(value: $0)) }
            .disposed(by: disposeBag)

        tempSubject
            .map { try validator($0.value) }
            .catch {
                errorLabel.isHidden = false
                errorLabel.text = $0.localizedDescription
                subject.onNext(InputValues(value: "", valid: false))
                throw $0
            }
            .retry()
            .subscribe { inputValues in
                errorLabel.isHidden = true
                subject.onNext(InputValues(value: inputValues.element!, valid: true))
            }
            .disposed(by: disposeBag)
    }
}
