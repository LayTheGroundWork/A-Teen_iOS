//
//  SearchSchoolResultTableViewController.swift
//  ATeen
//
//  Created by 김명현 on 5/29/24.
//

import UIKit

protocol SchoolTableViewSearchDelegate: AnyObject {
    func didSelectFilteredSchool(schoolName: String)
    func didUpdateFilteredSchools(isEmpty: Bool)
    func didUpdateFilterSchoolsCount(count: Int)
}

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
        self.layer.cornerRadius = ViewValues.defaultRadius
        self.rowHeight = 47 // 디버그창에 Cell 기본 높이 잡으라는 에러떠서 넣음
        self.showsVerticalScrollIndicator = false
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
        searchDelegate?.didUpdateFilteredSchools(isEmpty: filteredSchools.isEmpty)
        searchDelegate?.didUpdateFilterSchoolsCount(count: filteredSchools.count)
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
        cell.selectionStyle = .none // cell 선택 시 테두리 제거
        cell.fontChange(with: filteredSchools[indexPath.row], isBold: indexPath == selectedIndexPath)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let previousIndexPath = selectedIndexPath {
            if let previousCell = tableView.cellForRow(at: previousIndexPath) as? SearchSchoolResultTableViewCell {
                previousCell.fontChange(with: filteredSchools[previousIndexPath.row], isBold: false)
            } // 이전 선택된 Cell Bold 취소
        }
        
        if let selectedCell = tableView.cellForRow(at: indexPath) as? SearchSchoolResultTableViewCell {
            selectedCell.fontChange(with: filteredSchools[indexPath.row], isBold: true)
        } // 선택된 Cell Bold
        
        selectedIndexPath = indexPath
        searchDelegate?.didSelectFilteredSchool(schoolName: filteredSchools[indexPath.row]) // tableViewCell 선택 시 textField로 값 전달
    }
}


