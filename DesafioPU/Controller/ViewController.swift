//
//  ViewController.swift
//  teste
//
//  Created by Guilherme Siepmann on 06/11/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import UIKit

enum ViewControllerType {
    case city, trip, product, favorites, none
}

class ViewController: UIViewController {
    
    enum Sections {
        case banner, deals
    }
    
    private var type: ViewControllerType
    private var dealsPresenter: DealsPresenter!
    private var dealsResponse: [Deal] = []
    private var bannersResponse: [Banner] = []
    private var availableSections: [Sections] = []
    
    private let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let reloadButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: ""), for: .normal)
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(reloadAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .whiteLarge)
        loading.tintColor = .black
        loading.hidesWhenStopped = true
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
    }()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: UIScreen.main.bounds, style: .plain)
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    init(with type: ViewControllerType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.type = .none
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.hidesBarsOnSwipe = self.type != .favorites
        
        if type == .favorites {
            self.navigationController?.navigationBar.topItem?.title = " "
            NotificationCenter.default.addObserver(self, selector: #selector(reloadAction), name: Notification.Name("refreshFavorites"), object: nil)
        }
        
        self.createViewHierarchy()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        dealsPresenter = DealsPresenter(service: APIFactory.shared.baseService,
                                        viewControllerType: self.type,
                                        dealsView: self)
        
        dealsPresenter.onStart()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 300
        
        tableView.register(BannerTableViewCell.self, forCellReuseIdentifier: BannerTableViewCell.reusableIdentifier)
        tableView.register(DealTableViewCell.self, forCellReuseIdentifier: DealTableViewCell.reusableIdentifier)
    }
    
    @objc private func reloadAction() {
        self.dealsPresenter.onStart()
    }
    
    deinit {
        if type == .favorites {
            NotificationCenter.default.removeObserver(self)
        }

    }
}

//MARK: - UITableView datasource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return availableSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch availableSections[section] {
        case .banner:
            return bannersResponse.count > 0 ? 1 : 0
        case .deals:
            return dealsResponse.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch availableSections[indexPath.section] {
        case .banner:
            let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.reusableIdentifier, for: indexPath)
            (cell as! BannerTableViewCell).setupCell(with: self.bannersResponse)
            return cell
        case .deals:
            let cell = tableView.dequeueReusableCell(withIdentifier: DealTableViewCell.reusableIdentifier, for: indexPath)
            (cell as! DealTableViewCell).setupCell(with: self.dealsResponse[indexPath.row])
            return cell
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch availableSections[indexPath.section] {
        case .banner:
            return 150
        case .deals:
            return 200
        }
    }
}


//MARK: - Constraints Creation
extension ViewController {
    private func createViewHierarchy() {
        self.view.addSubview(loadingIndicator)
        self.view.addSubview(errorMessageLabel)
        self.view.addSubview(reloadButton)
        self.view.addSubview(tableView)
        
        self.setupTableConstraints()
        self.setupLoadingConstraints()
        self.setupErrorMessageConstraints()
        self.setupReloadButtonConstraints()
    }
    
    private func setupTableConstraints() {
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
    }
    
    private func setupLoadingConstraints() {
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
    }
    
    private func setupErrorMessageConstraints() {
        NSLayoutConstraint.activate([
            errorMessageLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            errorMessageLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            errorMessageLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            errorMessageLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16)
            ])
    }
    
    private func setupReloadButtonConstraints() {
        NSLayoutConstraint.activate([
            reloadButton.widthAnchor.constraint(equalToConstant: 20),
            reloadButton.heightAnchor.constraint(equalToConstant: 20),
            reloadButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            reloadButton.bottomAnchor.constraint(equalTo: self.errorMessageLabel.topAnchor, constant: 8)
            ])
    }
}

// MARK: - View Delegates
extension ViewController: DealsView {
    func showLoadingStatus() {
        DispatchQueue.main.async {
            self.loadingIndicator.startAnimating()
        }
    }
    
    func hideLoadingStatus() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
        }
    }
    
    func showErrorWith(message: String) {
        DispatchQueue.main.async {
            self.errorMessageLabel.isHidden = false
            self.tableView.isHidden = true
            
            self.errorMessageLabel.text = message
        }
    }
    
    func show(deals: DealModel) {
        DispatchQueue.main.async {
            self.errorMessageLabel.isHidden = true
            self.tableView.isHidden = false
            
            if let banners = deals.response?.banners {
                self.bannersResponse = banners
                if !self.availableSections.contains(.banner) {
                    self.availableSections.append(.banner)
                }
            }
            
            if let deals = deals.response?.deals {
                self.dealsResponse = deals
                if !self.availableSections.contains(.deals) {
                    self.availableSections.append(.deals)
                }
            }
            
            self.tableView.reloadData()
        }
    }
    
    func showFavorites(deals: [Deal]) {
        DispatchQueue.main.async {
            self.errorMessageLabel.isHidden = true
            self.tableView.isHidden = false
            
            self.dealsResponse = deals
            self.availableSections = [.deals]
            
            self.tableView.reloadData()
        }
    }
}
