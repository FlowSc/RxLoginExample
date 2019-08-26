//
//  User.swift
//  RxLogin
//
//  Created by Kang Seongchan on 26/08/2019.
//  Copyright © 2019 fitpet. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let name:String
    
    init(name:String) {
        self.name = name
    }
}
