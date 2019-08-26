//
//  LoginViewModel.swift
//  RxLogin
//
//  Created by Kang Seongchan on 26/08/2019.
//  Copyright © 2019 fitpet. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol LoginViewBindable {
    var loginBtnTouched:PublishRelay<Void> { get }
    var idTfValueChanged:PublishRelay<String?> { get }
    var pwTfValueChanged:PublishRelay<String?> { get }
    var loginInfo:PublishSubject<User?> { get }
    
}


class LoginViewModel: LoginViewBindable {
    
    
    var loginInfo: PublishSubject<User?> = PublishSubject<User?>()
    var errorInfo: PublishSubject<String> = PublishSubject<String>()
    
    var loginBtnTouched: PublishRelay<Void> = PublishRelay<Void>()
    
    var idTfValueChanged: PublishRelay<String?> = PublishRelay<String?>()
    
    var pwTfValueChanged: PublishRelay<String?> = PublishRelay<String?>()
    
    let disposeBag = DisposeBag()
    
    var checkLogin:Observable<LoginInfo> {
        return Observable.combineLatest(idTfValueChanged.asObservable(), pwTfValueChanged.asObservable()) {
            id, pw in
            
            return LoginInfo.init(id: id, pw: pw)
        }
    }
    
    init(model:LoginModel = LoginModel()) {
        

        loginBtnTouched.withLatestFrom(checkLogin).flatMapLatest{
            return model.login(info: $0).materialize()
            }.subscribe(onNext: { [unowned self] (event) in
                switch event {
                case .next(let user):
                    self.loginInfo.onNext(user)
                    
                case .error(let error):
                    self.errorInfo.onNext(error.localizedDescription)
                case .completed:
                    print("COMPLTED")
                    
                }
            }).disposed(by: disposeBag)
        
    }
    
    
}


struct LoginInfo {
    
    var id:String?
    var pw:String?
    
}
