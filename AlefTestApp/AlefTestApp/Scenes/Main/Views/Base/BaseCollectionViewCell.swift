//
//  BaseCollectionViewCell.swift
//  AlefTestApp
//
//  Created by Илья Казначеев on 28.07.2023.
//

import UIKit


class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        constraintViews()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@objc extension BaseCollectionViewCell {
    
    func setupViews() { }
    func constraintViews() { }
    
    func configureAppearance() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        let lightView = UIView(frame: bounds)
        lightView.backgroundColor = R.Colors.background
        backgroundView = lightView
        
        let grayView = UIView(frame: bounds)
        grayView.backgroundColor = .lightGray.withAlphaComponent(0.25)
        selectedBackgroundView = grayView
    }
}

