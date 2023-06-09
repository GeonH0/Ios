//
//  LoginViewController.swift
//  loginbySpotify
//
//  Created by 김건호 on 2023/04/12.
//

import UIKit

class LoginViewController : UIViewController{
    
    
    @IBOutlet weak var emailLoginButton: UIButton!
    
    @IBOutlet weak var googleLoginButton: UIButton!
    
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [emailLoginButton,googleLoginButton,appleLoginButton].forEach {
            $0?.layer.borderWidth=1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //navigationbar 숨기기
        navigationController?.navigationBar.isHidden = true
        
    }
    
    
    @IBAction func googleLoginButtonTap(_ sender: UIButton) {
        
    }
    
    
    
    @IBAction func appleLoginButtonTap(_ sender: UIButton) {
        
    }
    
}
