//
//  ProfileViewController.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

private let kProfilePictureSize: CGFloat = 120.0

final class ProfileViewController: TabbarBaseViewController {
    // MARK: - Properties
    
    private lazy var profilePicture: UIImageView = {
        let profilePicture: UIImageView = UIImageView(image: UIImage(named: "ic-default-pp"))
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(displayPictureTapped))
        
        profilePicture.addGestureRecognizer(tapGesture)
        profilePicture.contentMode = .scaleAspectFill
        profilePicture.isUserInteractionEnabled = true
        
        return profilePicture
    }()
    
    private lazy var nameTextField: CommonTextFieldContainer = {
        let nameTextField: CommonTextFieldContainer = CommonTextFieldContainer(borderColor: .gray)
        
        nameTextField.addTarget(self, action: #selector(onProfileValuesChanged), for: .editingChanged)
        nameTextField.placeholder = "Name"
        
        return nameTextField
    }()
    
    private lazy var genderTextField: CommonTextFieldContainer = {
        let genderTextField: CommonTextFieldContainer = CommonTextFieldContainer(borderColor: .gray)
        
        genderTextField.addTarget(self, action: #selector(onProfileValuesChanged), for: .editingChanged)
        genderTextField.placeholder = "Gender"
        
        return genderTextField
   }()
    
    private lazy var phoneNumberTextField: CommonTextFieldContainer = {
        let phoneNumberTextField: CommonTextFieldContainer = CommonTextFieldContainer(borderColor: .gray)
        
        phoneNumberTextField.addTarget(self, action: #selector(onProfileValuesChanged), for: .editingChanged)
        phoneNumberTextField.placeholder = "Phone Number"
        phoneNumberTextField.keyboardType = .numberPad
        
        return phoneNumberTextField
    }()
    
    private lazy var notificationLabel: UILabel = {
        let notificationLabel: UILabel = UILabel()
        
        notificationLabel.font = .systemFont(ofSize: 12.0)
        notificationLabel.numberOfLines = 0
        notificationLabel.text = "* Please make sure that you fill in all the fields and Profile Picture. Update button will available if there's any changes from any field and all fields are filled."
        notificationLabel.textColor = .red
        
        return notificationLabel
    }()
    
    private lazy var updateButton: CommonButton = CommonButton(isButtonActived: false)
    
    private let genderValue: [String] = ["Male", "Female"]
    private var selectedgenderValue: String?
    private let viewModel: ProfileViewModel
    
    // MARK: - Init
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Static Methods
    
    static func constructController() -> ProfileViewController {
        let viewModel: ProfileViewModel = ProfileViewModel(dependency: ProfileViewModelDependency())
        let viewController: ProfileViewController = ProfileViewController(viewModel: viewModel)
        
        return viewController
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getProfile()
        
        setupView()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        let containerView: UIView = UIView()
        let logoutButton: CommonButton = CommonButton()
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        
        showBackButton(false)
        
        createPickerView()
        dismissPickerView()
        
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = .backgroundSecondary
        
        title = "Profile"
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10.0
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowRadius = 5.0
        
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        logoutButton.backgroundColor = UIColor.red
        logoutButton.setTitle("Logout", for: .normal)
        
        profilePicture.backgroundColor = .darkGray
        profilePicture.layer.cornerRadius = kProfilePictureSize / 2.0
        profilePicture.layer.masksToBounds = true
        
        updateButton.addTarget(self, action: #selector(updateProfileTapped), for: .touchUpInside)
        updateButton.setTitle("Update Profile", for: .normal)
        
        view.addSubview(containerView)
        view.addSubview(profilePicture)
        view.addSubview(updateButton)
        view.addSubview(logoutButton)
        view.addSubview(notificationLabel)
        
        containerView.addSubview(nameTextField)
        containerView.addSubview(genderTextField)
        containerView.addSubview(phoneNumberTextField)
        
        containerView.makeConstraints { make in
            make.top.equalTo(view, position: .topSafeArea, constant: 60.0)
            make.left.equalTo(view, constant: 16.0)
            make.right.equalTo(view, constant: -16.0)
        }
        
        notificationLabel.makeConstraints { make in
            make.top.equalTo(containerView, position: .bottom, constant: 8.0)
            make.left.right.equalTo(containerView)
        }
        
        updateButton.makeConstraints { make in
            make.bottom.equalTo(logoutButton, position: .top, constant: -12.0)
            make.left.right.equalTo(containerView)
        }
        
        logoutButton.makeConstraints { make in
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
        
        genderTextField.makeConstraints { make in
            make.top.equalTo(nameTextField, position: .bottom, constant: 8.0)
            make.left.equalTo(containerView, constant: 16.0)
            make.right.equalTo(containerView, constant: -16.0)
        }
        
        phoneNumberTextField.makeConstraints { make in
            make.top.equalTo(genderTextField, position: .bottom, constant: 8.0)
            make.left.equalTo(containerView, constant: 16.0)
            make.right.equalTo(containerView, constant: -16.0)
            make.bottom.equalTo(containerView, constant: -12.0)
        }
    }
    
    private func createPickerView() {
        let pickerView: UIPickerView = UIPickerView()
        
        pickerView.delegate = self
        genderTextField.inputView = pickerView
    }
    
    private func dismissPickerView() {
        let toolbar: UIToolbar = UIToolbar()
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        
        toolbar.setItems([doneButton], animated: true)
        toolbar.sizeToFit()
        
        genderTextField.inputAccessoryView = toolbar
    }
    
    // MARK: - Actions
    
    @objc
    private func keyboardDismiss() {
        view.endEditing(true)
    }
    
    @objc
    private func doneButtonTapped() {
        view.endEditing(true)
    }
    
    @objc
    private func displayPictureTapped() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker: UIImagePickerController = UIImagePickerController()
            
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc
    private func updateProfileTapped() {
        viewModel.name = nameTextField.text ?? ""
        viewModel.gender = genderTextField.text ?? ""
        viewModel.phoneNumber = phoneNumberTextField.text ?? ""
        
        viewModel.updateProfile()
    }
    
    @objc
    private func onProfileValuesChanged() {
        let newImageData: Data? = profilePicture.image?.pngData()
        let newName: String = nameTextField.text ?? ""
        let newGender: String = genderTextField.text ?? ""
        let newPhoneNumber: String = phoneNumberTextField.text ?? ""
        
        let isProfileValuesNotEmpty: Bool =
            newImageData != nil &&
                !newName.isEmpty &&
                !newGender.isEmpty &&
                !newPhoneNumber.isEmpty
        let isProfilesValuesIsChanged: Bool =
            newImageData != viewModel.profileImageData ||
                newName != viewModel.name ||
                newGender != viewModel.gender ||
                newPhoneNumber != viewModel.phoneNumber
        
        updateButton.isActived(isProfileValuesNotEmpty && isProfilesValuesIsChanged)
    }
    
    @objc
    private func logout() {
        coordinator?.logout()
    }
}

extension ProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderValue.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderValue[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedgenderValue = genderValue[row]
        genderTextField.text = selectedgenderValue
        onProfileValuesChanged()
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image: UIImage = info[.originalImage] as? UIImage {
            profilePicture.image = image
        }
        
        onProfileValuesChanged()
        
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileViewController: ProfileContracts {
    func configureProfilePage() {
        if let profileImageData: Data = viewModel.profileImageData {
            profilePicture.image = UIImage(data: profileImageData)
        }
        else {
            profilePicture.image = UIImage(named: "ic-default-pp")
        }
        
        nameTextField.text = viewModel.name
        genderTextField.text = viewModel.gender
        phoneNumberTextField.text = viewModel.phoneNumber
    }
    
    func showBanner(text: String) {
        BannerView.showBannerView(on: self, text: text, buttonLabel: "Okay", duration: 5.0, action: nil)
    }
}
