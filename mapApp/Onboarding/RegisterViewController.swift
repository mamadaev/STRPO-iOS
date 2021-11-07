//
//  RegisterViewController.swift
//  mapApp
//
//  Created by i.mamadaev on 07.11.2021.
//

import UIKit

class RegisterViewController: UIViewController {

    private let loginInput = UITextField()
    private let passwordInput = UITextField()
    private let repeatPasswordInput = UITextField()

    
    private let nameInput = UITextField()
    private let midnameInput = UITextField()
    private let surnameInput = UITextField()

    private let backButton = UIButton()
    private let closeButton = UIImageView()
    private let titleLabel = UILabel()
    
    // Lines
    private let nameInputLine = UIView()
    private let midnameInputLine = UIView()
    private let surnameInputLine = UIView()
    private let loginLine = UIView()
    private let passwordLine = UIView()
    private let repeatPasswordInputLine = UIView()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.view.backgroundColor = .white
        
        view.addSubview(backButton)
        view.addSubview(closeButton)
        view.addSubview(titleLabel)

        setupUI()
    }
    
    private func setupUI() {
        
        // Title
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-300)
            $0.centerX.equalToSuperview()
        }
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 30)
        titleLabel.text = "Регистрация"
        titleLabel.textColor = .black
        
        // Name input
        surnameInput.backgroundColor = .clear
        surnameInput.placeholder = "Фамилия"
        surnameInput.textAlignment = .center
        surnameInput.font = UIFont.systemFont(ofSize: 16)
        surnameInput.autocapitalizationType = .none
        surnameInput.autocorrectionType = .no
        view.addSubview(surnameInput)
        surnameInput.snp.makeConstraints {
            $0.size.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.left.equalTo(view.snp.left).offset(64)
            $0.right.equalTo(view.snp.right).offset(-64)
        }
        surnameInputLine.backgroundColor = .gray
        surnameInput.addSubview(surnameInputLine)
        surnameInputLine.snp.makeConstraints {
            $0.size.height.equalTo(1)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        // Midname input
        nameInput.backgroundColor = .clear
        nameInput.placeholder = "Имя"
        nameInput.textAlignment = .center
        nameInput.font = UIFont.systemFont(ofSize: 16)
        nameInput.autocapitalizationType = .none
        nameInput.autocorrectionType = .no
        view.addSubview(nameInput)
        nameInput.snp.makeConstraints {
            $0.size.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(surnameInput.snp.bottom).offset(10)
            $0.left.equalTo(view.snp.left).offset(64)
            $0.right.equalTo(view.snp.right).offset(-64)
        }
        nameInputLine.backgroundColor = .gray
        nameInput.addSubview(nameInputLine)
        nameInputLine.snp.makeConstraints {
            $0.size.height.equalTo(1)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        // Surname input
        midnameInput.backgroundColor = .clear
        midnameInput.placeholder = "Отчество (необязательно)"
        midnameInput.textAlignment = .center
        midnameInput.font = UIFont.systemFont(ofSize: 16)
        midnameInput.autocapitalizationType = .none
        midnameInput.autocorrectionType = .no
        view.addSubview(midnameInput)
        midnameInput.snp.makeConstraints {
            $0.size.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nameInput.snp.bottom).offset(10)
            $0.left.equalTo(view.snp.left).offset(64)
            $0.right.equalTo(view.snp.right).offset(-64)
        }
        midnameInputLine.backgroundColor = .gray
        midnameInput.addSubview(midnameInputLine)
        midnameInputLine.snp.makeConstraints {
            $0.size.height.equalTo(1)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        // Login input
        loginInput.backgroundColor = .clear
        loginInput.placeholder = "Логин"
        loginInput.textAlignment = .center
        loginInput.font = UIFont.systemFont(ofSize: 16)
        loginInput.autocapitalizationType = .none
        loginInput.autocorrectionType = .no
        view.addSubview(loginInput)
        loginInput.snp.makeConstraints {
            $0.size.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(midnameInput.snp.bottom).offset(10)
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
        passwordInput.textAlignment = .center
        passwordInput.font = UIFont.systemFont(ofSize: 16)
        passwordInput.autocapitalizationType = .none
        passwordInput.isSecureTextEntry = true
        passwordInput.autocorrectionType = .no

        view.addSubview(passwordInput)
        passwordInput.snp.makeConstraints {
            $0.size.height.equalTo(50)
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
        
        // Repeat passwrod input
        repeatPasswordInput.backgroundColor = .clear
        repeatPasswordInput.placeholder = "Повторите пароль"
        repeatPasswordInput.textAlignment = .center
        repeatPasswordInput.font = UIFont.systemFont(ofSize: 16)
        repeatPasswordInput.autocapitalizationType = .none
        repeatPasswordInput.isSecureTextEntry = true
        repeatPasswordInput.autocorrectionType = .no

        view.addSubview(repeatPasswordInput)
        repeatPasswordInput.snp.makeConstraints {
            $0.size.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordLine.snp.bottom).offset(10)
            $0.left.equalTo(view.snp.left).offset(64)
            $0.right.equalTo(view.snp.right).offset(-64)
        }
        repeatPasswordInputLine.backgroundColor = .gray
        repeatPasswordInput.addSubview(repeatPasswordInputLine)
        repeatPasswordInputLine.snp.makeConstraints {
            $0.size.height.equalTo(1)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        // Button
        backButton.backgroundColor = .white
        backButton.setTitleColor(.white, for: .selected)
        backButton.layer.cornerRadius = 30
        backButton.backgroundColor = UIColor(red: 185/255, green: 190/255, blue: 197/255, alpha: 1)
        backButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        backButton.setTitle("Зарегистрироваться", for: .normal)
        backButton.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)

        backButton.sizeToFit()
        backButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.right.equalToSuperview().offset(-64)
            $0.left.equalToSuperview().offset(64)
            $0.top.equalTo(repeatPasswordInput.snp.bottom).offset(80)
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
    }
    
    @objc func registerPressed() {
        
        
        guard let login = loginInput.text else { return }
        guard let password = passwordInput.text else { return }
        guard let name = nameInput.text else { return }
        guard let surname = surnameInput.text else { return }
        guard let midname = midnameInput.text else { return }
        guard let repeatPassword = repeatPasswordInput.text else { return }
        
        let fio = surname + " " + name + " " + midname
        
        
        
        if login.isEmpty {
            shakeTextField(textField: loginInput, numberOfShakes:0, direction: 1, maxShakes : 5)
            loginLine.backgroundColor = .red
        }
        
        if name.isEmpty {
            shakeTextField(textField: nameInput, numberOfShakes:0, direction: 1, maxShakes : 5)
            nameInputLine.backgroundColor = .red
        }
        
        if surname.isEmpty {
            shakeTextField(textField: surnameInput, numberOfShakes:0, direction: 1, maxShakes : 5)
            surnameInputLine.backgroundColor = .red
        }
        
        if password != repeatPassword || password.isEmpty || repeatPassword.isEmpty {
            shakeTextField(textField: passwordInput, numberOfShakes:0, direction: 1, maxShakes : 5)
            shakeTextField(textField: repeatPasswordInput, numberOfShakes:0, direction: 1, maxShakes : 5)
            passwordLine.backgroundColor = .red
            repeatPasswordInputLine.backgroundColor = .red
        }
        
        if login.isEmpty || name.isEmpty || surname.isEmpty || password != repeatPassword {
            return
        }
        
        if registerUser(login: login, password: password, fio: fio) {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Такой логин уже используется", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                print("Ok")
            }))
            self.present(alert, animated: true, completion: nil)
            shakeTextField(textField: loginInput, numberOfShakes:0, direction: 1, maxShakes : 5)
            loginLine.backgroundColor = .red
        }
    }
    
    @objc func closeButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - HTTP Request Handler
    
    private func registerUser(login: String, password: String, fio: String) -> Bool {
        let sem = DispatchSemaphore.init(value: 0)

        var isUserRegistered: Bool = false
        guard let url = URL(string: "http://134.0.117.63:8081/signup") else { return false }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters = ["login": login, "password_encrypted": password, "fio": fio, "secret": "secret"]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return false
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            let strResponse = String(decoding: data, as: UTF8.self)
            defer { sem.signal() }

            isUserRegistered = strResponse == "\"ok\"" ? true : false
//            "login exist, try another"
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
