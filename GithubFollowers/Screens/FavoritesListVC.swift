//
//  FavoritesListVC.swift
//  GithubFollowers
//
//  Created by Mary Baptista Martinez on 6/24/22.
//

import UIKit

class FavoritesListVC: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBlue
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(UIView.shouldAnimate)

    PersistenceManager.retrieveFavorites { result in
      switch result {
      case .success(let favorites):
        favorites.forEach { print($0.login) }
      case .failure(let error):
        break
      }
    }
  }
}
