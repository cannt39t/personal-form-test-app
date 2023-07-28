//
//  UICollectionReusableView + ext.swift
//  AlefTestApp
//
//  Created by Илья Казначеев on 28.07.2023.
//

import UIKit

extension UICollectionReusableView {
    
    static var identifier: String {
        .init(describing: self)
    }
}
