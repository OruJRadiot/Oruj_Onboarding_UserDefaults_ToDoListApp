//
//  NewToDoItemViewController.swift
//  Oruc_OnboardingScreenAppDemo
//
//  Created by Oruj Dursunzade on 12.03.23.
//

import UIKit

class NewToDoItemViewController: UIViewController {
    
    @IBOutlet weak var itemTitle: UITextField!
    @IBOutlet weak var itemSubtitle: UITextField!
    @IBOutlet weak var itemStatus: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backToToDoList(_ sender: UIButton){
        let toDoListScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ToDoListViewController")
        toDoListScreenVC.modalPresentationStyle = .fullScreen
        self.present(toDoListScreenVC, animated: true)
    }
    
    @IBAction func saveNewToDoItemBtnPressed(_ sender: UIButton){
        let date = Date().formatted(.iso8601)
        if itemTitle.text?.isEmpty == true || itemSubtitle.text?.isEmpty == true {
            let alert = UIAlertController(title: "DİQQƏT...!", message: "Başlıq və ya Mətn boş ola bilməz!", preferredStyle: .alert)

            let yesAction = UIAlertAction(title: "Tamam", style: .default)
            
            alert.addAction(yesAction)
            self.present(alert, animated: true)
        }else {
            if let newTitle = itemTitle.text, let newSubtitle = itemSubtitle.text{
                let newItem = ToDoListItem(itemId: date, mainTitle: newTitle, subTitle: newSubtitle, itemStatus: false)
                UserDefaultsHelper.shared.saveNewToDoItem(item: newItem)
                DispatchQueue.main.async {
                        let toDoListScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ToDoListViewController")
                    toDoListScreenVC.modalPresentationStyle = .fullScreen
                        self.present(toDoListScreenVC, animated: true)
                }
                
            }
        }
    }
}
