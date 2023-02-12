//
//  RegisterViewController.swift
//  Messenger
//
//  Created by Andrey on 2/9/23.
//

import UIKit
import Photos
import PhotosUI
import FirebaseAuth

class RegisterViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
       let view = UIView()
        view.frame.size = contentSize
        return view
    }()
    
    private let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 400)
    }
    
    private let emailField: UITextField = {
       let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email address..."
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.rightViewMode = .always
        field.backgroundColor = .white
        field.keyboardType = .emailAddress
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let passwordField: UITextField = {
       let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password..."
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.rightViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let firstNameField : UITextField = {
       let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "First name..."
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.rightViewMode = .always
        field.backgroundColor = .white
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let secondNameField: UITextField = {
       let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Second name..."
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.rightViewMode = .always
        field.backgroundColor = .white
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.circle"))
        imageView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //FIXME: - Don't work without init in closure
        imageView.layer.cornerRadius = imageView.frame.width / 2
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        view.backgroundColor = .white
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
//                                                            style: .done,
//                                                            target: self,
//                                                            action: #selector(didTapRegister))
        addSubviews()
        setConstraints()
        setImageForProfile()
    }
    
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addSubview(imageView)
        stackView.addSubview(emailField)
        stackView.addSubview(passwordField)
        stackView.addSubview(registerButton)
        stackView.addSubview(firstNameField)
        stackView.addSubview(secondNameField )
    }
    
    private func setImageForProfile () {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapeChangeProfilePicture))
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(gesture)
    }
    
    
    func alertUserRegistrationError(message: String = "Please enter all information to create a new account.") {
        let alertController = UIAlertController(title: "Woops",
                                                message: message,
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Dismiss", style: .cancel)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    private func setDelegates() {
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    @objc private func didTapeChangeProfilePicture() {
        presentPhotoActionSheet()
    }

    @objc private func registrationButtonTapped () {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text ,
              let password = passwordField.text,
              let firstName = firstNameField.text,
              let secondName = secondNameField.text,
              !email.isEmpty,
              !password.isEmpty,
              !firstName.isEmpty,
              !secondName.isEmpty,
              password.count >= 6 else {
            alertUserRegistrationError()
            return
        }
        
        //Firebase log in
        
        DatabaseManager.shared.userExists(with: email) { [weak self] exists in
            guard let strongSelf = self else {
                return
            }
            guard !exists else {
                strongSelf.alertUserRegistrationError(message: "Look like a user account for that email address already exists 🧐")
                return //user already exists
            }
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                
                
                guard  authResult != nil,  error == nil else {
                    print("error currenting user")
                    return
                }
                DatabaseManager.shared.insertUser(with: ChatAppUser(firstName: firstName,
                                                                    secondName: secondName,
                                                                    emailAddress: email))
                strongSelf.navigationController?.dismiss(animated: true)
            }
        }
    }
    
//    @objc private func didTapRegister () {
//        let vc = RegisterViewController()
//        vc.title = "Create Account"
//        navigationController?.pushViewController(vc, animated: true)
//    }
    
}
extension RegisterViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            
            emailField.topAnchor.constraint(equalTo: secondNameField.bottomAnchor, constant: 20),
            emailField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            emailField.heightAnchor.constraint(equalToConstant: 44),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            passwordField.heightAnchor.constraint(equalToConstant: 44),
            
            registerButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            registerButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            registerButton.heightAnchor.constraint(equalToConstant: 44),
            
            firstNameField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            firstNameField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            firstNameField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            firstNameField.heightAnchor.constraint(equalToConstant: 44),
            
            secondNameField.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: 20),
            secondNameField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            secondNameField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            secondNameField.heightAnchor.constraint(equalToConstant: 44),
            
        ])
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            registrationButtonTapped()
        }
        return true
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {

    func presentPhotoActionSheet () {
        let alertController = UIAlertController(title: "Profile Picture",
                                                message: "How would you like to select a picture", preferredStyle: .actionSheet)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        let actionTakePhoto = UIAlertAction(title: "Take photo", style: .default) { [weak self] _ in
            self?.presentCamera()
        }
        let actionChosePhoto = UIAlertAction(title: "Chose photo", style: .default) { [weak self] _ in
            self?.presentPhotoPicker()
        }
        
        alertController.addAction(actionCancel)
        alertController.addAction(actionTakePhoto)
        alertController.addAction(actionChosePhoto)
        
        present( alertController, animated: true)
        
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        
        if #available(iOS 14.0, *) {
            var configure = PHPickerConfiguration()
            configure.selectionLimit = 1
            configure.filter = .images
            let picker = PHPickerViewController(configuration: configure)
            picker.delegate = self
            present(picker, animated: true)
        } else {
            // Fallback on earlier versions
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            vc.delegate = self
            vc.allowsEditing = true
            present(vc, animated: true)
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        self.imageView.image = selectedImage
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    @available(iOS 14.0, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        let itemProvieder = results.first?.itemProvider
        
        if let itemProvieder = itemProvieder, itemProvieder.canLoadObject(ofClass: UIImage.self) {
            itemProvieder.loadObject(ofClass: UIImage.self) { image, error in
                guard let image = image as? UIImage else {return}
                DispatchQueue.main.sync {
                    self.imageView.image = image

                }
                
            }
        }
    }
        
    
}
