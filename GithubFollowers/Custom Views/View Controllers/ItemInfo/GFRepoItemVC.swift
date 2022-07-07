//
//  GFRepoItemVC.swift
//  GithubFollowers
//
//  Created by Mary Baptista Martinez on 7/5/22.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }

  private func configureItems() {
    itemInfoViewOne.set(.repos, withCount: user.publicRepos)
    itemInfoViewTwo.set(.gists, withCount: user.publicGists)
    actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
  }

  override func actionButtonTapped() {
    delegate.didTapGitHubProfile(for: user)
  }
}
