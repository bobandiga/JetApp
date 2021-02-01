//
//  BaseView.swift
//  App
//
//  Created by Максим Шаптала on 01.02.2021.
//

import UIKit

class BaseView: UIScrollView {
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isScrollEnabled = false
        
        guard let layer = self.layer as? CAGradientLayer else { return }
        layer.colors = [UIColor.white.cgColor, UIColor.lightGray.cgColor]
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
