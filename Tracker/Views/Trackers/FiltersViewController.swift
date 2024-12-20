//
//  FiltersViewController.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 02.12.2024.
//

import UIKit

final class FiltersViewController: BasicViewController {
    private let delegate: FilterDelegateProtocol
    
    //private var filter:
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("filters.title", comment: "Filters screen title")
        label.font = Fonts.titleMediumFont
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = AppColors.Dynamic.white
        table.register(SelectionTableViewCell.self, forCellReuseIdentifier: "cell")
        table.layer.cornerRadius = Constants.radius
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    init(delegate: FilterDelegateProtocol) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        self.screenName = AnalyticsEventData.FiltersScreen.name
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppColors.Dynamic.white
        setupLayout()
        tableView.reloadData()
    }
    
    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Insets.leading),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Insets.trailing),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource и UITableViewDelegate
extension FiltersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Filters.allCases.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = Filters.allCases.count
        
        cell.layer.mask = nil
        
        if indexPath.row == count - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.width)
            let maskPath = UIBezierPath(roundedRect: cell.bounds,
                                        byRoundingCorners: [.bottomLeft, .bottomRight],
                                        cornerRadii: CGSize(width: 16.0, height: 16.0))
            let maskLayer = CAShapeLayer()
            maskLayer.path = maskPath.cgPath
            cell.layer.mask = maskLayer
        } else {
            cell.layer.mask = nil
            cell.separatorInset = Insets.separatorInset
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SelectionTableViewCell else {
            return UITableViewCell()
        }
        
        let filter = Filters.allCases[indexPath.row]
        let isSelected = filter == delegate.currentFilter
        
        cell.configure(text: filter.localized, isSelected: isSelected)
        cell.backgroundColor = AppColors.Dynamic.background
        cell.layoutMargins = Insets.cellInsets
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedFilter = Filters.allCases[indexPath.row]
        delegate.didSelectFilter(filter: selectedFilter)
        
        Log.info(message: "reporting filter selection event")
        AnalyticsService.shared.trackEvent(event: .click, params: AnalyticsEventData.FiltersScreen.selectFilter)
        dismiss(animated: true)
    }
}
