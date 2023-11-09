import UIKit
import FeatureSignIn
import ReactorKit
import SnapKit
import SwiftUI
import Shared

public class HomeViewController: UIViewController {
    let emailView = UIView()
    let textView = UIView()
    let insertEmailLabelOne = UILabel()
    let insertEmailLabelTwo = UILabel()
    let textFieldView = UIView()
    let emailLabel = UILabel()
    let emailTextField = UITextField()
    let signUpButton = UIButton()
    let progressBar = UIProgressView()
    let useLabel = UILabel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        addView()
        setBackgroundColors()
        setNavigationbar()
        setLayout()
        setTextContents()
        setBorderLine()
        setTextSize()
        setTextColors()
        setProgressBar()
    }
    
    func addView() {
        view.addSubview(emailView)
        view.addSubview(progressBar)
        view.addSubview(signUpButton)
        emailView.addSubview(textView)
        emailView.addSubview(textFieldView)
        emailView.addSubview(useLabel)
        textView.addSubview(insertEmailLabelOne)
        textView.addSubview(insertEmailLabelTwo)
        textFieldView.addSubview(emailLabel)
        textFieldView.addSubview(emailTextField)
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
        
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: nil)
        rightButton.tintColor = .black
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func setLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        emailView.snp.makeConstraints {
            $0.bottom.equalTo(-354)
            $0.top.equalTo(progressBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(emailView.snp_topMargin).offset(60)
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.bottom.equalTo(-261)
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
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.bottom.equalTo(emailView.snp_bottomMargin).offset(-165)
            $0.top.equalTo(emailView.snp_topMargin).offset(160)
        }
        
        emailLabel.snp.makeConstraints {
            $0.leading.equalTo(textFieldView.snp_leadingMargin).offset(16)
            $0.trailing.equalTo(textFieldView.snp_trailingMargin).offset(-88)
            $0.top.equalTo(textFieldView.snp_topMargin).offset(8)
            $0.bottom.equalTo(textFieldView.snp_bottomMargin).offset(-31)
        }
        
        emailTextField.snp.makeConstraints {
            $0.leading.equalTo(textFieldView.snp_leadingMargin).offset(16)
            $0.trailing.equalTo(textFieldView.snp_trailingMargin).offset(-88)
            $0.top.equalTo(textFieldView.snp_topMargin).offset(24.5)
            $0.bottom.equalTo(textFieldView.snp_bottomMargin).offset(-7.5)
        }
        
        useLabel.snp.makeConstraints {
            $0.leading.equalTo(emailView.snp_leadingMargin).offset(20)
            $0.trailing.equalTo(emailView.snp_trailingMargin).offset(-218)
            $0.top.equalTo(emailView.snp_topMargin).offset(224)
            $0.bottom.equalTo(emailView.snp_bottomMargin).offset(-140)
        }
        
        signUpButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeArea.snp.bottom).inset(8)
            $0.height.equalTo(52)
        }
        
        progressBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(safeArea.snp.top)
            $0.bottom.equalTo(emailView.snp_topMargin)
            $0.height.equalTo(2)
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
}
