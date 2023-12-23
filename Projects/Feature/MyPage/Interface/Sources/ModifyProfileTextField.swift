//
//  ModifyProfileTextField.swift
//  FeatureMyPageInterface
//
//  Created by coco on 2023/12/23.
//

import UIKit
import Shared

class ModifyProfileTextField: UIView {
    var titleLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0.5
        label.font = Fonts.Caption.font
        label.textColor = SharedDSKitAsset.Colors.gr80.color
        return label
    }()
    var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = Fonts.Body02.font
        textField.textColor = SharedDSKitAsset.Colors.gr100.color
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 12
        self.layer.borderColor = SharedDSKitAsset.Colors.gr10.color.cgColor
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        [titleLabel, textField].forEach {
            self.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
}
