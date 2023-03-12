//
//  OnboardingCollectionViewCell.swift
//  Oruc_OnboardingScreenAppDemo
//
//  Created by Oruj Dursunzade on 08.03.23.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var topImage : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var subtitleLabel : UILabel!
    
    func configure (_ item : OnboardingModel, _ size : CGFloat) {
        topImage.image = UIImage(named: item.image)
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    }
}
