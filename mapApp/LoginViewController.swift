//
//  LoginViewController.swift
//  mapApp
//
//  Created by i.mamadaev on 06.11.2021.
//

import UIKit

class LoginViewController: UIViewController {

    private let newBalloonButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .red
                
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        newBalloonButton.backgroundColor = .white
        newBalloonButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        newBalloonButton.layer.cornerRadius = 15
        newBalloonButton.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        newBalloonButton.setTitleColor(UIColor(red: 58/255, green: 131/255, blue: 241/255, alpha: 1), for: .normal)
        newBalloonButton.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 20)
        newBalloonButton.setTitleColor(.gray, for: .selected)
        newBalloonButton.setTitle("Фиксировать", for: .normal)
        newBalloonButton.layer.borderColor = UIColor.black.cgColor
        newBalloonButton.layer.borderWidth = 1
        self.view.addSubview(newBalloonButton)
        newBalloonButton.snp.makeConstraints {
            $0.size.height.equalTo(60)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.snp.bottom).offset(-50)
            $0.left.equalTo(self.view.snp.left).offset(16)
            $0.right.equalTo(self.view.snp.right).offset(-16)
        }
    }
    
    @objc func loginPressed() {
//        self.present(ViewController(), animated: false, completion: nil)
        self.present
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
