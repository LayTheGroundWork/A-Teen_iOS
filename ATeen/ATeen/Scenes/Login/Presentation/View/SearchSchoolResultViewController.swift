//
//  SearchSchoolResultTableViewController.swift
//  ATeen
//
//  Created by 김명현 on 5/29/24.
//

import UIKit

class SearchSchoolResultTableViewController: UITableView, UITableViewDelegate, UITableViewDataSource {
    var schools: [String] = []
    var filteredSchools: [String] = []
    weak var searchDelegate: SchoolTableViewSearchDelegate?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.register(SeachSchoolResultTableViewCell.self, forCellReuseIdentifier: "SchoolCell")
        self.delegate = self
        self.dataSource = self
    }
    
    func filterSchools(with query: String) {
        if query.isEmpty {
            filteredSchools = []
        } else {
            filteredSchools = schools.filter { school in
                guard school.count >= query.count else {
                    return false
                }
                
                for (index, char) in query.enumerated() {
                    let schoolChar = school[school.index(school.startIndex, offsetBy: index)]
                    if char != schoolChar {
                        return false
                    }
                }
                return true
            }
        }
        self.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSchools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolCell", for: indexPath) as? SeachSchoolResultTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: filteredSchools[indexPath.row])
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchDelegate?.didSelectSchool(filteredSchools[indexPath.row])
    }
}



protocol SchoolTableViewSearchDelegate: AnyObject {
    func didSelectSchool(_ schoolName: String)
}





//class SchoolSearchViewController: UIViewController, SchoolTableViewSearchDelegate, UITextFieldDelegate {
//    
//    let searchTextField = SeachSchoolViewController().textField
//    let schoolTableView = SchoolTableView()
//    let searchButton = UIButton()
//    
//    // 예시 데이터 (학교 이름)
//    let schools = ["seoul", "busan", "busan2", "changwon", "anyang"]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // UI 설정
//        
//        // 델리게이트 설정
//        searchTextField.delegate = self
//        schoolTableView.searchDelegate = self
//        
//        // 학교 데이터 설정
//        schoolTableView.schools = schools
//    }
//    
//    @objc private func textFieldDidChange(_ textField: UITextField) {
//        guard let query = textField.text else { return }
//        schoolTableView.filterSchools(with: query)
//    }
//    
//    // MARK: - SchoolTableViewSearchDelegate
//    
//    func didSelectSchool(_ schoolName: String) {
//        searchTextField.text = schoolName
//    }
//}
