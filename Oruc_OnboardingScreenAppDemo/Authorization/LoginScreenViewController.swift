//
//  LoginScreenViewController.swift
//  Oruc_OnboardingScreenAppDemo
//
//  Created by Oruj Dursunzade on 09.03.23.
//

import UIKit

class LoginScreenViewController: UIViewController {

    @IBOutlet weak var userTextField : UITextField!
    @IBOutlet weak var passTextField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        if let userName = userTextField.text, let userPass = passTextField.text {
            let savedUser = UserDefaultsHelper.shared.loadCredentials()
//            print("user adı : \(savedUser[UserDefaultsKeys.USER_NAME]) --- parol : \(savedUser[UserDefaultsKeys.USER_PASS])")
            DispatchQueue.main.async {
                if savedUser[UserDefaultsKeys.USER_NAME] == userName && savedUser[UserDefaultsKeys.USER_PASS] == userPass{
                    UserDefaultsHelper.shared.setUserLoggedin(true)
                    let homeScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeScreenViewController")
                    homeScreenVC.modalPresentationStyle = .fullScreen
                    self.present(homeScreenVC, animated: true)
                } else {
                    let alert = UIAlertController(title: "Xəta baş verdi!", message: "İstifadəçi mövcud deyil və ya istifadəçi məlumatları yanlışdır!", preferredStyle: .alert)

                    let yesAction = UIAlertAction(title: "Yenidən cəhd etmək", style: .default){ axction in
                        self.userTextField.text = ""
                        self.passTextField.text = ""
                    }
                        alert.addAction(yesAction)
                        self.present(alert, animated: true)
                }
            }
        }
    }
    
    @IBAction func toWelcomeScreen(_ sender: UIButton) {
        let welcomeScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeScreenViewController")
        welcomeScreenVC.modalPresentationStyle = .fullScreen
        self.present(welcomeScreenVC, animated: true)
    }
}



