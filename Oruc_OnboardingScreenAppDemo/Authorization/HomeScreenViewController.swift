//
//  HomeScreenViewController.swift
//  Oruc_OnboardingScreenAppDemo
//
//  Created by Oruj Dursunzade on 09.03.23.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let credentials = UserDefaultsHelper.shared.loadCredentials()
        let userName = credentials[UserDefaultsKeys.USER_NAME] ?? "hörmətli istifadəçi"
//        print(userName)
        DispatchQueue.main.async {
            self.welcomeLabel.text = "Xoş gəldin \n \(userName.capitalized)!"
        }
    }
    
    @IBAction func navigateToToDoListBtnPressed(_ sender: UIButton){
        let toDoListScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ToDoListViewController")
        toDoListScreenVC.modalPresentationStyle = .fullScreen
        self.present(toDoListScreenVC, animated: true)
    }
    
    @IBAction func logoutBtnPressed(_ sender: UIButton){
        UserDefaultsHelper.shared.setUserLoggedin(false)
        DispatchQueue.main.async {
            let welcomeScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeScreenViewController")
            welcomeScreenVC.modalPresentationStyle = .fullScreen
            self.present(welcomeScreenVC, animated: true)
        }
    }

}
