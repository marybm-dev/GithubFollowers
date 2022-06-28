//
//  FollowerCell.swift
//  GithubFollowers
//
//  Created by Mary Baptista Martinez on 6/27/22.
//

import UIKit

class FollowerCell: UICollectionViewCell {
  static let reuseId = FollowerCell.self.description()

  let avatarImageView = GFAvatarImageView(frame: .zero)
  let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func set(follower: Follower) {
    usernameLabel.text = follower.login
  }

  private func configure() {
    addSubview(avatarImageView)
    addSubview(usernameLabel)

    let padding: CGFloat = 8
    NSLayoutConstraint.activate([
      avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
      avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),

      usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
      usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
      usernameLabel.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
      usernameLabel.heightAnchor.constraint(equalToConstant: 20)
    ])
  }
}
