//
//  UIView_Extension.swift
//  RxLogin
//
//  Created by Kang Seongchan on 26/08/2019.
//  Copyright © 2019 fitpet. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
    
    var safeArea: ConstraintBasicAttributesDSL {
        
        #if swift(>=3.2)
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        }
        return self.snp
        #else
        return self.snp
        #endif
    }
    
    func addSubviews(_ views: [UIView]) {
        
        _ = views.map { self.addSubview($0) }
    }
    
    func setBorder(color: UIColor, width: CGFloat, cornerRadius: CGFloat = 0) {
        
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
}



