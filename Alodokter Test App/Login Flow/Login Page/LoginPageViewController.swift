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
        let passwordField: CommonTextFieldContainer = CommonTextFieldContainer()
        
        passwordField.textField.addTarget(self, action: #selector(onTextFieldChanged), for: .editingChanged)
        passwordField.textField.isSecureTextEntry = true
        passwordField.textField.placeholder = "Password"
        
        return passwordField
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        let container: UIView = UIView()
        let logoImageView: UIImageView = UIImageView(image: UIImage(named: "aloimage-logo"))
        let titleLabel: UILabel = UILabel()
        let dontHaveAccountLabel: UILabel = UILabel()
        let registerButton: UIButton = UIButton()
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        
        view.addGestureRecognizer(tapGesture)
        
        titleLabel.font = .boldSystemFont(ofSize: 22.0)
        titleLabel.text = "aloimage"
        
        dontHaveAccountLabel.font = .systemFont(ofSize: 12.0)
        dontHaveAccountLabel.text = "Don't have account? Let's join us."
        dontHaveAccountLabel.textAlignment = .center
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.titleLabel?.font = .systemFont(ofSize: 14.0)
        registerButton.setTitle("Register Here", for: .normal)
        registerButton.setTitleColor(.themePrimary, for: .normal)
        
        view.addSubview(container)
        
        container.addSubview(logoImageView)
        container.addSubview(titleLabel)
        container.addSubview(emailField)
        container.addSubview(passwordField)
        container.addSubview(loginButton)
        container.addSubview(dontHaveAccountLabel)
        container.addSubview(registerButton)
        
        container.makeConstraints { make in
            make.left.right.centerY.equalTo(view)
        }
        
        logoImageView.makeConstraints { make in
            make.top.equalTo(container, constant: 24.0)
            make.centerX.equalTo(container)
            make.size.equalToConstant(64.0)
        }
        
        titleLabel.makeConstraints { make in
            make.top.equalTo(logoImageView, position: .bottom, constant: 12.0)
            make.centerX.equalTo(container)
        }
        
        emailField.makeConstraints { make in
            make.top.equalTo(titleLabel, position: .bottom, constant: 12.0)
            make.left.equalTo(container, constant: 16.0)
            make.right.equalTo(container, constant: -16.0)
        }
        
        passwordField.makeConstraints { make in
            make.top.equalTo(emailField, position: .bottom, constant: 12.0)
            make.left.equalTo(container, constant: 16.0)
            make.right.equalTo(container, constant: -16.0)
        }
        
        loginButton.makeConstraints { make in
            make.top.equalTo(passwordField, position: .bottom, constant: 16.0)
            make.left.equalTo(container, constant: 16.0)
            make.right.equalTo(container, constant: -16.0)
        }
        
        dontHaveAccountLabel.makeConstraints { make in
            make.top.equalTo(loginButton, position: .bottom, constant: 12.0)
            make.left.equalTo(container, constant: 16.0)
            make.right.equalTo(container, constant: -16.0)
        }
        
        registerButton.makeConstraints { make in
            make.top.equalTo(dontHaveAccountLabel, position: .bottom, constant: 4.0)
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
    
    @objc
    private func registerButtonTapped() {
        coordinator?.navigateToRegisterPage()
    }
}
