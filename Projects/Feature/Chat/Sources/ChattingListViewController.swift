//
//  ChattingListViewController.swift
//  FeatureChat
//
//  Created by 강민성 on 11/21/23.
//

import UIKit
import Shared

import SnapKit
import FeatureChatInterface

public struct MockUpChatData {
    var mockup = [MockUpChatModel(id: 1, image: SharedDSKitAsset.Icons.kakao.image, title: "영화관투어모임 영사모 >_<", latestMessage: "네 알겠습니다!", count: 122, timestamp: "12:01", isAlarmOn: true), MockUpChatModel(id: 2, image: SharedDSKitAsset.Icons.kakao.image, title: "테스트", latestMessage: "테스트입니다", count: 2, timestamp: "12:01", isAlarmOn: false)]
}


class ChattingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var chattingListTableView: UITableView = {
        var tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    var mockUpData = MockUpChatData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        render()
    }
    
    func setup() {
        chattingListTableView.register(
            ChattingListTableViewCell.self,
            forCellReuseIdentifier: ChattingListTableViewCell.className
        )
        
        chattingListTableView.delegate = self
        chattingListTableView.dataSource = self
    }
    
    func render() {
        view.addSubViews([chattingListTableView])
        
        chattingListTableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockUpData.mockup.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ChattingListTableViewCell()
        let data = self.mockUpData.mockup[indexPath.row]
        
        cell.roomImageView.image = data.image
        cell.roomTitleLabel.text = data.title
        cell.latestMessageLabel.text = data.latestMessage
        cell.countLabel.text = String(data.count)
        cell.timestampLabel.text = data.timestamp
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let mockup = self.mockUpData.mockup[indexPath.row]
        
        let alarmToggle = UIContextualAction(style: .normal, title: "") { (_, _, success: @escaping (Bool) -> Void) in
            print("Alarm toggled")
            self.mockUpData.mockup[indexPath.row].isAlarmOn.toggle()
            self.chattingListTableView.reloadRows(at: [indexPath], with: .automatic)
            success(true)
        }
        alarmToggle.image = mockup.isAlarmOn ? SharedDSKitAsset.Icons.bellDefault.image : SharedDSKitAsset.Icons.bellOff.image
        alarmToggle.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [alarmToggle])
    }
}
