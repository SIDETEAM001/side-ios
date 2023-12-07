//
//  CategorySelectedSelfDevelopmentViewController.swift
//  FeatureHome
//
//  Created by yoonyeosong on 2023/12/07.
//

import UIKit
import RxCocoa

public class CategorySelectedSelfDevelopmentViewController: UIViewController {
    var selfDevelopmentView = CategorySelectedSelfDevelopmentView()
   
    
    public override func loadView() {
            super.loadView()
            view = selfDevelopmentView
        }
    public override func viewDidLoad() {
        super.viewDidLoad()
        selfDevelopmentView.segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        selfDevelopmentView.segmentedControl.selectedSegmentIndex = 0
        
        selfDevelopmentView.tableView.delegate = self
        selfDevelopmentView.tableView.dataSource = self
        
        selfDevelopmentView.tableView.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
        
        
    }
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            selfDevelopmentView.vc1.isHidden = false
            selfDevelopmentView.vc2.isHidden = true
            selfDevelopmentView.vc3.isHidden = true
        }else if segment.selectedSegmentIndex == 1{
            selfDevelopmentView.vc1.isHidden = true
            selfDevelopmentView.vc2.isHidden = false
            selfDevelopmentView.vc3.isHidden = true
        }
        else {
            selfDevelopmentView.vc1.isHidden = true
            selfDevelopmentView.vc2.isHidden = true
            selfDevelopmentView.vc3.isHidden = false
        }
    }
}

extension CategorySelectedSelfDevelopmentViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemCell else {
            return UITableViewCell()
        }
        return cell
    }
}
