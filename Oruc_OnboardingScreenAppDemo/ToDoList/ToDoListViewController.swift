//
//  ToDoListViewController.swift
//  Oruc_OnboardingScreenAppDemo
//
//  Created by Oruj Dursunzade on 10.03.23.
//

import UIKit

class ToDoListViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var toDoListTableView: UITableView!
    
    private var someList : [ToDoListItem] = []
    private var selectedSegmentIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        someList = [
//            .init(mainTitle: "Stomatoloq", subTitle: "at Ganjlik", itemStatus: false),
//            .init(mainTitle: "Kommunal ödəniş etmək", subTitle: "Electricity və Gas", itemStatus: true),
//            .init(mainTitle: "iOS Homework Aykhan H", subTitle: "Onboarding, Authorisation and ToDo List app", itemStatus: true),
//            .init(mainTitle: "Update CV", subTitle: "and send to Aytaj R", itemStatus: false)
//        ]
        
        toDoListTableView.delegate = self
        toDoListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        someList = UserDefaultsHelper.shared.loadToDoItems()
        toDoListTableView.reloadData()
        let date = Date().formatted(.iso8601)
    }
    
    @IBAction func backToHomeScreen(_ sender: UIButton){
        let homeScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeScreenViewController")
        homeScreenVC.modalPresentationStyle = .fullScreen
        self.present(homeScreenVC, animated: true)
    }

    @IBAction func segmentedControlValueDidChange(_ sender: Any) {
        selectedSegmentIndex = segmentedControl.selectedSegmentIndex
        filterList(selectedIndex: selectedSegmentIndex)
    }
    
    @IBAction func addNewToDoItem (_ sender: UIButton){
        let newItemScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewToDoItemViewController")
        newItemScreenVC.modalPresentationStyle = .fullScreen
        self.present(newItemScreenVC, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toUpdateToDoItemViewController" {
            if let item = sender as? ToDoListItem {
                let updateItemVC = segue.destination as! UpdateToDoItemViewController
                updateItemVC.toDoListItem = item
                updateItemVC.itemIndex = item.itemId
                updateItemVC.modalPresentationStyle = .fullScreen
            }
        }
    }
    
    func filterList(selectedIndex : Int){
        switch selectedIndex {
        case 0:
            someList = UserDefaultsHelper.shared.loadToDoItems()
            toDoListTableView.reloadData()
        case 1:
            someList = UserDefaultsHelper.shared.toDoItemsStatusFilter(status: false)
            toDoListTableView.reloadData()
        case 2:
            someList = UserDefaultsHelper.shared.toDoItemsStatusFilter(status: true)
            toDoListTableView.reloadData()
        default:
            break
        }
    }
    
}

extension ToDoListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return someList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = toDoListTableView.dequeueReusableCell(withIdentifier: "ToDoListTableViewCell", for: indexPath) as? ToDoListTableViewCell {
            cell.configureToDoItem(someList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = someList[indexPath.row]
        performSegue(withIdentifier: "toUpdateToDoItemViewController", sender: item)
        toDoListTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let removeAction = UIContextualAction(style: .destructive, title: "Qeydi Silmək") {
            (action, view, bool) in
            let item = self.someList[indexPath.row]
            let alert = UIAlertController(title: "Təsdiq edin", message: "Aşağıdakı qeydi silməyə əminsiniz? \n\n \(item.mainTitle)", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Xeyr", style: .cancel)
            alert.addAction(cancelAction)
            let confirmAction = UIAlertAction(title: "Bəli", style: .destructive) { action in
                UserDefaultsHelper.shared.deleteToDoItem(itemId: item.itemId)
                DispatchQueue.main.async {
                    self.filterList(selectedIndex: self.selectedSegmentIndex)
                }
            }
            alert.addAction(confirmAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [removeAction])
    }
    
    
}
