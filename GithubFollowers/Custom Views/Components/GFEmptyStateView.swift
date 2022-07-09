//
//  GFEmptyStateView.swift
//  GithubFollowers
//
//  Created by Mary Baptista Martinez on 6/29/22.
//

import UIKit

class GFEmptyStateView: UIView {

  let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
  let logoImageView = UIImageView()

  override init(frame: CGRect) {
    super.init(frame: .zero)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  convenience init(message: String) {
    self.init(frame: .zero)
    messageLabel.text = message
  }

  private func configure() {
    addSubview(messageLabel)
    addSubview(logoImageView)

    messageLabel.numberOfLines = 3
    messageLabel.textColor = .secondaryLabel

    logoImageView.image = UIImage(named: "empty-state-logo")
    logoImageView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
      messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
      messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
      messageLabel.heightAnchor.constraint(equalToConstant: 200),

      logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
      logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
      logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
      logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40)
    ])
  }
}
