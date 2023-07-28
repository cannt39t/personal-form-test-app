//
//  AFTextField.swift
//  AlefTestApp
//
//  Created by Илья Казначеев on 28.07.2023.
//

import UIKit


final class AFTextField: BaseView, UITextFieldDelegate {
    
    private let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.Colors.secondaryLabel
        label.font = R.Fonts.defaultFont(15)
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.textColor = R.Colors.label
        textField.font = R.Fonts.defaultFont(17)
        return textField
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .leading
        return stack
    }()
    
    private let tapGestureRecognizer: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTapsRequired = 1
        return tapGesture
    }()
    
    func setup(placeHolder: String, keyboardType: UIKeyboardType, text: String?) {
        placeHolderLabel.text = placeHolder
        textField.keyboardType = keyboardType
        textField.text = text
        textField.delegate = self
    }
    
    func addTapGesture() {
        addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.addTarget(self, action: #selector(handleTap))
    }
    
    @objc private func handleTap() {
        textField.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.keyboardType == .numberPad {
            let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
            let inputCharacterSet = CharacterSet(charactersIn: string)
            return allowedCharacterSet.isSuperset(of: inputCharacterSet)
        }
        
        return true
    }
}


extension AFTextField {
    
    override func setupViews() {
        super.setupViews()
        
        setupView(stackView)
        stackView.addArrangedSubview(placeHolderLabel)
        stackView.addArrangedSubview(textField)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderColor = R.Colors.border.cgColor
        layer.borderWidth = 1
        
        addTapGesture()
    }
}
