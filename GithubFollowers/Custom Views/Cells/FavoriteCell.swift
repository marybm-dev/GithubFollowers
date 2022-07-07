//
//  FavoriteCell.swift
//  GithubFollowers
//
//  Created by Mary Baptista Martinez on 7/6/22.
//

import UIKit

class FavoriteCell: UITableViewCell {

  static let reuseId = FavoriteCell.self.description()
  let avatarImageView = GFAvatarImageView(frame: .zero)
  let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configure() {
    addSubview(avatarImageView)
    addSubview(usernameLabel)

    accessoryType = .checkmark // .disclosureIndicator
    let padding: CGFloat = 12

    NSLayoutConstraint.activate([
      avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
      avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      avatarImageView.heightAnchor.constraint(equalToConstant: 60),
      avatarImageView.widthAnchor.constraint(equalToConstant: 60),

      usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
      usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      usernameLabel.heightAnchor.constraint(equalToConstant: 40)
    ])
  }

  func set(favorite: Follower) {
    usernameLabel.text = favorite.login
    avatarImageView.downloadImage(from: favorite.avatarUrl)
  }
}
