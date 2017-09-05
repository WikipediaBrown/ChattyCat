//
//  ViewController.swift
//  ChattyCat
//
//  Created by Perris Davis on 9/4/17.
//  Copyright © 2017 I.am.GoodBad. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    let catLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    let emailField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .green
        return textField
    }()
    
    let passwordField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .purple
        return textField
    }()
    
    let submitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .brown
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupFunctions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func setupViews() {
        
        // Set background color
        view.backgroundColor = .backgroundColor
        
        // Add Stack to view
        view.addSubview(catLogo)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(submitButton)
        
        // Create views dictionary
        let viewsDictionary = ["v0": catLogo, "v1": emailField, "v2": passwordField, "v3": submitButton]

        // Cat Logo Height
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
        // Email Field Height
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v1]-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
        // Password Field Height
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v2]-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
        // Submit Button Height
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v3]-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
        // Stack Height
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-64-[v0]-20-[v1(44)]-[v2(44)]-20-[v3(55)]-88-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
    
    func setupFunctions() {
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    
    func submitButtonTapped() {
        
        guard
            let email = emailField.text,
            let password = passwordField.text,
            email != "",
            password != ""
        else {
            return
        }
        
        creatOrLoginUser(email: email, password: password)
    }
    
    func creatOrLoginUser(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in

            if let error = error {
                // Handle Errors
                self.handleAuthenticationErrors(error: error, email: email, password:password)
            } else {
                // Present Dashboard
                self.present(ChatDashboardViewController.shared, animated: true, completion: nil)
            }
            
        }
        
    }
    
    func createUser(email: String, password: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                // Handle Errors
                self.handleAuthenticationErrors(error: error, email: email, password:password)
            } else {
                // Present Dashboard
                self.present(ChatDashboardViewController.shared, animated: true, completion: nil)
            }
            
        }
        
    }
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.window?.frame.origin.y = -1 * keyboardHeight!
            self.view.layoutIfNeeded()
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.window?.frame.origin.y = 0
            self.view.layoutIfNeeded()
        })
    }
    
    func resignTextFieldFirstResponders() {
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
    }
    
    func resignAllFirstResponders() {
        view.endEditing(true)
    }
    
    func handleAuthenticationErrors(error: Error?, email: String, password: String) {
        
        guard
            let errorString = error?.localizedDescription
        else {
            print("No localiszed description for error")
            return
        }
        
        switch errorString {
        case String.theEmailAddressIsBadlyFormatted:
            print("bad")
        case String.thePasswordMustBeSixCharactersLongOrMore:
            print("too short")
        case String.theEmailAddressIsAlreadyInUseByAnotherAccount:
            print("used")
        case String.thePasswordIsInvalidOrTheUserDoesNotHaveAPassword:
            print("bad pass or no pass")
        case String.thereIsNoUserRecordCorrespondingToThisIdentifierTheUserMayHaveBeenDeleted:
            createUser(email: email, password: password)
        default:
            print(errorString)
        }
        
    }

}

