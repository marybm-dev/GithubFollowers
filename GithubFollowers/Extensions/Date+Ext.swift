//
//  Date+Ext.swift
//  GithubFollowers
//
//  Created by Mary Baptista Martinez on 7/6/22.
//

import Foundation

extension Date {

  func convertToMonthYear() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM yyy"
    return dateFormatter.string(from: self)
  }

}
