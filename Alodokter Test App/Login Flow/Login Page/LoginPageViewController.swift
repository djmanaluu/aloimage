//
//  LoginPageViewController.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

final class LoginPageViewController: LoginBaseViewController {
    // MARK: - Properties
    
    private lazy var emailField: CommonTextFieldContainer = {
        let emailTextField: CommonTextFieldContainer = CommonTextFieldContainer()
        
        emailTextField.textField.addTarget(self, action: #selector(onTextFieldChanged), for: .editingChanged)
        emailTextField.textField.placeholder = "Email"
        
        return emailTextField
    }()
    
    private lazy var passwordField: CommonTextFieldContainer = {
        let passwordTextField: CommonTextFieldContainer = CommonTextFieldContainer()
        
        passwordTextField.textField.addTarget(self, action: #selector(onTextFieldChanged), for: .editingChanged)
        passwordTextField.textField.placeholder = "Password"
        
        return passwordTextField
    }()
    
    lazy var loginButton: CommonButton = {
        let loginButton: CommonButton = CommonButton(isButtonActived: false)
        
        loginButton.setTitle("Login", for: .normal)
        
        return loginButton
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        let container: UIView = UIView()
        let logoImageView: UIImageView = UIImageView(image: UIImage(named: "aloimage-logo"))
        let titleLabel: UILabel = UILabel()
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        
        view.addGestureRecognizer(tapGesture)
        
        titleLabel.font = .boldSystemFont(ofSize: 22.0)
        titleLabel.text = "aloimage"
        
        view.addSubview(container)
        
        container.addSubview(logoImageView)
        container.addSubview(titleLabel)
        container.addSubview(emailField)
        container.addSubview(passwordField)
        container.addSubview(loginButton)
        
        container.makeConstraint { make in
            make.left.right.centerY.equalTo(view)
        }
        
        logoImageView.makeConstraint { make in
            make.top.equalTo(container, constant: 24.0)
            make.centerX.equalTo(container)
            make.size.equalToConstant(64.0)
        }
        
        titleLabel.makeConstraint { make in
            make.top.equalTo(logoImageView, position: .bottom, constant: 12.0)
            make.centerX.equalTo(container)
        }
        
        emailField.makeConstraint { make in
            make.top.equalTo(titleLabel, position: .bottom, constant: 12.0)
            make.left.equalTo(container, constant: 16.0)
            make.right.equalTo(container, constant: -16.0)
        }
        
        passwordField.makeConstraint { make in
            make.top.equalTo(emailField, position: .bottom, constant: 12.0)
            make.left.equalTo(container, constant: 16.0)
            make.right.equalTo(container, constant: -16.0)
        }
        
        loginButton.makeConstraint { make in
            make.top.equalTo(passwordField, position: .bottom, constant: 16.0)
            make.bottom.equalTo(container)
            make.left.equalTo(container, constant: 16.0)
            make.right.equalTo(container, constant: -16.0)
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func onTextFieldChanged() {
        if !(emailField.textField.text?.isEmpty ?? true) && !(passwordField.textField.text?.isEmpty ?? true) {
            loginButton.isActived(true)
        }
        else {
            loginButton.isActived(false)
        }
    }
    
    @objc
    private func keyboardDismiss() {
        view.endEditing(true)
    }
}
