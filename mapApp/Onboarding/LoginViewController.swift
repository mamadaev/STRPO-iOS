//
//  LoginViewController.swift
//  mapApp
//
//  Created by i.mamadaev on 06.11.2021.
//

import UIKit

class LoginViewController: UIViewController {

    private let loginInput = UITextField()
    private let passwordInput = UITextField()
    private let backButton = UIButton()
    private let closeButton = UIImageView()
    private let titleLabel = UILabel()
    private let forgotLabel = UILabel()
    private let continueLabel = UILabel()
    
    private let loginLine = UIView()
    private let passwordLine = UIView()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.view.backgroundColor = .white
        
        view.addSubview(backButton)
        view.addSubview(closeButton)
        view.addSubview(titleLabel)

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loginLine.backgroundColor = .lightGray
        passwordLine.backgroundColor = .lightGray
    }
    
    private func setupUI() {
        
        // Title
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-210)
            $0.centerX.equalToSuperview()
        }
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 30)
        titleLabel.text = "Войти"
        titleLabel.textColor = .black
        
        // Login input
        loginInput.backgroundColor = .clear
        loginInput.placeholder = "Логин"
        loginInput.text = "test"
        loginInput.textAlignment = .center
        loginInput.font = UIFont.systemFont(ofSize: 16)
        loginInput.autocapitalizationType = .none
        loginInput.autocorrectionType = .no
        view.addSubview(loginInput)
        loginInput.snp.makeConstraints {
            $0.size.height.equalTo(60)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-120)
            $0.left.equalTo(view.snp.left).offset(64)
            $0.right.equalTo(view.snp.right).offset(-64)
        }
        loginLine.backgroundColor = .gray
        loginInput.addSubview(loginLine)
        loginLine.snp.makeConstraints {
            $0.size.height.equalTo(1)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        // Password input
        passwordInput.backgroundColor = .clear
        passwordInput.placeholder = "Пароль"
        passwordInput.text = "test"
        passwordInput.textAlignment = .center
        passwordInput.font = UIFont.systemFont(ofSize: 16)
        passwordInput.autocapitalizationType = .none
        passwordInput.isSecureTextEntry = true
        passwordInput.autocorrectionType = .no

        view.addSubview(passwordInput)
        passwordInput.snp.makeConstraints {
            $0.size.height.equalTo(60)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginInput.snp.bottom).offset(10)
            $0.left.equalTo(view.snp.left).offset(64)
            $0.right.equalTo(view.snp.right).offset(-64)
        }
        passwordLine.backgroundColor = .gray
        passwordInput.addSubview(passwordLine)
        passwordLine.snp.makeConstraints {
            $0.size.height.equalTo(1)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        // Forgot input
        forgotLabel.backgroundColor = .clear
        forgotLabel.text = "Забыли пароль?"
        forgotLabel.textAlignment = .center
        forgotLabel.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 18)
        forgotLabel.textColor = .systemBlue
        view.addSubview(forgotLabel)
        forgotLabel.sizeToFit()
        forgotLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordInput.snp.bottom).offset(20)
        }
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(forgotButtonPressed))
        forgotLabel.isUserInteractionEnabled = true
        forgotLabel.addGestureRecognizer(labelTap)
        
        // Button
        backButton.backgroundColor = .white
        backButton.setTitleColor(.white, for: .selected)
        backButton.layer.cornerRadius = 30
        backButton.backgroundColor = UIColor(red: 185/255, green: 190/255, blue: 197/255, alpha: 1)
        backButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        backButton.setTitle("Войти", for: .normal)
        backButton.addTarget(self, action: #selector(enterPressed), for: .touchUpInside)

        backButton.sizeToFit()
        backButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.right.equalToSuperview().offset(-64)
            $0.left.equalToSuperview().offset(64)
            $0.top.equalTo(passwordInput.snp.bottom).offset(80)
            $0.size.height.equalTo(60)
        }
        
        // Close button
        closeButton.image = UIImage(named: "xmark_b.png")
        closeButton.contentMode = .center
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(52)
            $0.left.equalToSuperview().offset(22)
            $0.size.width.equalTo(32)
            $0.size.height.equalTo(32)
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeButtonPressed))
        closeButton.isUserInteractionEnabled = true
        closeButton.addGestureRecognizer(gesture)
        
        // Contrinue label
        continueLabel.textColor = .lightGray
        continueLabel.text = "Продолжить без регистрации"
        view.addSubview(continueLabel)
        continueLabel.sizeToFit()
        continueLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.snp.bottom).offset(-50)
        }
        let continueTap = UITapGestureRecognizer(target: self, action: #selector(continueButtonPressed))
        continueLabel.isUserInteractionEnabled = true
        continueLabel.addGestureRecognizer(continueTap)
    }
    
    @objc func enterPressed() {
        print("pressed enter")
        guard let login = loginInput.text else { return }
        guard let password = passwordInput.text else { return }
        passwordLine.backgroundColor = login.isEmpty ? .red : .lightGray
        loginLine.backgroundColor = password.isEmpty ? .red : .lightGray
        
        print(isUserRegistered(login: login, password: password))
        if isUserRegistered(login: login, password: password) {
            let vc = MapViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        } else {
            shakeTextField(textField: loginInput, numberOfShakes:0, direction: 1, maxShakes : 5)
            shakeTextField(textField: passwordInput, numberOfShakes:0, direction: 1, maxShakes : 5)

            passwordLine.backgroundColor = .red
            loginLine.backgroundColor = .red
        }
    }
    
    @objc func closeButtonPressed() {
        self.modalPresentationStyle = .fullScreen
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func forgotButtonPressed() {
        let vc = ForgotPasswordViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func continueButtonPressed() {
        let vc = MapViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - HTTP Request Handler
    
    private func isUserRegistered(login: String, password: String) -> Bool {
        let sem = DispatchSemaphore.init(value: 0)

        var isUserRegistered: Bool = false
        guard let url = URL(string: "http://134.0.117.63:8081/is_signed") else { return false }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters = ["login": login, "password_encrypted": password, "secret": "secret"]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return false
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            let strResponse = String(decoding: data, as: UTF8.self)
            defer { sem.signal() }

            isUserRegistered = strResponse == "true" ? true : false
        }.resume()
        
        sem.wait()

        return isUserRegistered
    }
    
    func shakeTextField(textField: UITextField, numberOfShakes: Int, direction: CGFloat, maxShakes: Int) {

        let interval: TimeInterval = 0.05

        UIView.animate(withDuration: interval, animations: { () -> Void in
            textField.transform = CGAffineTransform(translationX: 5 * direction, y: 0)

            }, completion: { (aBool :Bool) -> Void in

                if (numberOfShakes >= maxShakes) {
                    textField.transform = .identity
                    textField.becomeFirstResponder()
                    return
                }

                self.shakeTextField(textField: textField, numberOfShakes: numberOfShakes + 1, direction: direction * -1, maxShakes: maxShakes)
        })

    }
}
