//
//  CategoryCollectionViewCell.swift
//  SushiApp
//
//  Created by Georgy on 22.09.2023.
//

import UIKit

class CategoryCollectionViewCell:UICollectionViewCell{
    // MARK: - Variables
    static let reuseId = "CategoryCollectionViewCell"
    
    override var isSelected: Bool{
        didSet{
            self.layoutIfNeeded()
        }
    }
    // MARK: - UI Elements
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vkussovetLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        applyConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.backgroundColor = isSelected ? UIColor(named: "Sh Blue"):UIColor(named: "Sh CategoryCellBackground")
        self.layer.cornerRadius = 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with category: CategoryMenuList){
        let baseURLString = "https://vkus-sovet.ru"
        let imageURLString = baseURLString + category.image
        imageView.loadImage(from: imageURLString){_ in }
        nameLabel.text = category.name
        countLabel.text = "\(category.subMenuCount) товаров"
    }
}

// MARK: - Layout
extension CategoryCollectionViewCell{
    private func addSubviews() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(countLabel)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -5),
            nameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 5),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            countLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            countLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
