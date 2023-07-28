//
//  AFFooter.swift
//  AlefTestApp
//
//  Created by Илья Казначеев on 28.07.2023.
//

import UIKit

final class AFFooter: BaseCollectionReusableView {
    private var additionalButton = AFButton(with: .destructive, title: R.Strings.Buttons.clearData)
    private var completion: () -> Void = {  }
    
    func setup(completion: @escaping (() -> Void)) {
        self.completion = completion
        additionalButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    
    @objc func handleTap() {
        completion()
    }
}

extension AFFooter {
    
    override func setupViews() {
        super.setupViews()
        
        setupView(additionalButton)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            additionalButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            additionalButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            additionalButton.topAnchor.constraint(equalTo: topAnchor),
            additionalButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
    }
}
