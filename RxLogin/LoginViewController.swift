//
//  LoginViewController.swift
//  RxLogin
//
//  Created by Kang Seongchan on 26/08/2019.
//  Copyright © 2019 fitpet. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol BaseViewControllerAttributes {
    func setUI()
    func setAttributes()
    func bindRx()
}


class LoginViewController: UIViewController {
  
    
    let idTf = UITextField()
    let pwTf = UITextField()
    let loginBtn = UIButton()
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setAttributes()
        bindRx()

    }
    
}

extension LoginViewController: BaseViewControllerAttributes {
    
    func bindRx() {
        print("BINDRX")
        
        idTf.rx.text.orEmpty.bind(to: viewModel.idTfValueChanged).disposed(by: disposeBag)
        pwTf.rx.text.orEmpty.bind(to: viewModel.pwTfValueChanged).disposed(by: disposeBag)
        
        loginBtn.rx.tap.bind(to: viewModel.loginBtnTouched).disposed(by: disposeBag)
        
        viewModel.loginInfo.subscribe(onNext: { (user) in
            print(user)
            print("Login SUCCESS")
        }).disposed(by: disposeBag)
    }
    
    func setUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(idTf)
        self.view.addSubview(pwTf)
        self.view.addSubview(loginBtn)
        
        idTf.snp.makeConstraints { (make) in
            
            make.center.equalToSuperview()
            make.leading.equalTo(20)
            make.height.equalTo(30)
        }
        
        pwTf.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(idTf.snp.bottom).offset(20)
            make.leading.height.equalTo(idTf)
        }
        
        loginBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(pwTf.snp.bottom).offset(20)
            make.leading.height.equalTo(idTf)
        }
        
    }
    
    func setAttributes() {
        self.idTf.setBorder(color: .black, width: 1)
        self.pwTf.setBorder(color: .black, width: 1)
        self.loginBtn.setBorder(color: .black, width: 1)
        print("SETATTRIBUTES")
    }
    
    
    
}
