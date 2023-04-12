//
//  MainVeiwController.swift
//  loginbySpotify
//
//  Created by 김건호 on 2023/04/13.
//

import UIKit

class MainVeiwController : UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    
    @IBAction func logoutButtonTap(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
