//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by Dastan Zhapay on 08.01.2022.
//

import UIKit

extension UITableView {
    func removeTableViewCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
