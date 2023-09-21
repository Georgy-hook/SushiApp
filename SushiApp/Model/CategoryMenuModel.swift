//
//  CategoryMenuModel.swift
//  SushiApp
//
//  Created by Georgy on 21.09.2023.
//

import Foundation

// MARK: - CategoryMenu
struct CategoryMenu: Codable {
    let status: Bool
    let menuList: [MenuList]
}

// MARK: - MenuList
struct MenuList: Codable {
    let id, image, name, content: String
    let price, weight: String
    let spicy: String?
}

