import UIKit
import Shared
import SnapKit

class PhoneNumberView: UIView {
    var progressBar: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.progressViewStyle = .bar
        progressBar.progressTintColor = SharedDSKitAsset.Colors.black.color
        progressBar.progress = 1
        
        return progressBar
    }()
    
    var guideOneLabel: UILabel = {
        let label = UILabel()
        label.text = "전화번호를 인증해주세요"
        label.font = Fonts.H01.font
        label.textColor = SharedDSKitAsset.Colors.gr100.color
        
        return label
    }()
    
    var guideTwoLabel: UILabel = {
        let label = UILabel()
        label.text = "신뢰할 수 있는 커뮤니티를 위해 전화번호가 필요해요."
        label.font = Fonts.Body02.font
        label.textColor = SharedDSKitAsset.Colors.text03.color
        
        return label
    }()
    
    let phoneNumberView: UIView = UIView()
    var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "전화번호"
        label.font = Fonts.Caption.font
        label.textColor = SharedDSKitAsset.Colors.gr80.color
        
        return label
    }()
    
    var phoneNumberTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "010-0000-0000", attributes: [NSAttributedString.Key.foregroundColor : SharedDSKitAsset.Colors.gr30.color, NSAttributedString.Key.font : Fonts.Body02.font])
        textField.textColor = SharedDSKitAsset.Colors.gr100.color
        textField.font = Fonts.Body02.font
        
        return textField
    }()
    
    var certificationButton: UIButton = {
        let button = UIButton()
        button.setTitle("인증하기", for: .normal)
        button.backgroundColor = SharedDSKitAsset.Colors.gr10.color
        button.titleLabel?.font = Fonts.Caption.font
        button.setTitleColor(SharedDSKitAsset.Colors.gr30.color, for: .normal)
        
        return button
    }()
    
    var warningImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "exclamationmark.circle.fill")
        imageView.tintColor = SharedDSKitAsset.Colors.red.color
        imageView.isHidden = true
        
        return imageView
    }()
    
    let certificationView: UIView = {
        let view = UIView()
        view.isHidden = true
        
        return view
    }()
    
    var notAccordLabel: UILabel = {
        let label = UILabel()
        label.text = "올바른 전화번호를 입력해 주세요."
        label.textColor = SharedDSKitAsset.Colors.red.color
        label.font = Fonts.Caption.font
        label.isHidden = true
        
        return label
    }()
    
    var certificationLabel: UILabel = {
        let label = UILabel()
        label.text = "인증번호"
        label.font = Fonts.Caption.font
        label.textColor = SharedDSKitAsset.Colors.gr80.color
        
        return label
    }()
    
    var certificationTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "인증번호 6자리를 입력해 주세요.", attributes: [NSAttributedString.Key.foregroundColor : SharedDSKitAsset.Colors.gr30.color, NSAttributedString.Key.font : Fonts.Body02.font])
        textField.textColor = SharedDSKitAsset.Colors.gr100.color
        textField.font = Fonts.Body02.font
        
        return textField
    }()
    
    var timerLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Caption.font
        label.textColor = SharedDSKitAsset.Colors.green.color
        label.textAlignment = .right
        
        return label
    }()
    
    var completeLabel: UILabel = {
        let label = UILabel()
        label.text = "인증이 완료 되었습니다."
        label.font = Fonts.Caption.font
        label.textColor = SharedDSKitAsset.Colors.green.color
        label.isHidden = true
        
        return label
    }()
    
    var checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = SharedDSKitAsset.Colors.green.color
        imageView.isHidden = true
        
        return imageView
    }()
    
    var passwordViewOne: UIView = UIView()
    var passwordLabelOne: UILabel = {
        let label = UILabel()
        label.text = " 비밀번호"
        label.font = Fonts.Caption.font
        label.textColor = SharedDSKitAsset.Colors.gr80.color
        
        return label
    }()
    
    var passwordTextFieldOne: UITextField = {
        let textField = UITextField()
        textField.font = Fonts.Body02.font
        textField.textColor = SharedDSKitAsset.Colors.gr100.color
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    let passwordViewTwo: UIView = UIView()
    var passwordLabelTwo: UILabel = {
        let label = UILabel()
        label.text = " 비밀번호"
        label.font = Fonts.Caption.font
        label.textColor = SharedDSKitAsset.Colors.gr80.color
        
        return label
    }()
    
    var passwordTextFieldTwo: UITextField = {
        let textField = UITextField()
        textField.textColor = SharedDSKitAsset.Colors.gr100.color
        textField.font = Fonts.Body02.font
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    let emailView: UIView = UIView()
    var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.textColor = SharedDSKitAsset.Colors.gr80.color
        label.font = Fonts.Caption.font
        
        return label
    }()
    
    var emailTextField: UITextField = {
        let textField = UITextField()
        textField.text = "abc123@gma"
        textField.textColor = SharedDSKitAsset.Colors.gr100.color
        
        return textField
    }()
    
    var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("가입하기", for: .normal)
        button.backgroundColor = SharedDSKitAsset.Colors.gr10.color
        button.titleLabel?.font = Fonts.SH02Bold.font
        button.setTitleColor(SharedDSKitAsset.Colors.gr30.color, for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        self.backgroundColor = .white
        let safeArea = self.safeAreaLayoutGuide
        
        addSubViews([progressBar, guideOneLabel, guideTwoLabel, signUpButton, phoneNumberView, passwordViewOne, passwordViewTwo, emailView, certificationView, notAccordLabel])
        setInsideViews()
        setBorderLines()
        
        progressBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(safeArea.snp.top)
            $0.height.equalTo(2)
        }
        
        guideOneLabel.snp.makeConstraints {
            $0.width.equalTo(335)
            $0.height.equalTo(28)
            $0.top.equalTo(safeArea.snp.top).offset(60)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        guideTwoLabel.snp.makeConstraints {
            $0.width.equalTo(335)
            $0.height.equalTo(24)
            $0.top.equalTo(safeArea.snp.top).offset(96)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        phoneNumberView.snp.makeConstraints {
            $0.width.equalTo(335)
            $0.height.equalTo(56)
            $0.top.equalTo(safeArea.snp.top).offset(160)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        phoneNumberLabel.snp.makeConstraints {
            $0.width.equalTo(229)
            $0.height.equalTo(17)
            $0.leading.equalTo(phoneNumberView.snp.leading).inset(16)
            $0.trailing.equalTo(phoneNumberView.snp.trailing).inset(90)
            $0.top.equalTo(phoneNumberView.snp.top).offset(8)
        }
        
        phoneNumberTextField.snp.makeConstraints {
            $0.width.equalTo(229)
            $0.height.equalTo(23)
            $0.leading.equalTo(phoneNumberView.snp.leading).inset(16)
            $0.trailing.equalTo(phoneNumberView.snp.trailing).inset(90)
            $0.top.equalTo(phoneNumberLabel.snp.bottom).offset(0.5)
        }
        
        warningImageView.snp.makeConstraints {
            $0.width.height.equalTo(18)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(phoneNumberView.snp.trailing).inset(85)
        }
        
        certificationButton.snp.makeConstraints {
            $0.width.equalTo(58)
            $0.height.equalTo(32)
            $0.trailing.equalTo(phoneNumberView.snp.trailing).inset(16)
            $0.centerY.equalToSuperview()
        }
        
        passwordViewOne.snp.makeConstraints {
            $0.width.equalTo(335)
            $0.height.equalTo(56)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(phoneNumberView.snp.bottom).offset(24)
        }
        
        passwordLabelOne.snp.makeConstraints {
            $0.width.equalTo(303)
            $0.height.equalTo(17)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(passwordViewOne.snp.top).offset(8)
        }
        
        passwordTextFieldOne.snp.makeConstraints {
            $0.width.equalTo(303)
            $0.height.equalTo(23)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(passwordLabelOne.snp.top).offset(17)
        }
        
        passwordViewTwo.snp.makeConstraints {
            $0.width.equalTo(335)
            $0.height.equalTo(56)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(passwordViewOne.snp.bottom).offset(24)
        }
        
        passwordLabelTwo.snp.makeConstraints {
            $0.width.equalTo(303)
            $0.height.equalTo(17)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(passwordViewTwo.snp.top).offset(8)
        }
        
        passwordTextFieldTwo.snp.makeConstraints {
            $0.width.equalTo(303)
            $0.height.equalTo(23)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(passwordLabelTwo.snp.top).offset(17)
        }
        
        emailView.snp.makeConstraints {
            $0.width.equalTo(335)
            $0.height.equalTo(56)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(passwordViewTwo.snp.bottom).offset(24)
        }
        
        emailLabel.snp.makeConstraints {
            $0.width.equalTo(303)
            $0.height.equalTo(17)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(emailView.snp.top).offset(8)
        }
        
        emailTextField.snp.makeConstraints {
            $0.width.equalTo(303)
            $0.height.equalTo(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(emailLabel.snp.top).offset(17)
        }
        
        certificationView.snp.makeConstraints {
            $0.width.equalTo(335)
            $0.height.equalTo(56)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(safeArea.snp.top).offset(242)
        }
        
        certificationLabel.snp.makeConstraints {
            $0.width.equalTo(263)
            $0.height.equalTo(17)
            $0.leading.equalTo(certificationView.snp.leading).inset(16)
            $0.trailing.equalTo(certificationView.snp.trailing).inset(56)
            $0.top.equalTo(certificationView.snp.top).offset(8)
        }
        
        certificationTextField.snp.makeConstraints {
            $0.width.equalTo(263)
            $0.height.equalTo(24)
            $0.leading.equalTo(certificationView.snp.leading).inset(16)
            $0.trailing.equalTo(certificationView.snp.trailing).inset(56)
            $0.top.equalTo(certificationLabel.snp.top).offset(17)
        }
        
        timerLabel.snp.makeConstraints {
            $0.width.equalTo(57)
            $0.height.equalTo(24)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(certificationView.snp.trailing).inset(16)
        }
        
        checkImageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(certificationView.snp.trailing).inset(16)
        }
        
        signUpButton.snp.makeConstraints {
            $0.width.equalTo(335)
            $0.height.equalTo(52)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeArea.snp.bottom).offset(8)
        }
        
        notAccordLabel.snp.makeConstraints {
            $0.width.equalTo(158)
            $0.height.equalTo(17)
            $0.leading.equalTo(safeArea.snp.leading).inset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).inset(197)
            $0.top.equalTo(phoneNumberView.snp.bottom).offset(8)
        }
        
        completeLabel.snp.makeConstraints {
            $0.width.equalTo(113)
            $0.height.equalTo(17)
            $0.leading.equalTo(safeArea.snp.leading).inset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).inset(242)
            $0.top.equalTo(certificationView.snp.bottom).offset(8)
        }
    }
    
    func setInsideViews() {
        [phoneNumberLabel, phoneNumberTextField, certificationButton, warningImageView].forEach {
            phoneNumberView.addSubview($0)
        }
        
        [passwordLabelOne, passwordTextFieldOne].forEach {
            passwordViewOne.addSubview($0)
        }
        
        [passwordLabelTwo, passwordTextFieldTwo].forEach {
            passwordViewTwo.addSubview($0)
        }
        
        [emailLabel, emailTextField].forEach {
            emailView.addSubview($0)
        }
        
        [certificationLabel, certificationTextField, timerLabel, checkImageView, completeLabel].forEach {
            certificationView.addSubview($0)
        }
    }
    
    func setBorderLines() {
        [phoneNumberView, passwordViewOne, passwordViewTwo, emailView, signUpButton, certificationView].forEach {
            $0.layer.borderColor = SharedDSKitAsset.Colors.gr10.color.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 16
        }
        
        certificationButton.layer.borderColor = SharedDSKitAsset.Colors.gr10.color.cgColor
        certificationButton.layer.borderWidth = 1
        certificationButton.layer.cornerRadius = 12
    }
}
