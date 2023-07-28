//
//  BaseCollectionViewController.swift
//  AlefTestApp
//
//  Created by Илья Казначеев on 28.07.2023.
//

import UIKit


class BaseCollectionViewController: UICollectionViewController {
    
    override func loadView() {
        super.loadView()
        
        setupViews()
        constraintViews()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAppearance()
    }
}

@objc extension BaseCollectionViewController {
    
    func setupViews() { }
    func constraintViews() { }
    
    func configureAppearance() {
        view.backgroundColor = R.Colors.background
    }
}
