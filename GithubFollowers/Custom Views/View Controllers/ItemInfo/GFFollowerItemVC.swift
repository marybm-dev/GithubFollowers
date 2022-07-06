//
//  GFFollowerItemVC.swift
//  GithubFollowers
//
//  Created by Mary Baptista Martinez on 7/5/22.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }

  private func configureItems() {
    itemInfoViewOne.set(.followers, withCount: user.followers)
    itemInfoViewTwo.set(.following, withCount: user.following)
    actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
  }
}
