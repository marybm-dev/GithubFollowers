//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Mary Baptista Martinez on 6/24/22.
//

import UIKit

class FollowerListVC: GFDataLoadingVC {
  enum Section { case main }

  var username: String
  var followers = [Follower]()
  var filteredFollowers = [Follower]()
  var page = 1
  var hasMoreFollowers = true
  var isSearching = false
  var isLoadingMoreFollowers = false

  var collectionView: UICollectionView!
  var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

  init(username: String) {
    self.username = username
    super.init(nibName: nil, bundle: nil)
    title = username
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureCollectionView()
    getFollowers(for: username, page: page)
    configureDataSource()
    configureSearchController()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = false
    accessibilityLabel = "user \(username)'s followers"
  }

  func configureViewController() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true

    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    navigationItem.rightBarButtonItem = addButton
  }

  func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout.makeThreeColumnLayout(in: view))
    view.addSubview(collectionView)
    collectionView.backgroundColor = .systemBackground
    collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    collectionView.delegate = self
  }

  func configureSearchController() {
    let searchController = UISearchController()
    searchController.searchResultsUpdater = self
    searchController.searchBar.placeholder = "Search for a username"
    navigationItem.searchController = searchController
  }

  func getFollowers(for username: String, page: Int) {
    showLoadingView()
    isLoadingMoreFollowers = true
    NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
      guard let self = self else { return }
      self.dismissLoadingView()

      switch result {
      case .success(let followers):
        self.updateUI(with: followers)

      case .failure(let error):
        self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
      }

      self.isLoadingMoreFollowers = false
    }
  }

  func updateUI(with followers: [Follower]) {
    if followers.count < 100 { self.hasMoreFollowers = false }
    self.followers.append(contentsOf: followers)

    if self.followers.isEmpty {
      let message = "This user doesn't have any followers. Go follow them ????"
      DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
      return
    }

    self.updateData(on: self.followers)
  }

  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
      cell.set(follower: itemIdentifier)
      return cell
    })
  }

  func updateData(on followers: [Follower]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
    snapshot.appendSections([.main])
    snapshot.appendItems(followers)
    DispatchQueue.main.async {
      self.dataSource.apply(snapshot, animatingDifferences: UIView.shouldAnimate)
    }
  }

  @objc func addButtonTapped() {
    showLoadingView()

    NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
      guard let self = self else { return }
      self.dismissLoadingView()

      switch result {
      case .success(let user):
        self.addUserToFavorites(user: user)

      case .failure(let error):
        self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
      }
    }
  }

  func addUserToFavorites(user: User) {
    let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)

    PersistenceManager.update(with: favorite, actionType: .add) { [weak self] error in
      guard let self = self else { return }
      guard let error = error else {
        self.presentGFAlertOnMainThread(title: "Success!", message: "You have successfully favorited this user ????", buttonTitle: "Hooray!")
        return
      }
      self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
    }
  }
}


extension FollowerListVC: UICollectionViewDelegate {

  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let height = scrollView.frame.size.height

    if offsetY > contentHeight - height {
      guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
      page += 1
      getFollowers(for: username, page: page)
    }
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let activeArray = isSearching ? filteredFollowers : followers
    let follower = activeArray[indexPath.item]

    let destinationVC = UserInfoVC()
    destinationVC.username = follower.login
    destinationVC.delegate = self
    let navController = UINavigationController(rootViewController: destinationVC)
    present(navController, animated: UIView.shouldAnimate)
  }
}

extension FollowerListVC: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) {
    guard let filter = searchController.searchBar.text, !filter.isEmpty else {
      filteredFollowers.removeAll()
      updateData(on: followers)
      isSearching = false
      return
    }
    isSearching = true
    filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
    updateData(on: filteredFollowers)
  }
}

extension FollowerListVC: UserInfoVCDelegate {

  func didRequestFollwers(for username: String) {
    self.username = username
    title = username
    page = 1
    followers.removeAll()
    filteredFollowers.removeAll()
    getFollowers(for: username, page: page)
  }
}
