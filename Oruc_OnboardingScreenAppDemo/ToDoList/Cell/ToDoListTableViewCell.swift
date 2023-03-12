//
//  ToDoListTableViewCell.swift
//  Oruc_OnboardingScreenAppDemo
//
//  Created by Oruj Dursunzade on 10.03.23.
//

import UIKit

class ToDoListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var index: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureToDoItem (_ item : ToDoListItem) {
        title.text = item.mainTitle
        subtitle.text = item.subTitle
        index.text = item.itemId
        status.layer.cornerRadius = status.frame.size.height / 2.0
        status.layer.masksToBounds = true
        if item.itemStatus {
            status.text = "Bitmiş"
            status.backgroundColor = .systemGreen
        } else {
            status.text = "Aktiv"
            status.backgroundColor = .systemOrange
        }
    }

}
