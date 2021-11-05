//
//  LoginViewController.swift
//  Login-Validation-RxSwift
//
//  Created by Mac on 05/11/21.
//

import UIKit

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

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configInputFields()
    }

    private func configInputFields() {

    }
}
