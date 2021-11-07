//
//  InputValidation.swift
//  Login-Validation-RxSwift
//
//  Created by Mac on 05/11/21.
//

import Foundation

struct InputValidationService {

    static func validateFirstName(_ name: String?) throws -> String {
        guard let name = name else { throw ValidationError.firstNameMustBeEnter }
        guard name.count != 0 else { throw ValidationError.firstNameMustBeEnter }
        guard name.count > 1 else { throw ValidationError.firstNameTooShort }
        guard name.count < 20 else { throw ValidationError.firstNameTooLong }
        return name
    }

    static func validateLastName(_ name: String?) throws -> String {
        guard let name = name else { throw ValidationError.lastNameMustBeEnter }
        guard name.count != 0 else { throw ValidationError.lastNameMustBeEnter }
        guard name.count > 1 else { throw ValidationError.lastNameTooShort }
        guard name.count < 20 else { throw ValidationError.lastNameTooLong }
        return name
    }

    static func validateEmail(_ email: String?) throws -> String {
        guard let email = email else { throw ValidationError.emailMustBeEnter }
        guard email.count != 0 else { throw ValidationError.emailMustBeEnter }
        guard email.isValidEmail() else { throw ValidationError.emailNotValid }
        return email
    }

    static func validateCountry(_ country: String?) throws -> String {
        guard let country = country else { throw ValidationError.countryMustBeEnter }
        guard country.count != 0 else { throw ValidationError.countryMustBeEnter }
        guard country.count > 2 else { throw ValidationError.countryTooShort }
        return country
    }

    static func validateZipCode(_ zipCode: String?) throws -> String {
        guard
            let zipCodeUnwrapped = zipCode,
            let zipCode = Int(zipCodeUnwrapped)
        else { throw ValidationError.zipCodeMustBeNumeric }
        guard zipCode > 999999 else { throw ValidationError.zipCodeMustBeEnter }
        return String(zipCode)
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
