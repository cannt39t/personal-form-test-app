//
//  AFHeader.swift
//  AlefTestApp
//
//  Created by Илья Казначеев on 28.07.2023.
//

import UIKit

final class AFHeader: BaseCollectionReusableView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.Colors.label
        label.font = R.Fonts.defaultFont(22, .medium)
        return label
    }()
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    var additionalButton: AFButton? = nil
    private var completion: () -> Void = { }
    
    func setup(_ title: String, completion: (() -> Void)? = nil) {
        titleLabel.text = title
        if tag == 1 {
            additionalButton?.isHidden = true
        }
        if tag == 2 {
            additionalButton?.isHidden = false
            if let compl = completion {
                self.completion = compl
            }
            
            if additionalButton == nil {
                additionalButton = AFButton(with: .primary, imageName: "plus", title: R.Strings.Buttons.addChild)
                additionalButton?.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
                stackView.addArrangedSubview(additionalButton!)
                layoutIfNeeded()
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @objc private func handleButtonTap() {
        completion()
    }
}

extension AFHeader {
    
    override func setupViews() {
        super.setupViews()
        
        stackView.addArrangedSubview(titleLabel)
        setupView(stackView)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
    }
}
