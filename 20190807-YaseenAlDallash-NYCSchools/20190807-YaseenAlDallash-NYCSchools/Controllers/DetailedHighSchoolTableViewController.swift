//
//  DetailedHighSchoolTableViewController.swift
//  20190807-YaseenAlDallash-NYCSchools
//
//  Created by Yaseen Al Dallash on 8/8/19.
//  Copyright © 2019 Yaseen AlDallash. All rights reserved.
//

import UIKit

class DetailedHighSchoolTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let viewModel: DetailedHighSchoolViewModel
    
    // MARK: - Initialization
    
    init(viewModel: DetailedHighSchoolViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        bindViewModel()
        setupTableView()
        viewModel.getSchoolSAT()
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
        setupTapleViewHeader()
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
    }
    
    func setupTapleViewHeader() {
        let headerView = HeaderView.loadFromNib()
        let headerUIModel = viewModel.getHeaderUIModel()
        headerView.contentViewEdgeInsets = UIEdgeInsets(top: 50, left: 15, bottom: 50, right: 15)
        headerView.addTitle(text: headerUIModel.title, font: .custom(name: .semiBold, size: 18))
        headerView.addTitle(text: headerUIModel.subTitle, font: .custom(name: .regular, size: 18))
        headerView.addTitle(text: headerUIModel.body, font: .custom(name: .light, size: 16))
        
        headerView.layoutIfNeeded()
        tableView.tableHeaderView = headerView
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getSectionTitle(for: section)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows(in: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.dequeue(from: tableView, with: indexPath, with: "defaultCell")
        let title = viewModel.getCellDetails(indexPath: indexPath)?.title ?? ""
        let subTitle = viewModel.getCellDetails(indexPath: indexPath)?.subTitle ?? ""
        cell.textLabel?.text = title + " \(subTitle)"
        return cell
    }

}


class DetailedHighSchoolViewModel {
    
    // MARK: - Properties
    
    let highSchool: HighSchoolModel
    var schoolSAT: SchoolSATModel?
    var dataSource: [DetailedHighSchoolDataSourceRerpesentation]
    
    // MARK: - Bindings
    var reloadDataSource: (()->Void)?
    
    // MARK: - Inits
    
    init(highSchool: HighSchoolModel) {
        self.highSchool = highSchool
        self.dataSource = [DetailedHighSchoolViewModel.getSchoolDetailsSectionDataSource(highSchool)]
    }
    
    static func getSchoolDetailsSectionDataSource(_ highSchool: HighSchoolModel) -> DetailedHighSchoolDataSourceRerpesentation {
        let sectionDataSource: [DetailedHighSchoolRowUIModel]
            = [.init(title: "Attendance rate", subTitle: highSchool.attendanceRate),
               .init(title: "Final Grades", subTitle: highSchool.finalgrades),
               .init(title: "Phone number", subTitle: highSchool.phoneNumber)]
        return .init(sectionName: "School Details", sectionDataSource: sectionDataSource)
    }
    
    func getSATSectionDataSource(_ schoolSATResponse: SchoolSATModel) -> DetailedHighSchoolDataSourceRerpesentation {
        
        let sectionDataSource: [DetailedHighSchoolRowUIModel]
            = [.init(title: "Math Average score", subTitle: schoolSATResponse.satMathAvgScore),
               .init(title: "Reading Average score", subTitle: schoolSATResponse.satCriticalReadingAvgScore),
               .init(title: "Writing Average score", subTitle: schoolSATResponse.satWritingAvgScore)]
        return .init(sectionName: "SAT Details", sectionDataSource: sectionDataSource)
    }
    
    func getSchoolSAT() {
        guard let dbpn = highSchool.dbn else { return }
        let endPoint = SchoolSATEndPoint.retrieveByDbn(dbn: dbpn)
        Networking.request(from: endPoint,
                           completion: hanldleGetSchoolSATResponse())
    }
    
    func getSectionTitle(for section: Int) -> String {
        guard section < dataSource.count else { return "" }
        return dataSource[section].sectionName
    }
    
    func getNumberOfRows(in section: Int) -> Int {
        guard section < dataSource.count, let sectionDataSoure = dataSource[section].sectionDataSource else { return 0 }
        return sectionDataSoure.count
    }
    
    func getHeaderUIModel() -> HeaderUIModel {
        return HeaderUIModel(highSchool: highSchool)
    }
    
    func getCellDetails(indexPath: IndexPath) -> DetailedHighSchoolRowUIModel? {
        guard indexPath.section < dataSource.count,
            let sectionDataSoure = dataSource[indexPath.section].sectionDataSource,
            indexPath.row < sectionDataSoure.count else { return nil }
        return sectionDataSoure[indexPath.row]

    }
    
    
    func hanldleGetSchoolSATResponse() -> (Result<[SchoolSATModel], Error>) -> Void {
        return { [weak self] (result: Result<[SchoolSATModel], Error>) in
            switch result {
            case .success(let schoolSATResponse):
                guard let self = self,
                    let schoolSatModel = schoolSATResponse.first else {return}
                self.schoolSAT = schoolSatModel
                let satSectionDataSource = self.getSATSectionDataSource(schoolSatModel)
                self.dataSource.append(satSectionDataSource)
                self.reloadDataSource?()
            case .failure(let error):
                Logger.log(error, eventType: .error)
            }
        }
    }
    
}

struct DetailedHighSchoolDataSourceRerpesentation {
    let sectionName: String
    let sectionDataSource: [DetailedHighSchoolRowUIModel]?
}

struct DetailedHighSchoolRowUIModel {
    let title: String
    let subTitle: String?
}

struct HeaderUIModel {
    let title: String
    let subTitle: String
    let body: String
    
    init(highSchool: HighSchoolModel) {
        self.title = highSchool.schoolName?.capitalizeFirstLetter() ?? "High School"
        self.subTitle = highSchool.borough?.capitalizeFirstLetter() ?? ""
        self.body = highSchool.website ?? ""
    }
    
    static func getBalanceTex(balance: Double?) -> String{
        guard let safeBalance = balance else {
            return "Balance is unavailable"
        }
        return "Account balance: $\(safeBalance.description)"
    }
}
