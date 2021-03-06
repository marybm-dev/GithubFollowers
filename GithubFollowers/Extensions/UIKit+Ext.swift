//
//  UIKit+Ext.swift
//  GithubFollowers
//
//  Created by Mary Baptista Martinez on 6/26/22.
//

import UIKit
import SafariServices

extension UIView {

  static var shouldAnimate: Bool { !UIAccessibility.isReduceMotionEnabled }
  
  func addSubviews(_ views: UIView...) {
    views.forEach { addSubview($0) }
  }

  func pinToEdges(of superview: UIView) {
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: superview.topAnchor),
      leadingAnchor.constraint(equalTo: superview.leadingAnchor),
      trailingAnchor.constraint(equalTo: superview.trailingAnchor),
      bottomAnchor.constraint(equalTo: superview.bottomAnchor)
    ])
  }
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
}

extension UICollectionViewFlowLayout {

  static func makeThreeColumnLayout(in view: UIView) -> UICollectionViewFlowLayout {
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
