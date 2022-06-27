//
//  GFAlertVC.swift
//  GithubFollowers
//
//  Created by Mary Baptista Martinez on 6/26/22.
//

import UIKit

class GFAlertVC: UIViewController {

  let containerView = UIView()
  let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
  let messageLabel = GFBodyLabel(textAlignment: .center)
  let ctaButton = GFButton(backgroundColor: .systemPink, title: "Ok")

  var alertTitle: String?
  var message: String?
  var buttonTitle: String?

  let padding: CGFloat = 20

  init(title: String, message: String, buttonTitle: String) {
    super.init(nibName: nil, bundle: nil)
    self.alertTitle = title
    self.message = message
    self.buttonTitle = buttonTitle
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
    configureContainerView()
    configureTitleLabel()
    configureButton()
    configureMessageLabel()
  }

  func configureContainerView() {
    view.addSubview(containerView)
    containerView.backgroundColor = .systemBackground
    containerView.layer.cornerRadius = 16
    containerView.layer.borderWidth = 2
    containerView.layer.borderColor = UIColor.white.cgColor
    containerView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      containerView.widthAnchor.constraint(equalToConstant: 280),
      containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 220)
    ])
  }

  func configureTitleLabel() {
    containerView.addSubview(titleLabel)
    titleLabel.text = alertTitle ?? "Something went wrong"

    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
      titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 28)
    ])
  }

  func configureButton() {
    containerView.addSubview(ctaButton)
    ctaButton.setTitle(buttonTitle ?? "Ok", for: .normal)
    ctaButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)

    NSLayoutConstraint.activate([
      ctaButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
      ctaButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      ctaButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      ctaButton.heightAnchor.constraint(equalToConstant: 44)
    ])
  }

  @objc func dismissVC() {
    dismiss(animated: true)
  }

  func configureMessageLabel() {
    containerView.addSubview(messageLabel)
    messageLabel.text = message ?? "Unable to complete request"
    messageLabel.numberOfLines = 4

    NSLayoutConstraint.activate([
      messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      messageLabel.bottomAnchor.constraint(equalTo: ctaButton.topAnchor, constant: -12)
    ])
  }
}
