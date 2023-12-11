//
//  CategorySelectedSelfDevelopmentViewController.swift
//  FeatureHome
//
//  Created by yoonyeosong on 2023/12/07.
//

import UIKit
import RxCocoa
import Shared

public class CategorySelectedSelfDevelopmentViewController: UIViewController {
    var selfDevelopmentView = CategorySelectedSelfDevelopmentView()
    var labelData = ["[디자이너 급구] 사이드 프로젝트", "[백엔드] 사이드 프로젝트하실 자바 백엔드 구합니다.", "서비스 기획 스터디 모집", "대기업 이직 준비", "영어 회화 스터디 모집", "코테 스터디 모집"]
    var tagData = ["단기", "원데이", "지속", "단기", "원데이", "지속"]
    
    public override func loadView() {
            super.loadView()
            view = selfDevelopmentView
        }
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.selfDevelopmentView.studyButton.setTitleColor(SharedDSKitAsset.Colors.green.color, for: .normal)
        self.selfDevelopmentView.studyButton.titleLabel?.font = Fonts.SH02Bold.font
        self.selfDevelopmentView.vc1.isHidden = false
     
   
        
        selfDevelopmentView.tableView.delegate = self
        selfDevelopmentView.tableView.dataSource = self
        selfDevelopmentView.tableView.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
        
        selfDevelopmentView.tableView1.delegate = self
        selfDevelopmentView.tableView1.dataSource = self
        selfDevelopmentView.tableView1.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
        
