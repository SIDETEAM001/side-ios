import UIKit
import Shared

public class EmailViewController: UIViewController {
    var emailView = EmailView()
    
    public override func loadView() {
        super.loadView()
        
        view = emailView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        emailView.signUpButton.rx.tap.subscribe(onNext: {
            print("hello")
        })
        setNavigationbar()
        setAddTarget()
        passwordViewSetAddTarget()
    }
    
    func setNavigationbar() {
        title = "회원가입"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font : Fonts.SH03Bold.font,
            .foregroundColor: SharedDSKitAsset.Colors.gr100.color
        ]
        
        let rightButton = UIBarButtonItem(image: SharedDSKitAsset.Icons.iconSetting24.image, style: .plain, target: self, action: nil)
        rightButton.tintColor = SharedDSKitAsset.Colors.black.color
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func setAddTarget() {
        emailView.emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        emailView.cancelButton.addTarget(self, action: #selector(textFieldContentDelete(_:)), for: .touchUpInside)
    }
    
    
    func checkEmail(str: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{3}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: str)
    }
    
    @objc func textFieldDidChange(_ sender: Any?) {
        if emailView.emailTextField.text == "" {
            emailView.textFieldView.layer.borderColor = SharedDSKitAsset.Colors.gr10.color.cgColor
            emailView.cancelButton.isHidden = true
            
            emailView.cancelButton.snp.updateConstraints {
                $0.trailing.equalTo(emailView.textFieldView.snp.trailing).inset(16)
            }
        } else {
            emailView.textFieldView.layer.borderColor = SharedDSKitAsset.Colors.gr100.color.cgColor
            emailView.cancelButton.isHidden = false
            guard let text = emailView.emailTextField.text else { return }
            
            if checkEmail(str: text) {
                emailView.useLabel.isHidden = false
                emailView.checkImageView.isHidden = false
                emailView.textFieldView.layer.borderColor = SharedDSKitAsset.Colors.gr10.color.cgColor
                
                emailView.cancelButton.snp.updateConstraints {
                    $0.trailing.equalTo(emailView.textFieldView.snp.trailing).inset(48)
                }
                emailView.textFieldView.snp.remakeConstraints { make in
                    make.width.equalTo(335)
                    make.height.equalTo(56)
                    make.top.equalToSuperview().offset(410)
                    make.leading.trailing.equalToSuperview().inset(20)
                }
                emailView.insertEmailLabelTwo.snp.remakeConstraints { make in
                    make.width.equalTo(380)
                    make.height.equalTo(60)
                    make.leading.trailing.equalToSuperview()
                    make.top.equalTo(36)
                    
                }
                emailView.passwordView.pwTextViewTwo.snp.remakeConstraints { make in
                    make.top.equalTo(emailView.passwordView.pwTextViewOne.snp.bottom).offset(40)
                    make.leading.equalToSuperview().offset(20)
                    make.width.equalTo(355)
                }
                emailView.passwordView.pwTextViewOne.isHidden = false
                emailView.passwordView.pwTextViewTwo.isHidden = false
                emailView.passwordView.labelStackView.isHidden = false
                emailView.insertEmailLabelTwo.numberOfLines = 2
                emailView.insertEmailLabelOne.text = "비밀번호를 입력해주세요"
                emailView.insertEmailLabelTwo.text = "영문, 숫자, 특수문자를 포함한 6자리 이상으로 설정해주세요."
                emailView.progressBar.progress = 0.66
                
                
            } else {
                emailView.useLabel.isHidden = true
                emailView.checkImageView.isHidden = true
                
                emailView.cancelButton.snp.updateConstraints {
                    $0.trailing.equalTo(emailView.textFieldView.snp.trailing).inset(16)
                }
            }
        }
    }
    
