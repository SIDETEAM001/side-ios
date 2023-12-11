//
//  ItemCell2.swift
//  FeatureHome
//
//  Created by yoonyeosong on 2023/12/11.
//

import UIKit
import Shared

class ItemCell2: UITableViewCell {
    private let itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = SharedDSKitAsset.Icons.thumb3.image
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "이기"
        label.textColor = UIColor.gray
        return label
    }()
    
    let tagButton: UIButton  = {
        let button = UIButton()
        button.setTitle("단기", for: .normal)
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 12
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraint()
    }
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder): has not been implemented")
    }
    private func setConstraint() {
        contentView.addSubview(itemImage)
        contentView.addSubview(label)
        contentView.addSubview(tagButton)
        
        itemImage.snp.makeConstraints { make in //top,bottom 제약 모두 줘야 셀 크기 동적으로 조절
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(tagButton.snp.bottom).offset(10)
            make.leading.equalTo(itemImage.snp.trailing).offset(10)
        }
        tagButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(itemImage.snp.trailing).offset(10)
            make.width.equalTo(56)
            make.height.equalTo(25)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
