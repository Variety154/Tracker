//
//  ContentViewController.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 26.11.2024.
//

import UIKit

protocol ContentViewControllerDelegate: AnyObject {
    func didTapPageControl(to page: Int)
}

final class ContentViewController: UIViewController {
    
    weak var delegate: ContentViewControllerDelegate?
    private var backgroundImageName: String = ""
    private var labelText: String = ""
    private var pageControlCurrentPage: Int = 0
    private var pageControlNumberOfPages: Int = 2
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = Fonts.titleLargeFont
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LocalizedStrings.Onboarding.buttonText, for: .normal)
        button.titleLabel?.font = Fonts.titleMediumFont
        button.setTitleColor(AppColors.Fixed.white, for: .normal)
        button.backgroundColor = AppColors.Fixed.black
        button.layer.cornerRadius = Constants.radius
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.currentPageIndicatorTintColor = .black
        control.pageIndicatorTintColor = .lightGray
        control.addTarget(self, action: #selector(pageControlValueChanged(_:)), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    func configure(backgroundImageName: String, labelText: String, currentPage: Int, numberOfPages: Int) {
        self.backgroundImageName = backgroundImageName
        self.labelText = labelText
        self.pageControlCurrentPage = currentPage
        self.pageControlNumberOfPages = numberOfPages
        
        backgroundImageView.image = UIImage(named: backgroundImageName)
        label.text = labelText
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = numberOfPages
    }
    
    private func setupLayout() {
        view.addSubview(backgroundImageView)
        view.addSubview(label)
        view.addSubview(startButton)
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            label.widthAnchor.constraint(equalToConstant: 76),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 64),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Insets.leading),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Insets.trailing),
            
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            startButton.heightAnchor.constraint(equalToConstant: 60),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -24)
        ])
    }
    
    @IBAction
    private func pageControlValueChanged(_ sender: UIPageControl) {
        delegate?.didTapPageControl(to: sender.currentPage)
    }
    
    @IBAction
    private func startButtonTapped() {
        let tabBarController = MainTabBarController()
        tabBarController.addTabItems()
        
        if let window = UIApplication.shared.windows.first {
            UserSettingsManager.shared.isOnboarded = true
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        } else {
            Log.warn(message: "failed to load Trackers")
        }
    }
}
