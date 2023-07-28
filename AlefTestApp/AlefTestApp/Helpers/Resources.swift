//
//  Resources.swift
//  AlefTestApp
//
//  Created by Илья Казначеев on 28.07.2023.
//

import UIKit


enum R {
    
    enum Colors {
        static let background = UIColor(named: "background")
        
        static let primary = UIColor(named: "primary")
        static let destructive = UIColor(named: "destructive")
        static let border = UIColor.lightGray.withAlphaComponent(0.25)
        static let separator = UIColor(named: "separator")
        
        static let label = UIColor(named: "label")
        static let secondaryLabel = UIColor(named: "secondaryLabel")
    }
    
    enum Fonts {
        static func defaultFont(_ size: CGFloat, _ weight: UIFont.Weight = .regular) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: weight)
        }
    }
    
    enum Strings {
        enum Headers {
            static let personalData = "Персональные данные"
            static let childrenMax = "Дети (макс. 5)"
        }
        
        enum Buttons {
            static let addChild = "Добавить ребенка"
            static let clearData = "Очистить"
        }
    }
}