    @objc func textFieldContentDelete(_ sender: Any?) {
        emailView.emailTextField.text = ""
        emailView.cancelButton.isHidden = true
        emailView.checkImageView.isHidden = true
        emailView.useLabel.isHidden = true
    }
    
    
    func passwordViewSetAddTarget() {
        emailView.passwordView.cancelButtonOne.addTarget(self, action: #selector(textFieldContentDeleteOne(_:)), for: .touchUpInside)
        emailView.passwordView.cancelButtonTwo.addTarget(self, action: #selector(textFieldContentDeleteTwo(_:)), for: .touchUpInside)
        emailView.passwordView.pwTextFieldOne.addTarget(self, action: #selector(textFieldDidChangeOne(_:)), for: .editingChanged)
        emailView.passwordView.pwTextFieldTwo.addTarget(self, action: #selector(textFieldDidChangeTwo(_:)), for: .editingChanged)
    }
    
    
    @objc func textFieldDidChangeOne(_ sender: Any?) {
        if emailView.passwordView.pwTextFieldOne.text == "" {
            emailView.passwordView.cancelButtonOne.isHidden = true
            emailView.passwordView.pwTextViewOne.layer.borderColor = SharedDSKitAsset.Colors.gr10.color.cgColor
            [emailView.passwordView.englishLabel, emailView.passwordView.numberLabel, emailView.passwordView.symbolLabel].forEach {
                $0.layer.borderColor = SharedDSKitAsset.Colors.gr10.color.cgColor
                $0.layer.backgroundColor = SharedDSKitAsset.Colors.gr10.color.cgColor
                $0.textColor = SharedDSKitAsset.Colors.text03.color
            }
        } else {
            emailView.passwordView.cancelButtonOne.isHidden = false
            emailView.passwordView.pwTextViewOne.layer.borderColor = SharedDSKitAsset.Colors.gr100.color.cgColor
            guard let textOne = emailView.passwordView.pwTextFieldOne.text else { return }
            checkPassword(text: textOne)
            
            if emailView.passwordView.labelStackView.isHidden == false {
                emailView.passwordView.progressBar.progress = 0.3
            }
        }
    }
    @objc func textFieldContentDeleteOne(_ sender: Any?) {
        emailView.passwordView.pwTextFieldOne.text = ""
        emailView.passwordView.labelStackView.isHidden = false
        emailView.passwordView.pwTextViewOne.layer.borderColor = SharedDSKitAsset.Colors.gr100.color.cgColor
        
        [emailView.passwordView.englishLabel, emailView.passwordView.numberLabel, emailView.passwordView.symbolLabel, emailView.passwordView.sixLabel].forEach {
            $0.layer.borderColor = SharedDSKitAsset.Colors.gr10.color.cgColor
            $0.layer.backgroundColor = SharedDSKitAsset.Colors.gr10.color.cgColor
            $0.textColor = SharedDSKitAsset.Colors.text03.color
        }
        
        [emailView.passwordView.cancelButtonOne, emailView.passwordView.possibleUseLabel, emailView.passwordView.checkImageView].forEach {
            $0.isHidden = true
        }
    }
    @objc func textFieldDidChangeTwo(_ sender: Any?) {
        if emailView.passwordView.possibleUseLabel.isHidden == false {
            [emailView.passwordView.checkImageView, emailView.passwordView.cancelButtonOne, emailView.passwordView.possibleUseLabel].forEach {
                $0.isHidden = true
            }
            emailView.passwordView.progressBar.progress = 0.66
        }

        if emailView.passwordView.pwTextFieldTwo.text == "" {
            [emailView.passwordView.cancelButtonTwo, emailView.passwordView.notAccordLabel, emailView.passwordView.warningImageView].forEach {
                $0.isHidden = true
            }
            emailView.passwordView.pwTextViewTwo.layer.borderColor = SharedDSKitAsset.Colors.gr10.color.cgColor
        } else {
            emailView.passwordView.cancelButtonTwo.isHidden = false
            guard let textOne = emailView.passwordView.pwTextFieldOne.text else { return }
            guard let textTwo = emailView.passwordView.pwTextFieldTwo.text else { return }

            if !textOne.isEmpty {
                if textOne == textTwo {
                    [emailView.passwordView.pwTextViewOne, emailView.passwordView.pwTextViewTwo].forEach {
                        $0.layer.borderColor = SharedDSKitAsset.Colors.gr10.color.cgColor
                    }

                    [emailView.passwordView.possibleUseLabel, emailView.passwordView.cancelButtonOne, emailView.passwordView.checkImageView, emailView.passwordView.notAccordLabel, emailView.passwordView.cancelButtonTwo, emailView.passwordView.warningImageView].forEach {
                        $0.isHidden = true
                    }
                } else {
                    emailView.passwordView.pwTextViewTwo.layer.borderColor = SharedDSKitAsset.Colors.red.color.cgColor
                    emailView.passwordView.warningImageView.isHidden = false
                    emailView.passwordView.notAccordLabel.isHidden = false
                }
            }
        }
    }
    @objc func textFieldContentDeleteTwo(_ sender: Any?) {
        emailView.passwordView.pwTextFieldTwo.text = ""
        emailView.passwordView.pwTextViewTwo.layer.borderColor = SharedDSKitAsset.Colors.gr10.color.cgColor
        
        [emailView.passwordView.cancelButtonTwo, emailView.passwordView.warningImageView, emailView.passwordView.notAccordLabel].forEach {
            $0.isHidden = true
        }
    }
    func checkPassword(text: String) {
        let isContainsNumber: Bool = {
            return "\(text)".range(of: "\\p{Number}", options: .regularExpression) != nil
        }()
        
        let isContainsEnglish: Bool = {
            return "\(text)".range(of: "\\p{Latin}", options: .regularExpression) != nil
        }()
        
        let isContainsSymbol: Bool = {
            return "\(text)".range(of: "(?=.*[!@#$%^&*])", options: .regularExpression) != nil
        }()
        
        let isCountMoreSix: Bool = {
            if text.count >= 6 {
                return true
            }
            return false
        }()
        
        if isContainsNumber {
            emailView.passwordView.numberLabel.layer.borderColor = SharedDSKitAsset.Colors.green.color.cgColor
            emailView.passwordView.numberLabel.textColor = SharedDSKitAsset.Colors.green.color
        } else {
            emailView.passwordView.numberLabel.layer.borderColor = SharedDSKitAsset.Colors.gr10.color.cgColor
            emailView.passwordView.numberLabel.layer.backgroundColor = SharedDSKitAsset.Colors.gr10.color.cgColor
            emailView.passwordView.numberLabel.textColor = SharedDSKitAsset.Colors.text03.color
        }
        
        if isContainsEnglish {
            emailView.passwordView.englishLabel.layer.borderColor = SharedDSKitAsset.Colors.green.color.cgColor
            emailView.passwordView.englishLabel.textColor = SharedDSKitAsset.Colors.green.color
        } else {
            emailView.passwordView.englishLabel.layer.borderColor = SharedDSKitAsset.Colors.gr10.color.cgColor
            emailView.passwordView.englishLabel.layer.backgroundColor = SharedDSKitAsset.Colors.gr10.color.cgColor
            emailView.passwordView.englishLabel.textColor = SharedDSKitAsset.Colors.text03.color
        }
        
        if isContainsSymbol {
            emailView.passwordView.symbolLabel.layer.borderColor = SharedDSKitAsset.Colors.green.color.cgColor
            emailView.passwordView.symbolLabel.textColor = SharedDSKitAsset.Colors.green.color
        } else {
            emailView.passwordView.symbolLabel.layer.borderColor = SharedDSKitAsset.Colors.gr10.color.cgColor
            emailView.passwordView.symbolLabel.layer.backgroundColor = SharedDSKitAsset.Colors.gr10.color.cgColor
            emailView.passwordView.symbolLabel.textColor = SharedDSKitAsset.Colors.text03.color
        }
        
        if isCountMoreSix {
            emailView.passwordView.sixLabel.layer.borderColor = SharedDSKitAsset.Colors.green.color.cgColor
            emailView.passwordView.sixLabel.textColor = SharedDSKitAsset.Colors.green.color
        } else {
            emailView.passwordView.sixLabel.layer.borderColor = SharedDSKitAsset.Colors.gr10.color.cgColor
            emailView.passwordView.sixLabel.layer.backgroundColor = SharedDSKitAsset.Colors.gr10.color.cgColor
            emailView.passwordView.sixLabel.textColor = SharedDSKitAsset.Colors.text03.color
        }
        
        if isContainsEnglish && isContainsNumber && isContainsSymbol && isCountMoreSix {
            emailView.passwordView.labelStackView.isHidden = true
            emailView.passwordView.possibleUseLabel.isHidden = false
            emailView.passwordView.checkImageView.isHidden = false
            
            emailView.passwordView.cancelButtonOne.snp.makeConstraints {
                $0.width.height.equalTo(24)
                $0.centerY.equalToSuperview()
                $0.trailing.equalTo(emailView.passwordView.pwTextViewOne.snp.trailing).inset(48)
            }
        } else {
            emailView.passwordView.labelStackView.isHidden = false
            emailView.passwordView.possibleUseLabel.isHidden = true
            emailView.passwordView.checkImageView.isHidden = true
            
            emailView.passwordView.cancelButtonOne.snp.makeConstraints {
                $0.width.height.equalTo(24)
                $0.centerY.equalToSuperview()
                $0.trailing.equalTo(emailView.passwordView.pwTextViewOne.snp.trailing).inset(19)
            }
        }
    }
}
