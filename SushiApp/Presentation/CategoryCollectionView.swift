//
//  CategoryCollectionView.swift
//  SushiApp
//
//  Created by Georgy on 22.09.2023.
//

import UIKit

final class CategoryCollectionView:UICollectionView{
    
    // MARK: - Variables
    private let params = GeometricParams(cellCount: 3, leftInset: 20, rightInset: 0, cellSpacing: 5)
    private var cells: [CategoryMenuList] = []
    weak var delegateVC: ViewControllerProtocol?
    private(set) var title = "" 
    // MARK: - Initiliazation
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseId)
        
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with categoryList: [CategoryMenuList]){
        self.cells = categoryList
        self.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension CategoryCollectionView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseId, for: indexPath) as! CategoryCollectionViewCell
        cell.set(with: cells[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CategoryCollectionView:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegateVC = delegateVC else { return }
        guard let menuID = Int(cells[indexPath.item].menuID) else { return }
        delegateVC.fetchMenu(with: menuID)
        title = cells[indexPath.item].name
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CategoryCollectionView:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: params.leftInset, bottom: 10, right: params.rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        params.cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width - params.paddingWidth
        let cellWidth =  availableWidth / CGFloat(2.7)
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
