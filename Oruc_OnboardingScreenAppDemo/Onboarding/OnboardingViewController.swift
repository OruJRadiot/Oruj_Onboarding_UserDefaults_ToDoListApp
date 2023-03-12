//
//  OnboardingViewController.swift
//  Oruc_OnboardingScreenAppDemo
//
//  Created by Oruj Dursunzade on 08.03.23.
//

import UIKit

enum btnCase {
    static let next = "Növbəti"
    static let start = "Tətbiqə keç!"
}

final class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var nextBtn : UIButton!
    @IBOutlet weak var pagination : UIPageControl!
    
    private var onboardingList : [OnboardingModel] = []
    
    private var currentSlideNumber : Int = 0 {
        didSet {
            slideNumberChanged()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            let isUserLoggedIn = UserDefaultsHelper.shared.getUserStatus()
            if isUserLoggedIn {
                let homeScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeScreenViewController")
                homeScreenVC.modalPresentationStyle = .fullScreen
                self.present(homeScreenVC, animated: true)
            }
        }
        
        nextBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        nextBtn.layer.cornerRadius = 15
        
        onboardingList = [
            .init(image: "man-thinking", title: "Xaotik qeydlərdən bezmisən?", subtitle: "Mürəkkəb tətbiqlər işinə yaramır?"),
            .init(image: "calendar-ticked", title: "Tarixlər yadından çıxır?", subtitle: "Harada nə vaxt nə etməli olduğunu xatırlamaqdan bezmisən?"),
            .init(image: "wolf-approves", title: "Narahat olma", subtitle: "Düzgün seçim etmisən!"),
            .init(image: "smart-notes", title: "Ağıllı Not Dəftəri", subtitle: "Burada hərşeydən vaxtında xəbərdar olacaqsan! ")
        ]
        
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.collectionViewLayout = layout
        
    }
    
    func slideNumberChanged () {
        pagination.currentPage = currentSlideNumber
        if currentSlideNumber == onboardingList.count - 1 {
            configureBtn(btnCase.start)
        } else {
            configureBtn(btnCase.next)
        }
    }
    
    func configureBtn (_ btnTitle : String) {
        let customBtnDesign = NSMutableAttributedString(string: btnTitle, attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
        ])
        nextBtn.setAttributedTitle(customBtnDesign, for: .normal)
    }
    
    
    @IBAction func btnTapped(_ sender: UIButton) {
        if sender.titleLabel?.text == btnCase.next {
            currentSlideNumber += 1
            if currentSlideNumber <= onboardingList.count - 1 {
                let indexPAth = IndexPath(item: currentSlideNumber, section: 0)
                collectionView.scrollToItem(at: indexPAth, at: .centeredHorizontally, animated: true)
            }
        } else if sender.titleLabel?.text == btnCase.start {
            let welcomeScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeScreenViewController")
            welcomeScreenVC.modalPresentationStyle = .fullScreen
            self.present(welcomeScreenVC, animated: true)
        }
    }
    
    
    

    // MARK: - Navigation
}

extension OnboardingViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as? OnboardingCollectionViewCell {
            cell.configure(onboardingList[indexPath.row], collectionView.frame.width)
            cell.topImage.translatesAutoresizingMaskIntoConstraints = false
            cell.topImage.heightAnchor.constraint(equalToConstant: collectionView.frame.height).isActive = true
            cell.topImage.widthAnchor.constraint(equalToConstant: collectionView.frame.width).isActive = true
            return cell
        }
        return UICollectionViewCell()
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
//    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentSlideNumber = Int(scrollView.contentOffset.x / width)
    }
    
}

