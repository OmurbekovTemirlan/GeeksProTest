//
//  BaseView.swift
//  GeeksProTest
//
//  Created by Apple on 25.5.2024.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        setupAdd()
        setupLayouts()
    }
    
    func setupAdd() { }
    
    func setupLayouts() { }
    
}
