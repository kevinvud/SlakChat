//
//  RoundedButton.swift
//  SlakChat
//
//  Created by PoGo on 10/8/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 3.0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }

    override func awakeFromNib() {
        self.setupView()
    }
    func setupView(){
        self.layer.cornerRadius = cornerRadius
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
}
