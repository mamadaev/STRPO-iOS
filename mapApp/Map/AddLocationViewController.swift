//
//  AddLocationViewController.swift
//  mapApp
//
//  Created by i.mamadaev on 14.11.2021.
//

import UIKit

class AddLocationViewController: UIViewController {

    private let loginInput = UITextField()
    private let passwordInput = UITextField()
    private let nameInput = UITextField()

    private let backButton = UIButton()
    private let closeButton = UIImageView()
    private let titleLabel = UILabel()
    
    private let loginLine = UIView()
    private let passwordLine = UIView()
    private let nameLine = UIView()


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
        titleLabel.text = "Добавить локацию"
        titleLabel.textColor = .black
        
        // Login input
        loginInput.backgroundColor = .clear
        loginInput.placeholder = "Ширина"
        loginInput.text = "55.751"
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
        passwordInput.placeholder = "Долгота"
        passwordInput.text = "37.631"
        passwordInput.textAlignment = .center
        passwordInput.font = UIFont.systemFont(ofSize: 16)
        passwordInput.autocapitalizationType = .none
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
        
        // Login input
        nameInput.backgroundColor = .clear
        nameInput.placeholder = "Название"
        nameInput.text = "Кафе Му-му"
        nameInput.textAlignment = .center
        nameInput.font = UIFont.systemFont(ofSize: 16)
        nameInput.autocapitalizationType = .none
        nameInput.autocorrectionType = .no
        view.addSubview(nameInput)
        nameInput.snp.makeConstraints {
            $0.size.height.equalTo(60)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordInput.snp.bottom).offset(10)
            $0.left.equalTo(view.snp.left).offset(64)
            $0.right.equalTo(view.snp.right).offset(-64)
        }
        nameLine.backgroundColor = .gray
        nameInput.addSubview(nameLine)
        nameLine.snp.makeConstraints {
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
        backButton.setTitle("Добавить", for: .normal)
        backButton.addTarget(self, action: #selector(enterPressed), for: .touchUpInside)

        backButton.sizeToFit()
        backButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.right.equalToSuperview().offset(-64)
            $0.left.equalToSuperview().offset(64)
            $0.top.equalTo(nameInput.snp.bottom).offset(80)
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
    
    @objc func enterPressed() {
        print("pressed enter")
        guard let login = loginInput.text else { return }
        guard let password = passwordInput.text else { return }
        passwordLine.backgroundColor = login.isEmpty ? .red : .lightGray
        loginLine.backgroundColor = password.isEmpty ? .red : .lightGray
        
        print(isUserRegistered(login: login, password: password))
        if isUserRegistered(login: login, password: password) {
            // the alert view
            let alert = UIAlertController(title: "", message: "Локация добавлена", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)

            // change to desired number of seconds (in this case 5 seconds)
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                // your code with delay
                alert.dismiss(animated: true, completion: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func closeButtonPressed() {
        self.modalPresentationStyle = .fullScreen
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - HTTP Request Handler
    
    private func isUserRegistered(login: String, password: String) -> Bool {
        let sem = DispatchSemaphore.init(value: 0)

        var isUserRegistered: Bool = false
        guard let url = URL(string: "http://134.0.117.63:8081/add_place") else { return false }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters = ["user_id": "831d9092-629c-4f89-8e6e-9ee5b907291f", "category_id": "test category", "lat": Float(loginInput.text ?? "0.0") ?? 0.0, "long": Float(passwordInput.text ?? "0.0") ?? 0.0, "name": nameInput.text ?? "", "secret": "secret"] as [String : Any]
        
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
        }.resume()
        
        sem.wait()

        return isUserRegistered
    }

}
