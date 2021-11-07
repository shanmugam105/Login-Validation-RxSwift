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

    let disposeBag = DisposeBag()

    lazy var loginViewModel = LoginViewModel(disposeBag: disposeBag)

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configInputFields()
        configureSubmitButton()
    }

    func submitButtonTapped() {
        
    }

    private func configureSubmitButton() {
        submitButton.rx.tap.bind(onNext: submitButtonTapped).disposed(by: disposeBag)
        loginViewModel.isValid().bind(to: submitButton.rx.isEnabled).disposed(by: disposeBag)
        loginViewModel.isValid().map { $0 ? 1 : 0.5 }.bind(to: submitButton.rx.alpha).disposed(by: disposeBag)
    }

    private func configInputFields() {
        loginViewModel.validateInputFields(inputText: firstnameTextField.rx.text,
                            subject: loginViewModel.firstNameSubject,
                            validator: InputValidationService.validateFirstName)
        loginViewModel.validateInputFields(inputText: lastnameTextField.rx.text,
                            subject: loginViewModel.lastNameSubject,
                            validator: InputValidationService.validateLastName)
        loginViewModel.validateInputFields(inputText: emailTextField.rx.text,
                            subject: loginViewModel.emailSubject,
                            validator: InputValidationService.validateEmail)
        loginViewModel.validateInputFields(inputText: countryTextField.rx.text,
                            subject: loginViewModel.countrySubject,
                            validator: InputValidationService.validateCountry)
        loginViewModel.validateInputFields(inputText: zipcodeTextField.rx.text,
                            subject: loginViewModel.zipcodeSubject,
                            validator: InputValidationService.validateZipCode)
        updateUI()
    }

    private func updateUI() {
        loginViewModel.firstNameSubject.bind(with: firstnameErrorLabel) { label, inputValues in
            label.text = inputValues.message
            label.isHidden = inputValues.valid
        }.disposed(by: disposeBag)

        loginViewModel.lastNameSubject.bind(with: lastnameErrorLabel) { label, inputValues in
            label.text = inputValues.message
            label.isHidden = inputValues.valid
        }.disposed(by: disposeBag)

        loginViewModel.emailSubject.bind(with: emailErrorLabel) { label, inputValues in
            label.text = inputValues.message
            label.isHidden = inputValues.valid
        }.disposed(by: disposeBag)

        loginViewModel.countrySubject.bind(with: countryErrorLabel) { label, inputValues in
            label.text = inputValues.message
            label.isHidden = inputValues.valid
        }.disposed(by: disposeBag)

        loginViewModel.zipcodeSubject.bind(with: zipcodeErrorLabel) { label, inputValues in
            label.text = inputValues.message
            label.isHidden = inputValues.valid
        }.disposed(by: disposeBag)
    }
}
