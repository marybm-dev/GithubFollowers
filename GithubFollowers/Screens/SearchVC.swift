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
  var logoImageViewTopConstraint: NSLayoutConstraint!

  var isUsernameEntered: Bool { return !usernameTextField.text!.isEmpty }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureLogoView()
    configureTextField()
    configureCTAButton()
    createDismissKeyboardTapGesture()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    usernameTextField.text = ""
    navigationController?.isNavigationBarHidden = true
  }

  func createDismissKeyboardTapGesture() {
    let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
    view.addGestureRecognizer(tap)
  }

  @objc func pushFollowerListVC() {
    guard isUsernameEntered else {
      presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😄", buttonTitle: "Ok")
      return
    }
    
    usernameTextField.resignFirstResponder()
    let followerListVC = FollowerListVC(username: usernameTextField.text!)
    navigationController?.pushViewController(followerListVC, animated: true)
  }

  func configureLogoView() {
    view.addSubview(logoImageView)
    logoImageView.image = Images.ghLogo

    let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
    logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant)

    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.heightAnchor.constraint(equalToConstant: 200),
      logoImageView.widthAnchor.constraint(equalToConstant: 200),
      logoImageViewTopConstraint
    ])
  }

  func configureTextField() {
    view.addSubview(usernameTextField)
    usernameTextField.delegate = self

    NSLayoutConstraint.activate([
      usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
      usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      usernameTextField.heightAnchor.constraint(equalToConstant: 50)
    ])
  }

  func configureCTAButton() {
    view.addSubview(ctaButton)
    ctaButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)

    NSLayoutConstraint.activate([
      ctaButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
      ctaButton.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
      ctaButton.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
      ctaButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
}

extension SearchVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return true
  }
}
