//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Mary Baptista Martinez on 6/24/22.
//

import UIKit

class FollowerListVC: UIViewController {

  var username: String!
  var collectionView: UICollectionView!

  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureCollectionView()
    getFollowers()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = false
  }

  func configureViewController() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
  }

  func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewLayout())
    view.addSubview(collectionView)
    collectionView.backgroundColor = .systemPink
    collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
  }

  func getFollowers() {
    NetworkManager.shared.getFollowers(for: username, page: 1) { result in
      switch result {
      case .success(let followers):
        print(followers)

      case .failure(let error):
        self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
      }
    }
  }
}
