//
//  ModifyProfileViewController.swift
//  FeatureMyPageInterface
//
//  Created by coco on 2023/12/22.
//

import UIKit
import Shared

class ModifyProfileViewController: UIViewController {
    let modifyProfileView = ModifyProfileView()

    override func loadView() {
        super.loadView()
        
        self.view = modifyProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationbar()
    }
    
    func setNavigationbar() {
        self.navigationController?.navigationBar.tintColor = SharedDSKitAsset.Colors.gr100.color
        self.navigationItem.title = "프로필수정"
    }
}
