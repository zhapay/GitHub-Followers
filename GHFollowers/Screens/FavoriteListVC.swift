//
//  FavoriteListVC.swift
//  GHFollowers
//
//  Created by Dastan Zhapay on 14.11.2021.
//

import UIKit

class FavoriteListVC: GFDataLoadingVC {
    
    let tableView = UITableView()
    var favorites: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    func configureViewController() {
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Favorites"
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80
        tableView.frame = view.bounds
        tableView.removeTableViewCells()
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.cellId)
    }
    
    func getFavorites() {
        PersistanceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    self.showMessageLabel(message: "No Favorites?\nAdd one on the follower screen", in: self.view)
                } else {
                    DispatchQueue.main.async {
                        self.favorites = favorites
                        self.view.bringSubviewToFront(self.tableView)
                        self.tableView.reloadData()
                    }
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}

extension FavoriteListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.cellId) as! FavoriteCell
        let selectedIndex = favorites[indexPath.row]
        cell.set(favorite: selectedIndex)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = favorites[indexPath.row]
        let destVC = FollowerListVC(username: selectedIndex.login)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let selectedIndex = favorites[indexPath.row]
        
        PersistanceManager.updateWith(favorite: selectedIndex, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            self.presentGFAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "OK")
        }
    }
}
