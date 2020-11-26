//
//  ProfileViewController.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

private let kProfilePictureSize: CGFloat = 120.0

final class ProfileViewController: BaseViewController {
    // MARK: - Properties
    
    private lazy var profilePicture: UIImageView = UIImageView()
    
    private lazy var nameTextField: CommonTextFieldContainer = {
        let nameTextField: CommonTextFieldContainer = CommonTextFieldContainer()
        
        nameTextField.placeholder = "Name"
        
        return nameTextField
    }()
    
    private lazy var sextTextField: CommonTextFieldContainer = {
           let sextTextField: CommonTextFieldContainer = CommonTextFieldContainer()
           
           sextTextField.placeholder = "Sex"
           
           return sextTextField
       }()
    
    private lazy var phoneNumberTextField: CommonTextFieldContainer = {
           let phoneNumberTextField: CommonTextFieldContainer = CommonTextFieldContainer()
           
           phoneNumberTextField.placeholder = "Phone Number"
           
           return phoneNumberTextField
       }()
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        let containerView: UIView = UIView()
        let updateButton: CommonButton = CommonButton()
        
        showBackButton(false)
        
        view.backgroundColor = .backgroundSecondary
        
        title = "Profile"
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10.0
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        containerView.layer.shadowRadius = 5.0
        
        profilePicture.backgroundColor = .darkGray
        profilePicture.layer.cornerRadius = kProfilePictureSize / 2.0
        
        updateButton.setTitle("Update Profile", for: .normal)
        
        view.addSubview(containerView)
        view.addSubview(updateButton)
        
        containerView.addSubview(profilePicture)
        containerView.addSubview(nameTextField)
        containerView.addSubview(sextTextField)
        containerView.addSubview(phoneNumberTextField)
        
        containerView.makeConstraints { make in
            make.top.equalTo(view, position: .topSafeArea, constant: 100.0)
            make.left.equalTo(view, constant: 16.0)
            make.right.equalTo(view, constant: -16.0)
        }
        
        updateButton.makeConstraints { make in
            make.bottom.equalTo(view, position: .bottomSafeArea, constant: -16.0)
            make.left.right.equalTo(containerView)
        }
        
        profilePicture.makeConstraints { make in
            make.centerY.equalTo(containerView, position: .top)
            make.centerX.equalTo(containerView)
            make.size.equalToConstant(kProfilePictureSize)
        }
        
        nameTextField.makeConstraints { make in
            make.top.equalTo(profilePicture, position: .bottom, constant: 16.0)
            make.left.equalTo(containerView, constant: 16.0)
            make.right.equalTo(containerView, constant: -16.0)
        }
        
        sextTextField.makeConstraints { make in
            make.top.equalTo(nameTextField, position: .bottom, constant: 16.0)
            make.left.equalTo(containerView, constant: 16.0)
            make.right.equalTo(containerView, constant: -16.0)
        }
        
        phoneNumberTextField.makeConstraints { make in
            make.top.equalTo(sextTextField, position: .bottom, constant: 16.0)
            make.left.equalTo(containerView, constant: 16.0)
            make.right.equalTo(containerView, constant: -16.0)
            make.bottom.equalTo(containerView, constant: -16.0)
        }
    }
}
