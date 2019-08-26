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
    var loginUser:PublishSubject<User?> { get }
    
}


class LoginViewModel: LoginViewBindable {
    
    
    var loginUser: PublishSubject<User?> = PublishSubject<User?>()
    
    var loginBtnTouched: PublishRelay<Void> = PublishRelay<Void>()
    
    var idTfValueChanged: PublishRelay<String?> = PublishRelay<String?>()
    
    var pwTfValueChanged: PublishRelay<String?> = PublishRelay<String?>()
    
    let disposeBag = DisposeBag()
    
    var loginInfo:Observable<LoginInfo> {
        return Observable.combineLatest(idTfValueChanged, pwTfValueChanged) {
            id, pw in
            
            return LoginInfo.init(id: id, pw: pw)
        }
    }
    
    init(model:LoginModel = LoginModel()) {
        

        loginBtnTouched.withLatestFrom(loginInfo).flatMapLatest{
            return model.login(info: $0).materialize()
            }.subscribe(onNext: { [unowned self] (event) in
                switch event {
                case .next(let user):
                    self.loginUser.onNext(user)
                case .error(_):
                    self.loginUser.onNext(nil)
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
