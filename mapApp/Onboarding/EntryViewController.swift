//
//  EntryViewController.swift
//  mapApp
//
//  Created by i.mamadaev on 07.11.2021.
//

import UIKit

class EntryViewController: UIViewController {

    private let iconImageView = UIImageView()
    private let loginButton = UIButton()
    private let registerButton = UIButton()
    private let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.view.backgroundColor = .yellow

        view.addSubview(iconImageView)
        view.addSubview(registerButton)
        view.addSubview(loginButton)
        view.addSubview(titleLabel)

        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        
        // Icon
        iconImageView.image = UIImage(named: "map.png")
        iconImageView.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin).offset(100)
            $0.centerX.equalToSuperview()
            $0.size.height.equalTo(256)
            $0.size.width.equalTo(256)
        }
        
        // Title
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 30)
        titleLabel.text = "Подскажем куда сходить"
        titleLabel.textColor = .black
        
        // Register button
        registerButton.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
        registerButton.backgroundColor = UIColor(red: 77/255, green: 163/255, blue: 227/255, alpha: 1)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 20)
        registerButton.setTitleColor(.gray, for: .selected)
        registerButton.setTitle("Регистрация", for: .normal)
        registerButton.snp.makeConstraints {
            $0.size.height.equalTo(90)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.snp.bottom)
            $0.left.right.equalTo(view)
        }
        
        // Login button
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        loginButton.backgroundColor = UIColor(red: 236/255, green: 88/255, blue: 82/255, alpha: 1)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 20)
        loginButton.setTitleColor(.gray, for: .selected)
        loginButton.setTitle("Вход", for: .normal)
        loginButton.snp.makeConstraints {
            $0.size.height.equalTo(90)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(registerButton.snp.top)
            $0.left.right.equalTo(view)
        }
        
    }
    
    @objc func loginPressed() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func registerPressed() {
        let vc = RegisterViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }

}

// MARK: - Hide Keyboard

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
