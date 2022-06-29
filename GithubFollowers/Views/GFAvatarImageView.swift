//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Mary Baptista Martinez on 6/27/22.
//

import UIKit

class GFAvatarImageView: UIImageView {

  let placeholderImage = UIImage(named: "avatar-placeholder")!

  override init(frame: CGRect) {
    super.init(frame: .zero)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configure() {
    layer.cornerRadius = 10
    clipsToBounds = true
    image = placeholderImage
    translatesAutoresizingMaskIntoConstraints = false
  }
}
