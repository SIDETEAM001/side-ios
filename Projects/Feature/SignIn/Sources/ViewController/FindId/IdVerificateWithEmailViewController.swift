//
//  IdVerificateWithEmailViewController.swift
//  FeatureSignIn
//
//  Created by 강민성 on 1/29/24.
//

import UIKit
import Shared
import Domain

import RxSwift
import RxCocoa
import RxFlow
import ReactorKit

public class IdVerificateWithEmailViewController: BaseViewController, ReactorKit.View {
    
    public typealias Reactor = IdVerificateWithEmailReactor
    
    let idVerificateWithEmailView = IdVerificateWithEmailView()
    
    let timerView: UILabel = {
        let label = UILabel()
        label.textColor = SharedDSKitAsset.Colors.green.color
        label.font = Fonts.Caption.font
        label.textAlignment = .right
        
        return label
    }()
    
    let okImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = SharedDSKitAsset.Colors.green.color
        
        return imageView
    }()
    
    public override func loadView() {
        super.loadView()
        view = idVerificateWithEmailView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUp()
        render()
    }
    
    public init(with reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    public override func configureUI() {
        super.configureUI()
        addBackButton()
        addNavigationTitleLabel("아이디 찾기")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        idVerificateWithEmailView.emailVerificateInputView.inputViewErrorLabel.isHidden = true
        idVerificateWithEmailView.verificationNumberInputView.isHidden = true
    }
    
    private func render() {
        idVerificateWithEmailView.verificationNumberInputView.inputViewTextField.leftView = okImageView
        idVerificateWithEmailView.verificationNumberInputView.inputViewTextField.leftView?.isHidden = true
        idVerificateWithEmailView.verificationNumberInputView.inputViewTextField.rightView = timerView
        
        idVerificateWithEmailView.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationBarArea.snp.bottom).offset(60)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(68)
        }
        
        idVerificateWithEmailView.emailVerificateInputView.snp.makeConstraints { make in
            make.top.equalTo(idVerificateWithEmailView.titleLabel.snp.bottom).offset(40)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
        
        idVerificateWithEmailView.verificationNumberInputView.snp.makeConstraints { make in
            make.top.equalTo(idVerificateWithEmailView.emailVerificateInputView.snp.bottom).offset(24)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
        
        idVerificateWithEmailView.verificationCompletedButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-8)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(52)
        }
    }
}

extension IdVerificateWithEmailViewController {
    public func bind(reactor: IdVerificateWithEmailReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    private func bindAction(reactor: IdVerificateWithEmailReactor) {
        backButton.rx.tap
            .map { Reactor.Action.didBackButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        idVerificateWithEmailView.emailVerificateInputView.verificationInputViewTextField.rx.text
            .orEmpty
            .map { Reactor.Action.writeEmail($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        idVerificateWithEmailView.emailVerificateInputView.verificateButton.rx
            .tap
            .map { Reactor.Action.didTapRequestVerificationNumberButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        idVerificateWithEmailView.verificationNumberInputView.inputViewTextField.rx.text
            .orEmpty
            .map { Reactor.Action.writeVerificationNumber($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(reactor: IdVerificateWithEmailReactor) {
        reactor.state.map { $0.isStartTimer }
            .withUnretained(self)
            .subscribe(onNext: { viewController, start in
                if start {
                    viewController.idVerificateWithEmailView.verificationNumberInputView.isHidden = false
                }
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isVerificationComplete }
            .bind(to: idVerificateWithEmailView.verificationCompletedButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.timerTime == 0 }
            .bind(to: idVerificateWithEmailView.emailVerificateInputView.verificateButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.timerString }
            .bind(to: timerView.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isIncorrectFormedEmail }
            .withUnretained(self)
            .subscribe(onNext: { viewController, error in
                if !error {
                    viewController.idVerificateWithEmailView.emailVerificateInputView.verificationInputViewTextField.layer.borderColor = SharedDSKitAsset.Colors.gr10.color.cgColor
                    viewController.idVerificateWithEmailView.emailVerificateInputView.verificateButton.layer.borderColor = SharedDSKitAsset.Colors.gr50.color.cgColor
                    viewController.idVerificateWithEmailView.emailVerificateInputView.verificationInputViewTextField.leftView?.isHidden = true
                } else {
                    viewController.idVerificateWithEmailView.emailVerificateInputView.verificationInputViewTextField.layer.borderColor = SharedDSKitAsset.Colors.red.color.cgColor
                    viewController.idVerificateWithEmailView.emailVerificateInputView.inputViewErrorLabel.text = "올바른 이메일 주소를 입력해 주세요."
                    viewController.idVerificateWithEmailView.emailVerificateInputView.verificationInputViewTextField.leftView?.isHidden = false
                    viewController.idVerificateWithEmailView.emailVerificateInputView.verificateButton.backgroundColor = SharedDSKitAsset.Colors.bgGray.color
                    viewController.idVerificateWithEmailView.emailVerificateInputView.verificateButton.layer.borderColor = SharedDSKitAsset.Colors.gr10.color.cgColor
                }
                viewController.idVerificateWithEmailView.emailVerificateInputView.verificateButton.isEnabled = !error
                viewController.idVerificateWithEmailView.emailVerificateInputView.inputViewErrorLabel.isHidden = !error
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isVerificationComplete }
            .withUnretained(self)
            .subscribe(onNext: { viewController, complete in
                if complete {
                    viewController.idVerificateWithEmailView.verificationNumberInputView.inputViewTextField.rightView?.isHidden = true
                    viewController.idVerificateWithEmailView.verificationNumberInputView.inputViewTextField.leftView?.isHidden = false
                    viewController.idVerificateWithEmailView.verificationNumberInputView.inputViewErrorLabel.text = "인증이 완료 되었습니다."
                    viewController.idVerificateWithEmailView.verificationNumberInputView.inputViewErrorLabel.textColor = SharedDSKitAsset.Colors.green.color
                    viewController.idVerificateWithEmailView.verificationCompletedButton.backgroundColor = SharedDSKitAsset.Colors.green.color
                }
                else {
                    viewController.idVerificateWithEmailView.verificationCompletedButton.backgroundColor = SharedDSKitAsset.Colors.bgGray.color
                }
            })
            .disposed(by: disposeBag)
    }
}
