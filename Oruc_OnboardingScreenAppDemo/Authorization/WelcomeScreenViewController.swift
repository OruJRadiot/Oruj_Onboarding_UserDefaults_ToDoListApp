//
//  WelcomeScreenViewController.swift
//  Oruc_OnboardingScreenAppDemo
//
//  Created by Oruj Dursunzade on 09.03.23.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    @IBOutlet weak var btnLogin : UIButton!
    @IBOutlet weak var btnRegister : UIButton!
    @IBOutlet weak var btnBackToOnboarding : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func toOnboarding(_ sender: UIButton) {
        let onboardingScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OnboardingViewController")
        onboardingScreenVC.modalPresentationStyle = .fullScreen
        self.present(onboardingScreenVC, animated: true)
    }
    
    @IBAction func toLogin(_ sender: UIButton) {
        let loginScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginScreenViewController")
        loginScreenVC.modalPresentationStyle = .fullScreen
        self.present(loginScreenVC, animated: true)
    }
    
    
    @IBAction func toRegister(_ sender: UIButton) {
        let registerScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterScreenViewController")
        registerScreenVC.modalPresentationStyle = .fullScreen
        self.present(registerScreenVC, animated: true)
    }

}
