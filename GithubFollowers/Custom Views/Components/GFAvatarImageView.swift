//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Mary Baptista Martinez on 6/27/22.
//

import UIKit

class GFAvatarImageView: UIImageView {

  let cache = NetworkManager.shared.cache
  let placeholderImage = Images.placeholder

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

  func downloadImage(fromURL urlString: String) {
    NetworkManager.shared.downloadImage(from: urlString) { [weak self] image in
      guard let self = self else { return }
      DispatchQueue.main.async { self.image = image }
    }
  }
}
