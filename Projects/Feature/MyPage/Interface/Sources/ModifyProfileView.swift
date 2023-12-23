//
//  ModifyProfileView.swift
//  FeatureMyPageInterface
//
//  Created by coco on 2023/12/22.
//

import UIKit
import Shared

// TODO: 이미지 합치기
class ModifyProfileView: UIView {
    let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    let contentView = UIView()
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = SharedDSKitAsset.Icons.userProfile.image
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    let usernameView = ModifyProfileTextField()
    let emailView = ModifyProfileTextField()
    let postionView = ModifyProfileTextField()
    let titleLabel: UILabel = {
        var label = UILabel()
        label.text = "관심사"
        label.font = Fonts.SH03Bold.font
        label.textColor = SharedDSKitAsset.Colors.gr100.color
        return label
    }()
    let firstSubTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "자기계발"
        label.font = Fonts.SH01.font
        label.textColor = SharedDSKitAsset.Colors.text03.color
        return label
    }()
    let developHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    let secondSubTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "취미"
        label.font = Fonts.SH01.font
        label.textColor = SharedDSKitAsset.Colors.text03.color
        return label
    }()
    let hobbyHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.setTitleColor(SharedDSKitAsset.Colors.white.color, for: .normal)
        button.backgroundColor = SharedDSKitAsset.Colors.lightGreen.color
        button.layer.cornerRadius = 12
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = SharedDSKitAsset.Colors.bgWhite.color
    
        usernameView.titleLabel.text = "닉네임"
        usernameView.textField.text = "청계산 다람쥐"
        emailView.titleLabel.text = "생년월일"
        emailView.textField.text = "1991/02/19"
        postionView.titleLabel.text = "직무"
        postionView.textField.text = "기획·전략·경영"
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(contentScrollView)
        contentScrollView.addSubview(contentView)
        
        [mainImageView, verticalStackView, titleLabel, firstSubTitleLabel, developHorizontalStackView, secondSubTitleLabel, hobbyHorizontalStackView, saveButton].forEach {
            contentView.addSubview($0)
        }
        
        [usernameView, emailView, postionView].forEach {
            verticalStackView.addArrangedSubview($0)
        }
        
//        [].forEach {
//            developHorizontalStackView.addArrangedSubview($0)
//        }
        
//        [].forEach {
//            hobbyHorizontalStackView.addArrangedSubview($0)
//        }
    }
    
    func setupConstraints() {
        contentScrollView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.leading.trailing.bottom.equalTo(contentScrollView.contentLayoutGuide)
            $0.top.equalTo(contentScrollView.contentLayoutGuide)
            $0.width.equalTo(contentScrollView.frameLayoutGuide)
        }
        
        mainImageView.snp.makeConstraints {
            $0.width.height.equalTo(96)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(16)
        }
        
        verticalStackView.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(verticalStackView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        firstSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        developHorizontalStackView.backgroundColor = .red
        developHorizontalStackView.snp.makeConstraints {
            $0.top.equalTo(firstSubTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }
        
        secondSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(developHorizontalStackView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        hobbyHorizontalStackView.backgroundColor = .blue
        hobbyHorizontalStackView.snp.makeConstraints {
            $0.top.equalTo(secondSubTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(hobbyHorizontalStackView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(23)
        }
    }
}
