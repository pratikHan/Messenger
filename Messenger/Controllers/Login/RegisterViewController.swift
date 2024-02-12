//
//  RegisterViewController.swift
//  Messenger
//
//  Created by Pratik Hanchate on 2/10/24.
//

import UIKit

class RegisterViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address..."

        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white

        return field

    }()

    private let firstnameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "First name..."

        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white

        return field

    }()

    private let lastnameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Lastname..."

        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white

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

        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true

        return field

    }()

    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)

        return button
    }()

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        view.backgroundColor = .white



        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)


        firstnameField.delegate = self
        lastnameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self

        //Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(firstnameField)
        scrollView.addSubview(lastnameField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)

        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true

        let gesture = UITapGestureRecognizer(target: self, action: #selector(profilePhotoTapped))
        gesture.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(gesture)

        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        scrollView.frame = view.bounds

        let size = scrollView.width/4

        imageView.frame = CGRect(x: (view.width-size)/2,
                                 y: 40,
                                 width: size,
                                 height: size)
        emailField.frame = CGRect(x: 30,
                                  y: imageView.bottom+20,
                                  width: scrollView.width-60,
                                  height: 52)

        firstnameField.frame = CGRect(x: 30,
                                  y: emailField.bottom+20,
                                  width: scrollView.width-60,
                                  height: 52)

        lastnameField.frame = CGRect(x: 30,
                                  y: firstnameField.bottom+20,
                                  width: scrollView.width-60,
                                  height: 52)

        passwordField.frame = CGRect(x: 30,
                                  y: lastnameField.bottom+20,
                                  width: scrollView.width-60,
                                  height: 52)

        registerButton.frame = CGRect(x: 30,
                                  y: passwordField.bottom+20,
                                  width: scrollView.width-60,
                                  height: 52)


    }

    @objc private func profilePhotoTapped() {
        print("Tap PRofile")
    }

    @objc private func registerButtonTapped() {

        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()

        guard let email = emailField.text,
              let firstName = firstnameField.text,
              let lastName = lastnameField.text,
              let password = passwordField.text,
              !email.isEmpty, password.count >= 6 else {
            alertLoginError()
            return
        }
        print("Register Tapped")
        // Firebase Login
    }

    func alertLoginError() {
        let alert = UIAlertController(title: "Woops", message: "Please enter correct information to create a new account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel,handler: nil))
        present(alert, animated: true)
    }

}


extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {


        switch textField {
        case emailField:
            firstnameField.becomeFirstResponder()
        case firstnameField:
            lastnameField.becomeFirstResponder()
        case lastnameField:
            passwordField.becomeFirstResponder()
        case passwordField:
            registerButtonTapped()
        default:
            registerButtonTapped()
        }

        return true
    }
}
