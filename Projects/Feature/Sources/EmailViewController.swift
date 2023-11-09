import UIKit
import FeatureSignIn
import ReactorKit
import SnapKit
import Shared

public class EmailViewController: UIViewController {
    let textView = UIView()
    let insertEmailLabelOne = UILabel()
    let insertEmailLabelTwo = UILabel()
    let textFieldView = UIView()
    let emailLabel = UILabel()
    let emailTextField = UITextField()
    let signUpButton = UIButton()
    let progressBar = UIProgressView()
    let useLabel = UILabel()
    let cancelButton = UIButton()
    let checkImageView = UIImageView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        addView()
        setBackgroundColors()
        setNavigationbar()
        setLayout()
        setTextContents()
        setBorderLine()
        setTextFieldViewContents()
        setTextSize()
        setTextColors()
        setProgressBar()
        setEmailTextField()
    }
    
    func addView() {
        [progressBar, signUpButton, textFieldView, textView, useLabel].forEach {
            view.addSubview($0)
        }
        
        [insertEmailLabelOne, insertEmailLabelTwo].forEach {
            textView.addSubview($0)
        }
        
        [emailLabel, emailTextField, cancelButton, checkImageView].forEach {
            textFieldView.addSubview($0)
        }
    }
    
    func setProgressBar() {
        progressBar.progressViewStyle = .bar
        progressBar.progressTintColor = CustomColor.gray100
        progressBar.progress = 0.5
    }
    
    func setBackgroundColors() {
        view.backgroundColor = .white
        signUpButton.backgroundColor = CustomColor.gray10
        useLabel.backgroundColor = .white
    }
    
    func setNavigationbar() {
        title = "회원가입"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18),
            .foregroundColor: CustomColor.gray100
        ]
        
        let rightButton = UIBarButtonItem(image: UIImage(named: ""), style: .plain, target: self, action: nil)
        rightButton.tintColor = .black
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func setLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        textView.snp.makeConstraints {
            $0.top.equalTo(progressBar.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        insertEmailLabelOne.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.bottom.equalTo(-32)
            $0.trailing.equalTo(-153)
        }
        
        insertEmailLabelTwo.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(36)
        }
        
        textFieldView.snp.makeConstraints {
            $0.top.equalTo(progressBar.snp.bottom).offset(160)
            $0.height.equalTo(56)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        emailLabel.snp.makeConstraints {
            $0.leading.equalTo(textFieldView.snp.leading).inset(16)
            $0.trailing.equalTo(textFieldView.snp.trailing).inset(88)
            $0.top.equalTo(textFieldView.snp.top).offset(8)
            $0.bottom.equalTo(textFieldView.snp.bottom).offset(-31)
        }
        
        emailTextField.snp.makeConstraints {
            $0.leading.equalTo(textFieldView.snp.leading).inset(16)
            $0.trailing.equalTo(textFieldView.snp.trailing).inset(88)
            $0.top.equalTo(textFieldView.snp.top).inset(25)
            $0.bottom.equalTo(textFieldView.snp.bottom).inset(8)
        }
        
        useLabel.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leading).inset(20)
            $0.trailing.equalTo(view.snp.trailing).inset(218)
            $0.top.equalTo(textFieldView.snp.bottom).offset(8)
        }
        
        signUpButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeArea.snp.bottom).inset(8)
            $0.height.equalTo(52)
        }
        
        progressBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(safeArea.snp.top)
            $0.height.equalTo(2)
        }
        
        cancelButton.snp.makeConstraints {
            $0.width.height.equalTo(18)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(emailTextField.snp.trailing).offset(16)
        }
        
        checkImageView.snp.makeConstraints {
            $0.width.equalTo(18)
            $0.height.equalTo(13.2)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(cancelButton.snp.trailing).offset(8)
        }
    }
    
    func setTextContents() {
        insertEmailLabelOne.text = "이메일을 입력해주세요"
        insertEmailLabelTwo.text = "로그인 시 사용하실 이메일을 입력해주세요."
        emailLabel.text = "이메일"
        emailTextField.placeholder = "이메일을 입력해주세요"
        useLabel.text = "사용할 수 있는 아이디입니다."
        signUpButton.setTitle("가입하기", for: .normal)
    }
    
    func setBorderLine() {
        textFieldView.layer.borderColor = CustomColor.gray10?.cgColor
        textFieldView.layer.borderWidth = 1
        textFieldView.layer.cornerRadius = 16
        signUpButton.layer.borderColor = CustomColor.gray10?.cgColor
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.cornerRadius = 16
    }
    
    func setTextFieldViewContents() {
        cancelButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        cancelButton.tintColor = CustomColor.gray20
        cancelButton.isHidden = true
        cancelButton.addTarget(self, action: #selector(textFieldContentDelete(_:)), for: .touchUpInside)
        checkImageView.image = UIImage(systemName: "checkmark")
        checkImageView.tintColor = CustomColor.green
        checkImageView.isHidden = true
        useLabel.isHidden = true
    }
    
    func setTextSize() {
        insertEmailLabelOne.font = .boldSystemFont(ofSize: 20)
        insertEmailLabelTwo.font = .systemFont(ofSize: 16)
        emailLabel.font = .boldSystemFont(ofSize: 12)
        useLabel.font = .systemFont(ofSize: 12)
        signUpButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
    }
    
    func setTextColors() {
        insertEmailLabelOne.textColor = CustomColor.gray100
        insertEmailLabelTwo.textColor = CustomColor.text03
        emailLabel.textColor = CustomColor.gray80
        signUpButton.setTitleColor(CustomColor.gray30, for: .normal)
        useLabel.textColor = CustomColor.green
    }
    
    func setEmailTextField() {
        emailTextField.clearButtonMode = .never
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ sender: Any?) {
        if emailTextField.text == "" {
            textFieldView.layer.borderColor = CustomColor.gray10?.cgColor
            cancelButton.isHidden = true
        } else {
            textFieldView.layer.borderColor = CustomColor.gray100?.cgColor
            cancelButton.isHidden = false
            guard let text = emailTextField.text else { return }
            
            if text.contains("@") && text.contains(".com")  {
                checkImageView.isHidden = false
                useLabel.isHidden = false
            } else {
                useLabel.isHidden = true
                checkImageView.isHidden = true
            }
        }
    }
    
    @objc func textFieldContentDelete(_ sender: Any?) {
        emailTextField.text = ""
        cancelButton.isHidden = true
    }
    
    @objc func movePasswordVCButtonClicked() {
        
    }
}
