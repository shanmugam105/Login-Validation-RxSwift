//
//  InputValidation.swift
//  Login-Validation-RxSwift
//
//  Created by Mac on 05/11/21.
//

import Foundation

struct InputValidationService {

    func validateFirstName(_ name: String?) throws -> String {
        guard let name = name else { throw ValidationError.firstNameMustBeEnter }
        guard name.count != 0 else { throw ValidationError.firstNameMustBeEnter }
        guard name.count > 1 else { throw ValidationError.firstNameTooShort }
        guard name.count < 20 else { throw ValidationError.firstNameTooLong }
        return name
    }

    func validateLastName(_ name: String?) throws -> String {
        guard let name = name else { throw ValidationError.lastNameMustBeEnter }
        guard name.count != 0 else { throw ValidationError.lastNameMustBeEnter }
        guard name.count > 1 else { throw ValidationError.lastNameTooShort }
        guard name.count < 20 else { throw ValidationError.lastNameTooLong }
        return name
    }

    func validateMiddleName(_ name: String?) throws -> String {
        guard let name = name else { throw ValidationError.middleNameMustBeEnter }
        guard name.count != 0 else { throw ValidationError.middleNameMustBeEnter }
        guard name.count > 1 else { throw ValidationError.middleNameTooShort }
        guard name.count < 20 else { throw ValidationError.middleNameTooLong }
        return name
    }

    func validateGender(_ gender: String?) throws -> String {
        guard let gender = gender else { throw ValidationError.genderMustBeSelected }
        return gender
    }

    func validateEmail(_ email: String?) throws -> String {
        guard let email = email else { throw ValidationError.emailMustBeEnter }
        guard email.count != 0 else { throw ValidationError.emailMustBeEnter }
        guard email.isValidEmail() else { throw ValidationError.emailNotValid }
        return email
    }

    func validatePassword(_ password: String?) throws -> String {
        guard let password = password else { throw ValidationError.passwordMustBeEnter }
        guard password.count != 0 else { throw ValidationError.passwordMustBeEnter }
        guard password.count > 8 else { throw ValidationError.weakPassword }
        guard password.count < 20 else { throw ValidationError.passwordTooLong }
        guard password.isValidPassword() else { throw ValidationError.weakPassword }
        return password
    }

    func validateConfirmPassword(_ password: String?, _ confirmPassword: String?) throws -> String {
        guard let password = password else { throw ValidationError.confirmPasswordMustBeEnter }
        guard password.count != 0 else { throw ValidationError.confirmPasswordMustBeEnter }
        guard password == confirmPassword else { throw ValidationError.passwordNotSame }
        return password
    }

    func validateIsAgeAllowed(_ date: Date?) throws -> Date {
        guard let date = date else { throw ValidationError.ageNotAllowed }
        guard date.validateAgeIsAllowed() else { throw ValidationError.ageNotAllowed }
        return date
    }

    func validateAddress1(_ address: String?) throws -> String {
        guard let address = address else { throw ValidationError.address1MustBeEnter }
        guard address.count != 0 else { throw ValidationError.address1MustBeEnter }
        guard address.count > 2 else { throw ValidationError.address1TooShort }
        return address
    }

    func validateAddress2(_ address: String?) throws -> String {
        guard let address = address else { throw ValidationError.address2MustBeEnter }
        guard address.count != 0 else { throw ValidationError.address2MustBeEnter }
        guard address.count > 2 else { throw ValidationError.address2TooShort }
        return address
    }

    func validateCity(_ city: String?) throws -> String {
        guard let city = city else { throw ValidationError.address2MustBeEnter }
        guard city.count != 0 else { throw ValidationError.address2MustBeEnter }
        guard city.count > 2 else { throw ValidationError.address2TooShort }
        return city
    }

    func validateState(_ state: String?) throws -> String {
        guard let state = state else { throw ValidationError.stateMustBeEnter }
        guard state.count != 0 else { throw ValidationError.stateMustBeEnter }
        guard state.count > 2 else { throw ValidationError.stateTooShort }
        return state
    }

    func validateCountry(_ country: String?) throws -> String {
        guard let country = country else { throw ValidationError.countryMustBeEnter }
        guard country.count != 0 else { throw ValidationError.countryMustBeEnter }
        guard country.count > 2 else { throw ValidationError.countryTooShort }
        return country
    }

    func validateZipCode(_ zipCode: String?) throws -> String {
        guard let zipCode = Int(zipCode!) else { throw ValidationError.zipCodeMustBeNumeric }
        guard zipCode > 9999 else { throw ValidationError.zipCodeMustBeEnter }
        return String(zipCode)
    }

    func validateAge(_ age: String?) throws -> Int {
        guard let age = Int(age!) else { throw ValidationError.ageMustBeNumeric }
        return age
    }
}

extension Date {
    fileprivate func validateAgeIsAllowed() -> Bool {
        var isValid: Bool = true

        // Age of 18.
        let MINIMUM_AGE: Date = Calendar.current.date(byAdding: .year, value: -18, to: Date())!

        // Age of 100.
        let MAXIMUM_AGE: Date = Calendar.current.date(byAdding: .year, value: -100, to: Date())!

        if self < MAXIMUM_AGE || self > MINIMUM_AGE {
            isValid = false
        }

        return isValid
    }
}

extension String {
    fileprivate func isValidPassword() -> Bool {
        // least one uppercase,
        // least one digit
        // least one lowercase
        // least one symbol
        //  min 8 characters total
        let password = self.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@", passwordRegx)
        return passwordCheck.evaluate(with: password)

    }

    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
