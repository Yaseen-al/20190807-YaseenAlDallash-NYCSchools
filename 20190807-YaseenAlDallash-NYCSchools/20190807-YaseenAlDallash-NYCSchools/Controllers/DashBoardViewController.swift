//
//  ViewController.swift
//  20190807-YaseenAlDallash-NYCSchools
//
//  Created by Yaseen Al Dallash on 8/7/19.
//  Copyright © 2019 Yaseen AlDallash. All rights reserved.
//

import UIKit

/// Hanldes showing a list of all schools
/// This could be a map as well and show schools on the map
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
        
        viewModel.showError = { [weak self] in
            DispatchQueue.main.async {
                self?.presenetErrorAlert()
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
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailedSchoolViewModel = viewModel.getDetailedHighSchoolViewModel(from: indexPath) else { return }
        self.navigationController?.pushViewController(DetailedHighSchoolTableViewController(viewModel: detailedSchoolViewModel),
                                                      animated: true)
    }
    
    // MARK: - Error handling
    func presenetErrorAlert() {
        let alertController = UIAlertController(title: "Couldn't Fetch NYC Schools", message: "It migh be a connection issue!!", preferredStyle: .alert)
        let tryAgainAction = UIAlertAction(title: "Try Again", style: .default) {[weak self] _ in
            self?.viewModel.getHighSchools()
        }
        let dimissAction = UIAlertAction(title: "Cancel", style: .destructive)
        alertController.addAction(tryAgainAction)
        alertController.addAction(dimissAction)
        self.present(alertController, animated: true)
    }
}


class DashBoardViewModel {
    // MARK: - Properties
    var highSchools = [HighSchoolModel]()
    
    // MARK: - Bindings
    var reloadDataSource: (()->Void)?
    var showError: (()->Void)?
    
    // MARK: - TableView setup
    func numberOfCell()->Int {
        return highSchools.count
    }
    
    
    func getDetailedHighSchoolViewModel(from indexPath: IndexPath) -> DetailedHighSchoolViewModel? {
        guard indexPath.row < highSchools.count else { return nil }
        return DetailedHighSchoolViewModel(highSchool: highSchools[indexPath.row])
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
                self?.showError?()
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
