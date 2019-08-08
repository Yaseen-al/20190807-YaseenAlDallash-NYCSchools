//
//  ViewController.swift
//  20190807-YaseenAlDallash-NYCSchools
//
//  Created by Yaseen Al Dallash on 8/7/19.
//  Copyright © 2019 Yaseen AlDallash. All rights reserved.
//

import UIKit

class DashBoardViewController: UITableViewController {
    
    var viewModel = DashBoardViewModel()

    // MARK: - ViewLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        bindViewModel()
        setupTableView()
        viewModel.getHighSchools()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.dynamicallySizeHeader()
        tableView.dynamicallySizeFooter()
    }
    
    // MARK: - ViewModelBinding
    
    private func bindViewModel() {
        viewModel.reloadDataSource = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - NavBar Setup
    func setupNavBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - TableView Setup
    
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        DashboardTableViewCell.register(to: tableView)
        UITableViewCell.register(to: tableView, forCellReuseIdentifier: "customCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCell()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DashboardTableViewCell.dequeue(from: tableView, with: indexPath)
        guard let cellUIModel = viewModel.getCellUIModel(for: indexPath) else { return cell }
        cell.configure(titleText: cellUIModel.title,
                       subtitleText: cellUIModel.subtitle,
                       sideImage: nil,
                       bodyLabelText: cellUIModel.bodyText)
        return cell
    }
}


class DashBoardViewModel {
    
    // MARK: - Bindings
    var highSchools = [HighSchoolModel]()
    var reloadDataSource: (()->Void)?
    
    // MARK: - TableView setup
    func numberOfCell()->Int {
        return highSchools.count
    }
    
    func getCellUIModel(for indexPath: IndexPath) -> DashBoardCellUIModel? {
        guard indexPath.row < highSchools.count else { return nil }
        return DashBoardCellUIModel(highSchoolModel: highSchools[indexPath.row])
    }
    
    
    func getHighSchools() {
        let endPoint = HighSchoolDirectoryEndPoint.fetchAllHighSchools
        Networking.request(from: endPoint,
                           completion: hanldleGetHighSchoolsResponse())
    }
    
    
    func hanldleGetHighSchoolsResponse() -> (Result<[HighSchoolModel], Error>) -> Void {
        return { [weak self] (result: Result<[HighSchoolModel], Error>) in
            switch result {
            case .success(let highSchools):
                self?.highSchools = highSchools
                self?.reloadDataSource?()
            case .failure(let error):
                // Display error
                Logger.log(error, eventType: .error)
            }
        }
    }
}

struct DashBoardCellUIModel {
    let title: String
    let subtitle: String
    let bodyText: String
    init(highSchoolModel: HighSchoolModel) {
        self.title = highSchoolModel.schoolName?.capitalizeFirstLetter() ?? "High School"
        let borough = highSchoolModel.borough?.capitalizeFirstLetter() ?? ""
        self.subtitle = "Borough: \(borough)"
        self.bodyText = highSchoolModel.overviewParagraph?.capitalizeFirstLetter() ?? ""
    }
}
