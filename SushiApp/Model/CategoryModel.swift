//
//  CategoryModel.swift
//  SushiApp
//
//  Created by Georgy on 21.09.2023.
//

import Foundation

// MARK: - Category
struct Category: Codable {
    let status: Bool
    let menuList: [CategoryMenuList]
}

// MARK: - CategoryMenuList
struct CategoryMenuList: Codable {
    let menuID, image, name: String
    let subMenuCount: Int
}
