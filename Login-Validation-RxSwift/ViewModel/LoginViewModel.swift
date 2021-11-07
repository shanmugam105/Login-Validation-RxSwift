//
//  LoginViewModel.swift
//  Login-Validation-RxSwift
//
//  Created by Mac on 07/11/21.
//

import Foundation
import RxSwift
import RxCocoa

typealias InputValidator = (_ name: String?) throws -> String

class LoginViewModel {
    let firstNameSubject    = PublishSubject<InputValues>()
    let lastNameSubject     = PublishSubject<InputValues>()
    let emailSubject        = PublishSubject<InputValues>()
    let countrySubject      = PublishSubject<InputValues>()
    let zipcodeSubject      = PublishSubject<InputValues>()
    var disposeBag = DisposeBag()

    init(disposeBag: DisposeBag) {
        self.disposeBag = disposeBag
    }
    
    func isValid() -> Observable<Bool> {
        let allValidObserver = Observable.combineLatest(firstNameSubject,
                                                        lastNameSubject,
                                                        emailSubject,
                                                        countrySubject,
                                                        zipcodeSubject) { (firstname, lastname, email, country, zipcode) -> Bool in
            return firstname.valid && lastname.valid && email.valid && country.valid && zipcode.valid
        }.startWith(false)
        return allValidObserver
    }
    func validateInputFields(inputText: ControlProperty<String?>,
                             subject: PublishSubject<InputValues>,
                             validator: @escaping InputValidator) {
        let tempSubject = PublishSubject<InputValues>()
        inputText
            .orEmpty
            .subscribe { tempSubject.onNext(InputValues(value: $0)) }
            .disposed(by: disposeBag)

        tempSubject
            .map { try validator($0.value) }
            .catch {
                subject.onNext(InputValues(value: "", valid: false, error: $0.localizedDescription))
                throw $0
            }
            .retry()
            .subscribe { inputValues in
                subject.onNext(InputValues(value: inputValues.element ?? "", valid: true))
            }
            .disposed(by: disposeBag)
    }
}