        itemClicked()
        
    }
    
    func itemClicked() {
        selfDevelopmentView.studyButton.rx.tap.subscribe(onNext: {
            self.selfDevelopmentView.studyButton.setTitleColor(SharedDSKitAsset.Colors.green.color, for: .normal)
            self.selfDevelopmentView.studyButton.titleLabel?.font = Fonts.SH02Bold.font
            self.selfDevelopmentView.vc1.isHidden = false
            //나머지 버튼은 Unselected상태로 변경
            self.selfDevelopmentView.sideProjectButton.setTitleColor(SharedDSKitAsset.Colors.text03.color, for: .normal)
            self.selfDevelopmentView.sideProjectButton.titleLabel?.font = Fonts.Body02.font
            self.selfDevelopmentView.changeJobButton.setTitleColor(SharedDSKitAsset.Colors.text03.color, for: .normal)
            self.selfDevelopmentView.changeJobButton.titleLabel?.font = Fonts.Body02.font
            self.selfDevelopmentView.languageButton.setTitleColor(SharedDSKitAsset.Colors.text03.color, for: .normal)
            self.selfDevelopmentView.languageButton.titleLabel?.font = Fonts.Body02.font
            
            self.selfDevelopmentView.vc2.isHidden = true
            self.selfDevelopmentView.vc3.isHidden = true
            self.selfDevelopmentView.languageView.isHidden = true
            
        })
        selfDevelopmentView.sideProjectButton.rx.tap.subscribe(onNext: {
            self.selfDevelopmentView.sideProjectButton.setTitleColor(SharedDSKitAsset.Colors.green.color, for: .normal)
            self.selfDevelopmentView.sideProjectButton.titleLabel?.font = Fonts.SH02Bold.font
            self.selfDevelopmentView.vc2.isHidden = false
            
            self.selfDevelopmentView.studyButton.setTitleColor(SharedDSKitAsset.Colors.text03.color, for: .normal)
            self.selfDevelopmentView.studyButton.titleLabel?.font = Fonts.Body02.font
            self.selfDevelopmentView.changeJobButton.setTitleColor(SharedDSKitAsset.Colors.text03.color, for: .normal)
            self.selfDevelopmentView.changeJobButton.titleLabel?.font = Fonts.Body02.font
            self.selfDevelopmentView.languageButton.setTitleColor(SharedDSKitAsset.Colors.text03.color, for: .normal)
            self.selfDevelopmentView.languageButton.titleLabel?.font = Fonts.Body02.font
            
            self.selfDevelopmentView.vc1.isHidden = true
            self.selfDevelopmentView.vc3.isHidden = true
            self.selfDevelopmentView.languageView.isHidden = true
        })
        
        selfDevelopmentView.changeJobButton.rx.tap.subscribe(onNext: {
            self.selfDevelopmentView.changeJobButton.setTitleColor(SharedDSKitAsset.Colors.green.color, for: .normal)
            self.selfDevelopmentView.changeJobButton.titleLabel?.font = Fonts.SH02Bold.font
            self.selfDevelopmentView.vc3.isHidden = false
            
            self.selfDevelopmentView.studyButton.setTitleColor(SharedDSKitAsset.Colors.text03.color, for: .normal)
            self.selfDevelopmentView.studyButton.titleLabel?.font = Fonts.Body02.font
            self.selfDevelopmentView.sideProjectButton.setTitleColor(SharedDSKitAsset.Colors.text03.color, for: .normal)
            self.selfDevelopmentView.sideProjectButton.titleLabel?.font = Fonts.Body02.font
            self.selfDevelopmentView.languageButton.setTitleColor(SharedDSKitAsset.Colors.text03.color, for: .normal)
            self.selfDevelopmentView.languageButton.titleLabel?.font = Fonts.Body02.font
            
            self.selfDevelopmentView.vc1.isHidden = true
            self.selfDevelopmentView.vc2.isHidden = true
            self.selfDevelopmentView.languageView.isHidden = true
            
        })
        
        selfDevelopmentView.languageButton.rx.tap.subscribe(onNext: {
            self.selfDevelopmentView.languageButton.setTitleColor(SharedDSKitAsset.Colors.green.color, for: .normal)
            self.selfDevelopmentView.languageButton.titleLabel?.font = Fonts.SH02Bold.font
            self.selfDevelopmentView.languageView.isHidden = false
            
            self.selfDevelopmentView.studyButton.setTitleColor(SharedDSKitAsset.Colors.text03.color, for: .normal)
            self.selfDevelopmentView.studyButton.titleLabel?.font = Fonts.Body02.font
            self.selfDevelopmentView.sideProjectButton.setTitleColor(SharedDSKitAsset.Colors.text03.color, for: .normal)
            self.selfDevelopmentView.sideProjectButton.titleLabel?.font = Fonts.Body02.font
            self.selfDevelopmentView.changeJobButton.setTitleColor(SharedDSKitAsset.Colors.text03.color, for: .normal)
            self.selfDevelopmentView.changeJobButton.titleLabel?.font = Fonts.Body02.font
            
            self.selfDevelopmentView.vc1.isHidden = true
            self.selfDevelopmentView.vc2.isHidden = true
            self.selfDevelopmentView.vc3.isHidden = true
            
        })
 
        
    }
}

extension CategorySelectedSelfDevelopmentViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemCell else {
           
            return UITableViewCell()
         }
        cell.label.text = labelData[indexPath.row]
        cell.tagButton.setTitle(tagData[indexPath.row], for: .normal)
        if cell.tagButton.currentTitle == "단기"{
            cell.tagButton.backgroundColor = UIColor(red: 227/255, green: 238/255, blue: 251/255, alpha: 1)
            cell.tagButton.setTitleColor(UIColor(red: 0, green: 85/255, blue: 163/255, alpha: 1), for: .normal)
        } else if cell.tagButton.currentTitle == "원데이" {
            cell.tagButton.backgroundColor = UIColor(red: 251/255, green: 235/255, blue: 251/255, alpha: 1)
            cell.tagButton.setTitleColor(UIColor(red: 224/255, green: 99/255, blue: 36/255, alpha: 1), for: .normal)
        } else {
            cell.tagButton.backgroundColor = UIColor(red: 235/255, green: 248/255, blue: 220/255, alpha: 1)
            cell.tagButton.setTitleColor(UIColor(red: 81/255, green: 163/255, blue: 0, alpha: 1), for: .normal)
        }
        return cell
        
    }
}
