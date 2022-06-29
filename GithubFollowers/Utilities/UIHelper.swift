//
//  UIHelper.swift
//  GithubFollowers
//
//  Created by Mary Baptista Martinez on 6/28/22.
//

import UIKit

struct UIHelper {

  static var shouldAnimate: Bool { !UIAccessibility.isReduceMotionEnabled }

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
