//
//  CategoryMenuCollectionViewCell.swift
//  SushiApp
//
//  Created by Georgy on 22.09.2023.
//

import UIKit

class CategoryMenuCollectionViewCell:UICollectionViewCell{
    // MARK: - Variables
    static let reuseId = "CategoryMenuCollectionViewCell"
    
    // MARK: - UI Elements
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let compoundLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vkussovetLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("В корзину", for: .normal)
        button.backgroundColor = UIColor(named: "Sh Blue")
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let contentSubView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = 16
        view.backgroundColor = .black
        view.clipsToBounds = true
        return view
    }()
    
    private let dividerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        label.text = "/"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let pepperImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Pepper")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        self.backgroundColor = .clear
        self.layer.cornerRadius = 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with menu: MenuList){
        let baseURLString = "https://vkus-sovet.ru"
        let imageURLString = baseURLString + menu.image
        imageView.loadImage(from: imageURLString){_ in }
        nameLabel.text = menu.name
        compoundLabel.text = menu.content
        priceLabel.text = menu.price
        
        
        if let price = Double(menu.price) {
            let formattedPrice = String(format: "%.0f ₽", price)
            priceLabel.text = formattedPrice
        } else {
            priceLabel.text = menu.price
        }
        
        if let weight = menu.weight{
            dividerLabel.text = "/"
            weightLabel.text = "\(weight)."
        } else {
            dividerLabel.text = ""
            weightLabel.text = ""
        }
        
        if let spicy = menu.spicy {
            contentSubView.addSubview(pepperImageView)
            NSLayoutConstraint.activate([
                pepperImageView.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -10),
                pepperImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
                pepperImageView.heightAnchor.constraint(equalToConstant: 16),
                pepperImageView.widthAnchor.constraint(equalToConstant: 16),
            ])
        } else{
            pepperImageView.removeFromSuperview()
        }

    }
}

// MARK: - Layout
extension CategoryMenuCollectionViewCell{
    private func addSubviews() {
        addSubview(contentSubView)
        contentSubView.addSubview(nameLabel)
        contentSubView.addSubview(compoundLabel)
        contentSubView.addSubview(stackView)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(dividerLabel)
        stackView.addArrangedSubview(weightLabel)
        contentSubView.addSubview(imageView)
        addSubview(addButton)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            contentSubView.topAnchor.constraint(equalTo: topAnchor),
            contentSubView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentSubView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentSubView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            
            nameLabel.topAnchor.constraint(equalTo: contentSubView.topAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -5),
            nameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 5),
            
            compoundLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            compoundLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            compoundLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -5),
            compoundLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 5),
            
            imageView.bottomAnchor.constraint(equalTo: contentSubView.bottomAnchor),
            imageView.heightAnchor.constraint(equalTo: contentSubView.heightAnchor, multiplier: 0.5),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            
            stackView.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -10),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            addButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}

