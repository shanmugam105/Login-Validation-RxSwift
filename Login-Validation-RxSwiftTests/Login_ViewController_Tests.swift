//
//  Login_ViewController_Tests.swift
//  Login-Validation-RxSwiftTests
//
//  Created by Mac on 05/11/21.
//

import XCTest
@testable import Login_Validation_RxSwift

class Login_ViewController_Tests: XCTestCase {

    func test_setup_login_viewcontroller() throws {
        // SUT
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        // Assertions
        XCTAssertEqual(sut.navigationItem.title, "Login", "Title not setuped")
        // Outlets
        try test_input_component(textField: sut.firstnameTextField,
                                 placeholder: "First name",
                                 errorLabel: sut.firstnameErrorLabel)
        try test_input_component(textField: sut.lastnameTextField,
                                 placeholder: "Last name",
                                 errorLabel: sut.lastnameErrorLabel)
        try test_input_component(textField: sut.emailTextField,
                                 placeholder: "Email",
                                 errorLabel: sut.emailErrorLabel)
        try test_input_component(textField: sut.countryTextField,
                                 placeholder: "Country",
                                 errorLabel: sut.countryErrorLabel)
        try test_input_component(textField: sut.zipcodeTextField,
                                 placeholder: "Zipcode",
                                 errorLabel: sut.zipcodeErrorLabel)
        XCTAssertEqual(sut.tableView.separatorStyle, .none)
        let submitButton = try XCTUnwrap(sut.submitButton)
        XCTAssertEqual(submitButton.currentTitle, "Submit")
        // XCTAssertEqual(try XCTUnwrap(submitButton.backgroundColor), UIColor.systemBlue)
    }

    private func test_input_component(textField: UITextField, placeholder: String, errorLabel: UILabel) throws {
        let firstnameTextFields = try XCTUnwrap(textField)
        XCTAssertEqual(firstnameTextFields.text, "")
        XCTAssertEqual(firstnameTextFields.placeholder, placeholder)
        let firstnameErrorLabel = try XCTUnwrap(errorLabel)
        XCTAssertEqual(firstnameErrorLabel.isHidden, true)
        XCTAssertEqual(firstnameErrorLabel.text, "Error")
        XCTAssertEqual(firstnameErrorLabel.textColor, .systemRed)
    }

    private func makeSUT() throws -> LoginViewController {
        let bundle: Bundle = Bundle(for: LoginViewController.self)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: bundle)
        let initialViewController = try XCTUnwrap(storyBoard.instantiateInitialViewController() as? UINavigationController)
        let tableViewController = initialViewController.topViewController as? UITableViewController
        return try XCTUnwrap(tableViewController as? LoginViewController)
    }
}
