//
//  RegisterScreenViewController.swift
//  Oruc_OnboardingScreenAppDemo
//
//  Created by Oruj Dursunzade on 09.03.23.
//

import UIKit

class RegisterScreenViewController: UIViewController {
    
    @IBOutlet weak var userTextField : UITextField!
    @IBOutlet weak var passTextField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        if userTextField.text?.isEmpty == true || passTextField.text?.isEmpty == true {
            let alert = UIAlertController(title: "XƏTA...!", message: "İstifadəçi adı və ya Şifrə boş ola bilməz!", preferredStyle: .alert)

            let yesAction = UIAlertAction(title: "Tamam", style: .default)
            
            alert.addAction(yesAction)
            self.present(alert, animated: true)
        }
        else {
            if let newUserName = userTextField.text, let newUserPass = passTextField.text {
                let newUser = [UserDefaultsKeys.USER_NAME : newUserName, UserDefaultsKeys.USER_PASS : newUserPass]
                UserDefaultsHelper.shared.saveCredentials(newUser)
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Təbriklər!", message: "Siz qeydiyyatdan uğurla keçdiniz!", preferredStyle: .alert)

                    let yesAction = UIAlertAction(title: "Davam et", style: .default){action in
                        UserDefaultsHelper.shared.setUserLoggedin(true)
                        let homeScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeScreenViewController")
                        homeScreenVC.modalPresentationStyle = .fullScreen
                        self.present(homeScreenVC, animated: true)
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
