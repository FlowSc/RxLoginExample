//
//  LoginModel.swift
//  RxLogin
//
//  Created by Kang Seongchan on 26/08/2019.
//  Copyright © 2019 fitpet. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct LoginModel {
    
    func login(info:LoginInfo) -> Observable<User> {
        
        return Observable.create({ (observer) -> Disposable in

            print("LOGIN!")
            
            observer.onNext(User(name: info.id ?? ""))
            
            return Disposables.create()

        })
        
    }
    
}
