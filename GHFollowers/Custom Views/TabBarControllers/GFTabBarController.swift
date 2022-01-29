//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Dastan Zhapay on 06.01.2022.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchVC(), createFavoriteVC()]
    }
    
    func createSearchVC() -> UINavigationController{
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoriteVC() -> UINavigationController{
        let favoriteListVC = FavoriteListVC()
        favoriteListVC.title = "Favorite"
        favoriteListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoriteListVC)
    }
}
