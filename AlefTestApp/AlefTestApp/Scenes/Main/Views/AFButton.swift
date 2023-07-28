//
//  AFButton.swift
//  AlefTestApp
//
//  Created by Илья Казначеев on 28.07.2023.
//

import UIKit

enum AFButtonType {
    case primary, destructive
}

final class AFButton: BaseButton {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.defaultFont(15)
        return label
    }()
    
    private var image: UIImageView? = nil
    
    private var type: AFButtonType
    private let title: String
    
    init(with type: AFButtonType, imageName: String? = nil, title: String) {
        self.type = type
        self.title = title
        if let imageName {
            let image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
            self.image = UIImageView(image: image)
        }
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AFButton {
    
    override func setupViews() {
        super.setupViews()
        
        if let image {
            setupView(image)
        }
        setupView(nameLabel)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        let horizontalPadding: CGFloat = type == .primary ? 18 : 36
        
        if let image {
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalPadding).isActive = true
            image.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
            nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 6).isActive = true
        } else {
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalPadding).isActive = true
        }

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalPadding),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        switch type {
            case .primary:
                layer.borderColor = R.Colors.primary?.cgColor
                image?.tintColor = R.Colors.primary
                nameLabel.textColor = R.Colors.primary
            case .destructive:
                layer.borderColor = R.Colors.destructive?.cgColor
                image?.tintColor = R.Colors.destructive
                nameLabel.textColor = R.Colors.destructive
        }
        layer.borderWidth = 2
        
        nameLabel.text = title
        image?.contentMode = .scaleAspectFit
        makeSystem(self)
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = self.bounds.height / 2
        layer.masksToBounds = true
    }
}
