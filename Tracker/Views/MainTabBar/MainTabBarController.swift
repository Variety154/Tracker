//
//  MainTabBarController.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 17.11.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private lazy var separatorLine: UIView = {
        let line = UIView()
        line.backgroundColor = AppColors.Fixed.gray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        tabBar.addSubview(separatorLine)
        
        NSLayoutConstraint.activate([
            separatorLine.topAnchor.constraint(equalTo: tabBar.topAnchor),
            separatorLine.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func addTabItems() {
        let trackerViewController = UINavigationController(rootViewController: TrackersViewController())
        trackerViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Record"), tag: 0)
        
        let statisticsViewController = UINavigationController(rootViewController: StatisticsViewController())
        statisticsViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Hare"), tag: 1)
        
        self.viewControllers = [trackerViewController, statisticsViewController]
    }
}
