//
//  OnboardingViewController.swift
//  ois-ios
//
//  Created by Акиш Акан on 17.06.2022.
//

import UIKit
import SnapKit
import paper_onboarding

class OnboardingViewController: UIViewController {
    
    enum Constants {
        static let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
        static let descriptionFont = UIFont(name: "HelveticaNeue", size: 15.0) ?? UIFont.systemFont(ofSize: 15.0)
    }
    
    fileprivate let screens = [
        OnboardingItemInfo(informationImage: UIImage(named: "database")!,
                           title: "База данных",
                           description: "Полный доступ к истории болезней пациентов",
                           pageIcon: UIImage(named: "database")!,
                           color: UIColor(red: 217/255, green: 72/255, blue: 89/255, alpha: 1),
                           titleColor: UIColor.white, descriptionColor: UIColor.white,
                           titleFont: Constants.titleFont, descriptionFont: Constants.descriptionFont),
        
        OnboardingItemInfo(informationImage: UIImage(named: "document")!,
                           title: "ЭДО",
                           description: "Полный электронный документооборот",
                           pageIcon: UIImage(named: "document")!,
                           color: UIColor(red: 106/255, green: 166/255, blue: 211/255, alpha: 1),
                           titleColor: UIColor.white, descriptionColor: UIColor.white,
                           titleFont: Constants.titleFont, descriptionFont: Constants.descriptionFont),
        
        OnboardingItemInfo(informationImage: UIImage(named: "service")!,
                           title: "HR сервис",
                           description: "Cовокупность сотрудников, работающих в организации, персонал компании",
                           pageIcon: UIImage(named: "service")!,
                           color: UIColor(red: 168/255, green: 200/255, blue: 78/255, alpha: 1),
                           titleColor: UIColor.white, descriptionColor: UIColor.white,
                           titleFont: Constants.titleFont, descriptionFont: Constants.descriptionFont)
    ]
    
    lazy var onboarding: PaperOnboarding = {
        let onboarding = PaperOnboarding()
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        return onboarding
    }()
    
    var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Давайте начнем", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        button.alpha = 0
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
    }
    
    @objc func startButtonTapped() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "onboardingComplete")
        userDefaults.synchronize()
        
        self.view.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    }
}

extension OnboardingViewController {
    func makeUI() {
        view.addSubview(onboarding)
        view.addSubview(startButton)
        
        // Add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
        
        startButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(1.7)
        }
    }
}

extension OnboardingViewController: PaperOnboardingDataSource, PaperOnboardingDelegate {
    func onboardingItemsCount() -> Int {
        return screens.count
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return screens[index]
    }
    
    func onboardingPageItemSelectedRadius() -> CGFloat {
        return 0
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 1 {
            if self.startButton.alpha == 1 {
                UIView.animate(withDuration: 0.2) {
                    self.startButton.alpha = 0
                }
            }
        }
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 2 {
            UIView.animate(withDuration: 0.4) {
                self.startButton.alpha = 1
            }
        }
    }
}
