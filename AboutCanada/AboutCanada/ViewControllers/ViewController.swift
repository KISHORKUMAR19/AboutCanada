//
//  ViewController.swift
//  AboutCanada
//
//  Created by Sateesh Yemireddi on 7/3/20.
//  Copyright © 2020 Company. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Properties
    
    var countrySpecification = CountrySpecification()
    private weak var specsTableView: UITableView!

    //MARK: - On Load
    
    override func loadView() {
        super.loadView()

        //Setup TableView
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         trailing: view.trailingAnchor)
        self.specsTableView = tableView
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign data source and delegate responsibilities to the viewController
        specsTableView.dataSource = self
        specsTableView.delegate = self
        specsTableView.rowHeight = UITableView.automaticDimension
        specsTableView.estimatedRowHeight = UITableView.automaticDimension

        //Bind the viewModel to UI
        bindDataToUI()
        
        //Fetch Data from API
        countrySpecification.fetchData()
    }

    //MARK: - Data Binding

    private func bindDataToUI() {
        countrySpecification.dataFetchError.bind { [weak self] error in
            guard let `self` = self else { return }
            if let error = error {
                DispatchQueue.main.async {
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    self.displayAlert(with: "About Canada", message: error, actions: [okAction])
                }
            }
        }
        countrySpecification.isDataFetched.bind { [weak self] fetched in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                if fetched { self.specsTableView.reloadData() }
            }
        }
        
        countrySpecification.title.bind { [weak self] title in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.title = title
            }
        }
    }
}

//MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

//MARK: -  UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK: - Alert Displayer

extension UIViewController: AlertDisplayer {}
