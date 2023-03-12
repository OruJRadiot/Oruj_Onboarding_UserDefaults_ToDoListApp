//
//  UpdateToDoItemViewController.swift
//  Oruc_OnboardingScreenAppDemo
//
//  Created by Oruj Dursunzade on 12.03.23.
//

import UIKit

class UpdateToDoItemViewController: UIViewController {
    
    @IBOutlet weak var itemTitle: UITextField!
    @IBOutlet weak var itemSubtitle: UITextField!
    @IBOutlet weak var itemStatus: UISwitch!
    
    var toDoListItem : ToDoListItem?
    var itemIndex : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = toDoListItem {
            itemTitle.text = item.mainTitle
            itemSubtitle.text = item.subTitle
            itemStatus.isOn = item.itemStatus
        }
    }
    
    @IBAction func backToToDoList(_ sender: UIButton){
        let homeScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ToDoListViewController")
        homeScreenVC.modalPresentationStyle = .fullScreen
        self.present(homeScreenVC, animated: true)
    }
    
    @IBAction func updateToDoItemBtnPressed (_ sender: UIButton) {
        if itemTitle.text?.isEmpty == true || itemSubtitle.text?.isEmpty == true {
            let alert = UIAlertController(title: "DİQQƏT...!", message: "Başlıq və ya Mətn boş ola bilməz!", preferredStyle: .alert)

            let yesAction = UIAlertAction(title: "Tamam", style: .default)
            
            alert.addAction(yesAction)
            self.present(alert, animated: true)
        }else {
            if let updatedTitle = itemTitle.text, let updatedSubtitle = itemSubtitle.text {
                let updatedItem = ToDoListItem(itemId:itemIndex! ,mainTitle: updatedTitle, subTitle: updatedSubtitle, itemStatus: self.itemStatus.isOn)
//                UserDefaultsHelper.shared.saveNewToDoItem(item: newItem)
                UserDefaultsHelper.shared.updateToDoItems(item: updatedItem)
                DispatchQueue.main.async {
                        let toDoListScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ToDoListViewController")
                    toDoListScreenVC.modalPresentationStyle = .fullScreen
                        self.present(toDoListScreenVC, animated: true)
                }
            }
        }
    }

}
