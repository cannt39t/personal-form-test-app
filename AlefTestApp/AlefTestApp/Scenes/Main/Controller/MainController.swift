//
//  MainController.swift
//  AlefTestApp
//
//  Created by Илья Казначеев on 28.07.2023.
//

import UIKit

enum AFSection: Int, CaseIterable {
    case personalData, childrenData
    
    enum AFPersonalData: Int {
        case nameTextField, ageTextField
    }
}

final class MainController: BaseCollectionViewController {
    
    private var personalData: AFPerson?
    private var childrenData: [AFPerson] = []
    
    private weak var clearFooter: AFFooter?
    private weak var addHeader: AFHeader?
    
    private weak var nameCell: AFPersonalDataCell?
    private weak var ageCell: AFPersonalDataCell?
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        AFSection.allCases.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = AFSection(rawValue: section) else { return 0 }
        
        switch section {
            case .personalData:
                return 2
            case .childrenData:
                return childrenData.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = AFSection(rawValue: indexPath.section) else { fatalError() }
        
        switch section {
            case .personalData:
                guard let item = AFSection.AFPersonalData(rawValue: indexPath.item) else { fatalError() }
                
                switch item {
                    case .nameTextField:
                        let cell = collectionView.getReuseCell(AFPersonalDataCell.self, indexPath: indexPath)
                        self.nameCell = cell
                        cell.setup(title: "Имя", type: .default, text: personalData?.name)
                        return cell
                    case .ageTextField:
                        let cell = collectionView.getReuseCell(AFPersonalDataCell.self, indexPath: indexPath)
                        self.ageCell = cell
                        cell.setup(title: "Возраст", type: .numberPad, text: "\(personalData?.age ?? 0)" )
                        return cell
                }
            case .childrenData:
                let cell = collectionView.getReuseCell(AFChildrenDataCell.self, indexPath: indexPath)
                let children = childrenData[indexPath.item]
                cell.setup(name: children.name ?? "", age: children.age ?? 0) { [weak self] in
                    guard let self = self else { return }
                    self.saveData()
                    self.childrenData.remove(at: indexPath.item)
                    if self.childrenData.isEmpty {
                        self.clearFooter?.isHidden = true
                    }
                    
                    collectionView.performBatchUpdates({
                        collectionView.deleteItems(at: [indexPath])
                    }) { isDeleted in
                        collectionView.reloadData()
                    }
                }
                return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let section = AFSection(rawValue: indexPath.section) else { fatalError() }
        
        switch section {
            case .personalData:
                let header = collectionView.getReuseSupplementaryView(AFHeader.self, indexPath: indexPath)
                header.tag = 1
                header.setup(R.Strings.Headers.personalData)
                return header
            case .childrenData:
                if kind == AFHeader.identifier {
                    let header = collectionView.getReuseSupplementaryView(AFHeader.self, indexPath: indexPath)
                    header.tag = childrenData.count == 5 ? 1 : 2
                    self.addHeader = header
                    header.setup(R.Strings.Headers.childrenMax) { [weak self] in
                        self?.addChildren()
                    }
                    return header
                } else {
                    let footer = collectionView.getReuseSupplementaryView(AFFooter.self, indexPath: indexPath)
                    self.clearFooter = footer
                    footer.isHidden = childrenData.isEmpty
                    footer.setup { [weak self] in
                        self?.showActionSheet()
                    }
                    return footer
                }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    init() {
        super.init(collectionViewLayout: MainController.createCompositionalLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainController {
    
    override func setupViews() {
        super.setupViews()
    }
    
    override func constraintViews() {
        super.constraintViews()
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        collectionView.register(AFPersonalDataCell.self)
        collectionView.register(AFChildrenDataCell.self)
        
        collectionView.register(AFHeader.self)
        collectionView.register(AFFooter.self)
        
        textFieldsSetup()
    }
}

extension MainController {
    
    private static func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (index, enviroment) -> NSCollectionLayoutSection? in
            return MainController.createSectionFor(index: index, enviroment: enviroment)
        })
        return layout
    }
    
    private static func createSectionFor(index: Int, enviroment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch index {
            case 0:
                return personalDataSection()
            case 1:
                return childrenSection()
            default:
                return personalDataSection()
        }
    }
    
    private static func personalDataSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(48))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: AFHeader.identifier, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private static func childrenSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(167))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(48))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: AFHeader.identifier, alignment: .top)
        
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(48))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: AFFooter.identifier, alignment: .bottom)
        section.boundarySupplementaryItems = [header, footer]
        
        return section
    }
    
    private func addChildren() {
        savePersonalData()
        
        childrenData.append(AFPerson(name: "", age: 0))
        if childrenData.count == 5 {
            addHeader?.additionalButton?.isHidden = true
            addHeader?.tag = 1
        } else {
            addHeader?.additionalButton?.isHidden = false
            addHeader?.tag = 2
        }
        
        clearFooter?.isHidden = false
        
        collectionView.performBatchUpdates({
            let indexPath = IndexPath(item: childrenData.count - 1, section: 1)
            collectionView.insertItems(at: [indexPath])
        }) { isAdded in
            
        }
    }
    
    private func savePersonalData() {
        guard let nameCell = nameCell, let ageCell = ageCell else { return }
        personalData = AFPerson(name: nameCell.textField.textField.text, age: Int(ageCell.textField.textField.text ?? "") ?? nil)
    }
    
    private func showActionSheet() {
        let alertController = UIAlertController(title: nil, message: "Вы уверены, что хотите сбросить данные?", preferredStyle: .actionSheet)
        let resetAction = UIAlertAction(title: "Сбросить данные", style: .destructive) { [weak self] _ in
            self?.resetData()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alertController.addAction(resetAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func resetData() {
        personalData = nil
        childrenData = []
        collectionView.reloadData()
    }
    
    private func saveData() {
        var temp = [AFPerson]()
        for i in 0..<childrenData.count {
            let indexPath = IndexPath(item: i, section: 1)
            let cell = collectionView.cellForItem(at: indexPath) as? AFChildrenDataCell
            let name = cell?.nameTextField.textField.text
            let age = Int(cell?.ageTextField.textField.text ?? "0")
            let personData = AFPerson(name: name, age: age)
            temp.append(personData)
        }
        childrenData = temp
    }
}


extension MainController: UIGestureRecognizerDelegate {
    
    func textFieldsSetup() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
