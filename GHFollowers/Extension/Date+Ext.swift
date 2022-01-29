//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Dastan Zhapay on 02.01.2022.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
