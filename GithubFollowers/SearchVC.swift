//
//  SearchVC.swift
//  GithubFollowers
//
//  Created by Mary Baptista Martinez on 6/24/22.
//

import UIKit

class SearchVC: UIViewController {

  let logoImageView = UIImageView()
  let usernameTextField = GFTextField()
  let ctaButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureLogoView()
    configureTextField()
    configureCTAButton()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = true
  }

  func configureLogoView() {
    view.addSubview(logoImageView)
    logoImageView.image = UIImage(named: "gh-logo")!

    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.heightAnchor.constraint(equalToConstant: 200),
      logoImageView.widthAnchor.constraint(equalToConstant: 200)
    ])
  }

  func configureTextField() {
    view.addSubview(usernameTextField)

    NSLayoutConstraint.activate([
      usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
      usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      usernameTextField.heightAnchor.constraint(equalToConstant: 50)
    ])
  }

  func configureCTAButton() {
    view.addSubview(ctaButton)

    NSLayoutConstraint.activate([
      ctaButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
      ctaButton.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
      ctaButton.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
      ctaButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
}
