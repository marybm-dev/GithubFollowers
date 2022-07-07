//
//  UIKit+Ext.swift
//  GithubFollowers
//
//  Created by Mary Baptista Martinez on 6/26/22.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIView {

  static var shouldAnimate: Bool { !UIAccessibility.isReduceMotionEnabled }

}

extension UIViewController {

  func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
    DispatchQueue.main.async {
      let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
      alertVC.modalPresentationStyle = .overFullScreen
      alertVC.modalTransitionStyle = .crossDissolve
      self.present(alertVC, animated: true)
    }
  }

  func presentSafariVC(with url: URL) {
    let safariVC = SFSafariViewController(url: url)
    safariVC.preferredControlTintColor = .systemGreen
    present(safariVC, animated: UIView.shouldAnimate)
  }

  func showLoadingView() {
    containerView = UIView(frame: view.bounds)
    view.addSubview(containerView)

    containerView.backgroundColor = .systemBackground
    containerView.alpha = 0
    UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }

    let activityIndicator = UIActivityIndicatorView(style: .large)
    containerView.addSubview(activityIndicator)

    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])

    activityIndicator.startAnimating()
  }

  func dismissLoadingView() {
    DispatchQueue.main.async {
      containerView.removeFromSuperview()
      containerView = nil
    }
  }

  func showEmptyStateView(with message: String, in view: UIView) {
    let emptyStateView = GFEmptyStateView(message: message)
    emptyStateView.frame = view.bounds
    view.addSubview(emptyStateView)
  }
}

extension UICollectionViewFlowLayout {

  static func threeColumns(in view: UIView) -> UICollectionViewFlowLayout {
    let width = view.bounds.width
    let padding: CGFloat = 12
    let minimumItemSpacing: CGFloat = 10
    let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
    let itemWidth = availableWidth / 3

    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    flowLayout.minimumInteritemSpacing = minimumItemSpacing
    flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)

    return flowLayout
  }

}
