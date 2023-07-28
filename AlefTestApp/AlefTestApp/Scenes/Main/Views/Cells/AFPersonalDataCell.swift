//
//  AFPersonalDataCell.swift
//  AlefTestApp
//
//  Created by Илья Казначеев on 28.07.2023.
//

import UIKit


final class AFPersonalDataCell: BaseCollectionViewCell {
    let textField = AFTextField()
    
    func setup(title: String, type: UIKeyboardType, text: String?) {
        textField.setup(placeHolder: title, keyboardType: type, text: text)
    }
}

extension AFPersonalDataCell {
    
    override func setupViews() {
        super.setupViews()
        
        setupView(textField)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
    }
}
