//
//  SearchSchoolResultTableViewController.swift
//  ATeen
//
//  Created by 김명현 on 5/29/24.
//

import UIKit

class SearchSchoolResultTableViewController: UITableView, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Public properties
    var schools: [String] = []
    var filteredSchools: [String] = []
    var selectedIndexPath: IndexPath?
    weak var searchDelegate: SchoolTableViewSearchDelegate?
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Helpers
    private func setup() {
        self.register(SearchSchoolResultTableViewCell.self, forCellReuseIdentifier: "SchoolCell")
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolCell", for: indexPath) as? SearchSchoolResultTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: filteredSchools[indexPath.row])
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let previousIndexPath = selectedIndexPath {
            if let previousCell = tableView.cellForRow(at: previousIndexPath) as? SearchSchoolResultTableViewCell {
                previousCell.configure(with: filteredSchools[previousIndexPath.row], isBold: false)
            } // 이전 선택된 Cell Bold 취소
        }
        
        if let selectedCell = tableView.cellForRow(at: indexPath) as? SearchSchoolResultTableViewCell {
            selectedCell.configure(with: filteredSchools[indexPath.row], isBold: true)
        } // 선택된 Cell Bold
        
        selectedIndexPath = indexPath
        searchDelegate?.didSelectSchool(filteredSchools[indexPath.row]) // tableViewCell 선택 시 textField로 값 전달
    }
}

protocol SchoolTableViewSearchDelegate: AnyObject {
    func didSelectSchool(_ schoolName: String)
}
