//
//  CategorySelectedSelfDevelopmentView.swift
//  FeatureHome
//
//  Created by yoonyeosong on 2023/12/06.
//

import UIKit
import Shared

public class CategorySelectedSelfDevelopmentView: UIView {
    
    let tableView:UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: .zero, height: 50)
        return scrollView
    }()
     let segmentedControl: UISegmentedControl = {
        let segmentedControl = UnderlineSegmentedControl(items: ["스터디/자격증", "사이드 프로젝트", "이직 준비", "어학","제테크","기타"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: SharedDSKitAsset.Colors.text03.color,
                                                 .font: Fonts.Body02.font], for: .normal)
        segmentedControl.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: SharedDSKitAsset.Colors.lightGreen.color,
                .font: Fonts.SH02Bold.font
            ],
            for: .selected
        )
        
        return segmentedControl
    }()
    
    let vc1: UIView = {
        let vc = UIView()
        vc.backgroundColor = .red
  
      return vc
    }()
    let vc2: UIView = {
        let vc = UIView()
        vc.backgroundColor = .green
        vc.isHidden = true
        return vc
    }()
    let vc3: UIView = {
        let vc = UIView()
        vc.backgroundColor = .blue
        vc.isHidden = true
        return vc
    }()
    
    let entireButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = Fonts.Caption.font
        button.setTitle("전체", for: .normal)
        button.setTitleColor(SharedDSKitAsset.Colors.text01.color, for: .normal)
        button.backgroundColor = SharedDSKitAsset.Colors.bgGray.color
        button.layer.cornerRadius = 16
        return button
    }()
    
    let oneDayButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = Fonts.Caption.font
        button.setTitle("원데이", for: .normal)
        button.setTitleColor(SharedDSKitAsset.Colors.text01.color, for: .normal)
        button.backgroundColor = SharedDSKitAsset.Colors.bgGray.color
        button.layer.cornerRadius = 16
        return button
    }()
    
    let shortTermButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = Fonts.Caption.font
        button.setTitle("단기", for: .normal)
        button.setTitleColor(SharedDSKitAsset.Colors.text01.color, for: .normal)
        button.backgroundColor = SharedDSKitAsset.Colors.bgGray.color
        button.layer.cornerRadius = 16
        return button
    }()
    
    let longTermButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = Fonts.Caption.font
        button.setTitle("지속", for: .normal)
        button.setTitleColor(SharedDSKitAsset.Colors.text01.color, for: .normal)
        button.backgroundColor = SharedDSKitAsset.Colors.bgGray.color
        button.layer.cornerRadius = 16
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("hello")
        render()
    }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    func render() {
        let tp = TPBasicFilterChips()
        self.backgroundColor = .white
        scrollView.addSubview(segmentedControl)
        addSubViews([entireButton, oneDayButton, shortTermButton, longTermButton, scrollView, tableView, vc2, vc3])
        tp.smallEnabledChips.setTitle("전체", for: .normal)
        tp.smallEnabledChips.setTitleColor(SharedDSKitAsset.Colors.text01.color, for: .normal)
       
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        segmentedControl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        entireButton.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(45)
            make.height.equalTo(32)
        }
        oneDayButton.snp.makeConstraints { make in
            make.top.equalTo(entireButton.snp.top)
            make.leading.equalTo(entireButton.snp.trailing).offset(8)
            make.width.equalTo(56)
            make.height.equalTo(32)
        }
        shortTermButton.snp.makeConstraints { make in
            make.top.equalTo(entireButton.snp.top)
            make.leading.equalTo(oneDayButton.snp.trailing).offset(8)
            make.width.equalTo(45)
            make.height.equalTo(32)
        }
        longTermButton.snp.makeConstraints { make in
            make.top.equalTo(entireButton.snp.top)
            make.leading.equalTo(shortTermButton.snp.trailing).offset(8)
            make.width.equalTo(45)
            make.height.equalTo(32)
        }
        
//        vc1.snp.makeConstraints { make in
//            make.top.equalTo(entireButton.snp.bottom).offset(8)
//            make.leading.trailing.equalToSuperview()
//            make.bottom.equalToSuperview()
//        }
        vc2.snp.makeConstraints { make in
            make.top.equalTo(entireButton.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        vc3.snp.makeConstraints { make in
            make.top.equalTo(entireButton.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(entireButton.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
