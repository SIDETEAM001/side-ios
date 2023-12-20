//
//  CellRowView.swift
//  FeatureMyPageInterface
//
//  Created by coco on 2023/12/18.
//

import UIKit
import Shared

class CellRowView: UIView {
    let mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = SharedDSKitAsset.Colors.gr100.color
        label.font = Fonts.Body02.font
        return label
    }()
    let arrowIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = SharedDSKitAsset.Icons.iconArrowRight16.image
        return imageView
    }()
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Body02.font
        label.textColor = SharedDSKitAsset.Colors.text03.color
        return label
    }()
    
    init(title: String) {
        super.init(frame: .zero)

        mainLabel.text = title
        countLabel.text = "0"
        [mainLabel, countLabel, arrowIcon].forEach{
            self.addSubview($0)
        }
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide

        mainLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(safeArea).inset(16)
            $0.leading.equalToSuperview().offset(20)
            $0.width.greaterThanOrEqualTo(277)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(safeArea).inset(16)
            $0.leading.equalTo(mainLabel.snp.trailing).offset(16)
        }
        
        arrowIcon.snp.makeConstraints {
            $0.width.height.equalTo(16)
            $0.top.bottom.equalTo(safeArea).inset(20)
            $0.trailing.equalTo(safeArea).inset(20)
            $0.leading.equalTo(countLabel.snp.trailing).offset(16)
        }
    }
}
