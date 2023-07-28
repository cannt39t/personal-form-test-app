//
//  AFChildrenDataCell.swift
//  AlefTestApp
//
//  Created by Илья Казначеев on 28.07.2023.
//

import UIKit

final class AFChildrenDataCell: BaseCollectionViewCell {
    
    let nameTextField: AFTextField = {
        let textField = AFTextField()
        textField.setup(placeHolder: "Имя", keyboardType: .default, text: "")
        return textField
    }()
    
    let ageTextField: AFTextField = {
        let textField = AFTextField()
        textField.setup(placeHolder: "Возраст", keyboardType: .numberPad, text: "")
        return textField
    }()
    
    private let deleteButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("Удалить", for: .normal)
        button.setTitleColor(R.Colors.primary, for: .normal)
        button.titleLabel?.font = R.Fonts.defaultFont(15)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()
    
    private var completion: () -> Void = { }
    
    func setup(name: String, age: Int, with completion: @escaping () -> Void) {
        self.nameTextField.textField.text = name
        self.ageTextField.textField.text = "\(age)"
        self.completion = completion
    }
    
    @objc func deleteHandle() {
        completion()
    }
}

extension AFChildrenDataCell {
    
    override func setupViews() {
        super.setupViews()
        
        setupView(deleteButton)
        setupView(stackView)
        
        [
            nameTextField,
            ageTextField
        ].forEach { stackView.addArrangedSubview($0) }
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: centerXAnchor),
            
            deleteButton.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 16),
            deleteButton.centerYAnchor.constraint(equalTo: nameTextField.centerYAnchor)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        deleteButton.addTarget(self, action: #selector(deleteHandle), for: .touchUpInside)
    }
}
