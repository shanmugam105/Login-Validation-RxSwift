//
//  LocalizedError.swift
//  Login-Validation-RxSwift
//
//  Created by Mac on 05/11/21.
//

import Foundation

enum ValidationError: LocalizedError {
    case invalidValue
    case passwordTooLong
    case passwordTooShort
    case firstNameTooLong
    case firstNameTooShort
    case invalidCredentials
    case firstNameMustBeEnter
    case lastNameMustBeEnter
    case lastNameTooLong
    case lastNameTooShort
    case middleNameMustBeEnter
    case middleNameTooLong
    case middleNameTooShort
    case emailMustBeEnter
    case emailNotValid
    case passwordMustBeEnter
    case confirmPasswordMustBeEnter
    case passwordNotSame
    case weakPassword
    case ageNotAllowed
    case address1MustBeEnter
    case address1TooShort
    case address2MustBeEnter
    case address2TooShort
    case cityMustBeEnter
    case cityTooShort
    case stateMustBeEnter
    case stateTooShort
    case countryMustBeEnter
    case countryTooShort
    case zipCodeMustBeEnter
    case zipCodeMustBeNumeric
    case genderMustBeSelected
    case ageMustBeNumeric

    var errorDescription: String? {
        switch self {
        case .invalidValue:
            return "You have entered an invalid value."
        case .passwordTooLong:
            return "Your password is too long."
        case .passwordTooShort:
            return "Your password is too short."
        case .firstNameTooLong:
            return "Your first name is too long."
        case .firstNameTooShort:
            return "Your first name is too short."
        case .invalidCredentials:
            return "Incorrect username or password. Please try again."
        case .firstNameMustBeEnter:
            return "Please enter the first name."
        case .lastNameMustBeEnter:
            return "Please enter the last name."
        case .middleNameMustBeEnter:
            return "Please enter the middle name."
        case .emailMustBeEnter:
            return "Please enter the email."
        case .emailNotValid:
            return "Please enter the valid email."
        case .passwordMustBeEnter:
            return "Please enter the passowrd."
        case .confirmPasswordMustBeEnter:
            return "Please enter the confirm passowrd."
        case .passwordNotSame:
            return "Please enter the same passowrd for confirm password."
        case .weakPassword:
            return "Please enter the least one uppercase, least one digit, least one lowercase, least one symbol and min 8 characters total."
        case .ageNotAllowed:
            return "Age need to be over the 18."
        case .address1MustBeEnter:
            return "Address 1 must be enter."
        case .cityMustBeEnter:
            return "City must be enter."
        case .stateMustBeEnter:
            return "State must be enter."
        case .countryMustBeEnter:
            return "Country must be enter."
        case .zipCodeMustBeEnter:
            return "Zip code must be enter."
        case .genderMustBeSelected:
            return "Gender must be selected."
        case .zipCodeMustBeNumeric:
            return "Zip code must be a number."
        case .address1TooShort:
            return "Address 1 is too short."
        case .address2MustBeEnter:
            return "Address 2 is too short."
        case .address2TooShort:
            return "Address 2 must be enter."
        case .cityTooShort:
            return "City is too short."
        case .stateTooShort:
            return "State is too short."
        case .countryTooShort:
            return "Country is too short."
        case .ageMustBeNumeric:
            return "Age must be number."
        case .lastNameTooLong:
            return "Your last name is too long."
        case .lastNameTooShort:
            return "Your last name is too short."
        case .middleNameTooLong:
            return "Your middle name is too long."
        case .middleNameTooShort:
            return "Your middle name is too short."
        }
    }
}
