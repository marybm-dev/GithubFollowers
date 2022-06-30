//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Mary Baptista Martinez on 6/30/22.
//

import UIKit

class UserInfoVC: UIViewController {

  var username: String!

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
  }

  @objc func dismissVC() {
    dismiss(animated: UIHelper.shouldAnimate)
  }
}