//
//  RegisterPageViewController.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

final class RegisterPageViewController: LoginBaseViewController {
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
    
    private lazy var reenterPasswordField: CommonTextFieldContainer = {
        let reenterPasswordField: CommonTextFieldContainer = CommonTextFieldContainer()
        
        reenterPasswordField.textField.addTarget(self, action: #selector(onTextFieldChanged), for: .editingChanged)
        reenterPasswordField.textField.isSecureTextEntry = true
        reenterPasswordField.textField.placeholder = "Reenter Password"
        
        return reenterPasswordField
    }()
    
    private lazy var registerButton: CommonButton = {
        let registerButton: CommonButton = CommonButton(isButtonActived: false)
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.setTitle("Register", for: .normal)
        
        return registerButton
    }()
    
    private let viewModel: RegisterPageViewModel
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - Init
    
    init(viewModel: RegisterPageViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.action = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Static Methods
    
    static func constructController() -> RegisterPageViewController {
        let viewModel: RegisterPageViewModel = RegisterPageViewModel(dependency: RegisterPageViewModelDependency())
        let viewController: RegisterPageViewController = RegisterPageViewController(viewModel: viewModel)
        
        return viewController
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
        container.addSubview(reenterPasswordField)
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
        
        reenterPasswordField.makeConstraints { make in
            make.top.equalTo(passwordField, position: .bottom, constant: 16.0)
            make.left.equalTo(container, constant: 16.0)
            make.right.equalTo(container, constant: -16.0)
        }
        
        registerButton.makeConstraints { make in
            make.top.equalTo(reenterPasswordField, position: .bottom, constant: 16.0)
            make.bottom.equalTo(container)
            make.left.equalTo(container, constant: 16.0)
            make.right.equalTo(container, constant: -16.0)
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func onTextFieldChanged() {
        if !(emailField.textField.text?.isEmpty ?? true) &&
            !(passwordField.textField.text?.isEmpty ?? true) &&
            !(reenterPasswordField.textField.text?.isEmpty ?? true) {
            registerButton.isActived(true)
        }
        else {
            registerButton.isActived(false)
        }
    }
    
    @objc
    private func keyboardDismiss() {
        view.endEditing(true)
    }
    
    @objc
    private func registerButtonTapped() {
        viewModel.email = emailField.textField.text ?? ""
        viewModel.password = passwordField.textField.text ?? ""
        viewModel.reenterPassword = reenterPasswordField.textField.text ?? ""
        
        viewModel.register()
    }
}

extension RegisterPageViewController: RegisterPageViewModelAction {
    func showBanner(text: String) {
        BannerView.showBannerView(on: self, text: text, buttonLabel: "Okay", duration: 10.0, action: nil)
    }
    
    func onRegisterFinish() {
        navigationController?.popViewController(animated: true)
    }
}
