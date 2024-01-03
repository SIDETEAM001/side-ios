import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Shared

public class CreateMeetingContentViewController: UIViewController {
    let disposeBag = DisposeBag()
    let meetingTitle: String
    let createMeetingContentViewModel: CreateMeetingContentViewModel
<<<<<<< HEAD
<<<<<<< HEAD
=======
    
>>>>>>> 5e24642 ([FEAT] 모임 생성 마지막 페이지 개발)
=======
    let createMeetingPeriodViewModel: CreateMeetingPeriodViewModel
    var dateBtViewCalendarVisible = false
    var timeBtViewPickViewVisible = false
>>>>>>> 10657f1 ([FEAT] 모임 생성 타입 결정 화면 present 애니메이션 개발)
    let backButton = UIBarButtonItem(image: SharedDSKitAsset.Icons.iconArrowLeft24.image, style: .plain, target: nil, action: nil)
    let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.backgroundColor = SharedDSKitAsset.Colors.bgGray.color
        progressView.tintColor = .black
        progressView.progress = 1
        return progressView
    }()
    let scrollView = UIScrollView()
    let contentView = UIView()
    let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "모임을 설명해 주세요 :)"
        label.font = Fonts.H02.font
        return label
    }()
    let createMeetingTitleView = CreateMeetingTitleView()
    let createMeetingRegionView = CreateMeetingRegionView()
    let createMeetingMemberView = CreateMeetingMemberView()
    lazy var createMeetingPeriodView = CreateMeetingPeriodView(createMeetingPeriodViewModel: self.createMeetingPeriodViewModel)
    let createMeetingImageView = CreateMeetingImageView()
    let createMeetingWritingView = CreateMeetingWritingView()
    let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("모임 개설하기", for: .normal)
        button.titleLabel?.font = Fonts.SH02Bold.font
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        return button
    }()
    
    public init(meetingTitle: String, createMeetingContentViewModel: CreateMeetingContentViewModel, createMeetingPeriodViewModel: CreateMeetingPeriodViewModel) {
        self.meetingTitle = meetingTitle
        self.createMeetingContentViewModel = createMeetingContentViewModel
        self.createMeetingPeriodViewModel = createMeetingPeriodViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.setNavigationbar()
        self.createButton.disableNextButton()
        self.bind()
        self.layout()
    }
    
<<<<<<< HEAD
<<<<<<< HEAD
//    public override func viewWillLayoutSubviews() {
//        createMeetingPeriodView.selectedPickerViewUICustom()
//    }
=======
    public override func viewWillLayoutSubviews() {
        createMeetingPeriodView.timePickerView.timePicker.subviews[1].backgroundColor = .clear
    }
>>>>>>> a38b360 ([FEAT] 모임 생성 타입 present  애니메이션 개발)
    
=======
>>>>>>> 5e24642 ([FEAT] 모임 생성 마지막 페이지 개발)
    private func setNavigationbar() {
        self.title = self.meetingTitle
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font : Fonts.SH03Bold.font,
            .foregroundColor: UIColor.black
        ]
        self.backButton.tintColor = SharedDSKitAsset.Colors.black.color
        navigationItem.leftBarButtonItem = backButton
    }
    
    func bind(){
        backButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        createMeetingTitleView.titleTextField.rx.text.orEmpty
            .bind(to: createMeetingContentViewModel.titleTextRelay)
            .disposed(by: disposeBag)
        
        createMeetingRegionView.onlineSwitch.rx.isOn
            .bind(to: createMeetingContentViewModel.onlineSwitchRelay)
            .disposed(by: disposeBag)
        
        createMeetingContentViewModel.onlineSwitchRelay
            .bind(onNext: { [weak self] value in
                if(value){
                    self?.createMeetingRegionView.regionTextField.isEnabled = false
                    self?.createMeetingRegionView.regionTextField.backgroundColor = SharedDSKitAsset.Colors.bgGray.color
                }
                else{
                    self?.createMeetingRegionView.regionTextField.isEnabled = true
                    self?.createMeetingRegionView.regionTextField.backgroundColor = .white
                }
            })
            .disposed(by: disposeBag)
        
        createMeetingMemberView.memberLimitTextField.rx.text.orEmpty
            .map { text in
                return String(text.filter { "0123456789".contains($0) })
            }
            .bind(to: createMeetingContentViewModel.memberTextRelay)
            .disposed(by: disposeBag)
        
        createMeetingContentViewModel.memberTextRelay
            .bind(to: createMeetingMemberView.memberLimitTextField.rx.text)
            .disposed(by: disposeBag)
        
<<<<<<< HEAD
        createMeetingPeriodView.dateBtView.tapGesture.rx.event
            .bind(onNext: { [weak self] _ in
                self?.presentDatePicker(mode: .date) { date in
                    let dateStandardString = self?.createMeetingContentViewModel.getDateStandardString(date: date)
                    self?.createMeetingContentViewModel.selectedDateRelay.accept(dateStandardString!)
                    self?.createMeetingPeriodView.dateBtView.configure(subTitle: dateStandardString!)
                }
            })
            .disposed(by: disposeBag)
        
        createMeetingPeriodView.timeBtView.tapGesture.rx.event
            .bind(onNext: { [weak self] _ in
                self?.presentDatePicker(mode: .time) { date in
                    let timeStandardString = self?.createMeetingContentViewModel.getTimeStandardString(time: date)
                    self?.createMeetingContentViewModel.selectedTimeRelay.accept(timeStandardString!)
                    let timeSubTitleString = self?.createMeetingContentViewModel.getTimeSubTitleString(time: date)
                    self?.createMeetingPeriodView.timeBtView.configure(subTitle: timeSubTitleString!)
<<<<<<< HEAD
=======

>>>>>>> 5e24642 ([FEAT] 모임 생성 마지막 페이지 개발)
                }
            })
            .disposed(by: disposeBag)
=======
>>>>>>> 10657f1 ([FEAT] 모임 생성 타입 결정 화면 present 애니메이션 개발)
        
        createMeetingWritingView.introductionTextView.rx.text.orEmpty
            .bind(to: createMeetingContentViewModel.introductionTextRelay)
            .disposed(by: disposeBag)
<<<<<<< HEAD
        
        createMeetingImageView.setDefaultImageButton.rx.tap
            .bind(to: createMeetingContentViewModel.setDefaultImageButtonTapped)
            .disposed(by: disposeBag)
        
        createMeetingContentViewModel.representativeImagesDriver
            .drive(onNext: { [weak self] img in
                self?.createMeetingImageView.representativeImageView.image = img
                self?.createMeetingImageView.representativeImageView.isHidden = false
                self?.createMeetingImageView.imageCancelButton.isHidden = false
                self?.createMeetingImageView.addImageBtView.cntLabel.text = "1 / 1"
            })
            .disposed(by: disposeBag)
        
        createMeetingImageView.imageCancelButton.rx.tap
            .bind(to: createMeetingContentViewModel.imageCancelButtonTapped)
            .disposed(by: disposeBag)
        
        createMeetingContentViewModel.imageCancelButtonTapped
            .bind(onNext: { [weak self] in
                self?.createMeetingImageView.representativeImageView.isHidden = true
                self?.createMeetingImageView.imageCancelButton.isHidden = true
                self?.createMeetingImageView.addImageBtView.cntLabel.text = "0 / 1"
            })
            .disposed(by: disposeBag)
        
<<<<<<< HEAD
=======
            
>>>>>>> 5e24642 ([FEAT] 모임 생성 마지막 페이지 개발)
=======
       
        createMeetingPeriodView.dateBtView.tapGesture.rx.event
               .bind(onNext: { [weak self] _ in
                   guard let self = self else { return }

                   if self.createMeetingPeriodView.isCalendarViewVisible {
                       self.createMeetingPeriodView.calendarViewDisappear()
                   } else {
                       self.createMeetingPeriodView.calendarViewAppear()
                       if self.createMeetingPeriodView.isTimePickerViewVisible {
                           self.createMeetingPeriodView.timePickerViewDisappear()
                           self.createMeetingPeriodView.isTimePickerViewVisible = false
                       }
                   }

                   self.createMeetingPeriodView.isCalendarViewVisible.toggle()
                   self.updateCreateMeetingPeriodViewHeight()
               })
               .disposed(by: disposeBag)

           createMeetingPeriodView.timeBtView.tapGesture.rx.event
               .bind(onNext: { [weak self] _ in
                   guard let self = self else { return }

                   if self.createMeetingPeriodView.isTimePickerViewVisible {
                       self.createMeetingPeriodView.timePickerViewDisappear()
                   } else {
                       self.createMeetingPeriodView.timePickerViewAppear()
                       if self.createMeetingPeriodView.isCalendarViewVisible {
                           self.createMeetingPeriodView.calendarViewDisappear()
                           self.createMeetingPeriodView.isCalendarViewVisible = false
                       }
                   }

                   self.createMeetingPeriodView.isTimePickerViewVisible.toggle()
                   self.updateCreateMeetingPeriodViewHeight()
               })
               .disposed(by: disposeBag)

        
        createMeetingPeriodViewModel.timeRelay
            .bind(onNext: { [weak self] time in
                self?.createMeetingPeriodView.timeBtView.configure(subTitle: time)
                self?.createMeetingPeriodView.timeBtView.subTitleLabel.textColor = .black
            })
            .disposed(by: disposeBag)
        
        createMeetingPeriodViewModel.selectedDate
            .bind(onNext: { [weak self] date in
                self?.createMeetingPeriodView.dateBtView.configure(subTitle: date)
                self?.createMeetingPeriodView.dateBtView.subTitleLabel.textColor = .black
            })
            .disposed(by: disposeBag)
        
>>>>>>> 10657f1 ([FEAT] 모임 생성 타입 결정 화면 present 애니메이션 개발)
    }
    
    func layout(){
        [progressView,scrollView]
            .forEach{ self.view.addSubview($0) }
        scrollView.addSubview(contentView)
<<<<<<< HEAD
        
=======
>>>>>>> 5e24642 ([FEAT] 모임 생성 마지막 페이지 개발)
        progressView.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
<<<<<<< HEAD
        
=======
>>>>>>> 5e24642 ([FEAT] 모임 생성 마지막 페이지 개발)
        scrollView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.top.equalTo(progressView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
<<<<<<< HEAD
        
=======
>>>>>>> 5e24642 ([FEAT] 모임 생성 마지막 페이지 개발)
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.leading.trailing.top.bottom.equalToSuperview()
        }
<<<<<<< HEAD
        
        [mainTitleLabel,createMeetingTitleView,createMeetingRegionView,createMeetingMemberView,createMeetingPeriodView,createMeetingImageView,createMeetingWritingView,createButton]
            .forEach{ contentView.addSubview($0) }
        
=======
        [mainTitleLabel,createMeetingTitleView,createMeetingRegionView,createMeetingMemberView,createMeetingPeriodView,createMeetingImageView,createMeetingWritingView,createButton]
            .forEach{ contentView.addSubview($0) }
>>>>>>> 5e24642 ([FEAT] 모임 생성 마지막 페이지 개발)
        mainTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(60)
        }
<<<<<<< HEAD
        
=======
>>>>>>> 5e24642 ([FEAT] 모임 생성 마지막 페이지 개발)
        createMeetingTitleView.snp.makeConstraints { make in
            make.height.equalTo(153)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(40)
        }
<<<<<<< HEAD
        
=======
>>>>>>> 5e24642 ([FEAT] 모임 생성 마지막 페이지 개발)
        createMeetingRegionView.snp.makeConstraints { make in
            make.height.equalTo(144)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(createMeetingTitleView.snp.bottom).offset(40)
        }
<<<<<<< HEAD
        
=======
>>>>>>> 5e24642 ([FEAT] 모임 생성 마지막 페이지 개발)
        createMeetingMemberView.snp.makeConstraints { make in
            make.height.equalTo(97)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(createMeetingRegionView.snp.bottom).offset(40)
        }
<<<<<<< HEAD
        
=======
>>>>>>> 5e24642 ([FEAT] 모임 생성 마지막 페이지 개발)
        createMeetingPeriodView.snp.makeConstraints { make in
            make.height.equalTo(97)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(createMeetingMemberView.snp.bottom).offset(40)
        }
<<<<<<< HEAD
        
=======
>>>>>>> 5e24642 ([FEAT] 모임 생성 마지막 페이지 개발)
        createMeetingImageView.snp.makeConstraints { make in
            make.height.equalTo(189)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(createMeetingPeriodView.snp.bottom).offset(40)
        }
<<<<<<< HEAD
        
=======
>>>>>>> 5e24642 ([FEAT] 모임 생성 마지막 페이지 개발)
        createMeetingWritingView.snp.makeConstraints { make in
            make.height.equalTo(217)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(createMeetingImageView.snp.bottom).offset(40)
        }
<<<<<<< HEAD
        
=======
>>>>>>> 5e24642 ([FEAT] 모임 생성 마지막 페이지 개발)
        createButton.snp.makeConstraints { make in
            make.width.equalTo(335)
            make.height.equalTo(52)
            make.centerX.equalToSuperview()
            make.top.equalTo(createMeetingWritingView.snp.bottom).offset(56)
            make.bottom.equalToSuperview()
        }
    }
    
    func updateCreateMeetingPeriodViewHeight() {
        let baseHeight = 97
        let calendarViewHeight = 358 + 16
        let timePickerViewHeight = 168 + 16

        let newHeight: Int
        if createMeetingPeriodView.isCalendarViewVisible {
            newHeight = baseHeight + calendarViewHeight
        } else if createMeetingPeriodView.isTimePickerViewVisible {
            newHeight = baseHeight + timePickerViewHeight
        } else {
            newHeight = baseHeight
        }

        self.createMeetingPeriodView.snp.updateConstraints { make in
            make.height.equalTo(newHeight)
        }

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
<<<<<<< HEAD
<<<<<<< HEAD
=======

    
>>>>>>> 5e24642 ([FEAT] 모임 생성 마지막 페이지 개발)
=======

>>>>>>> 10657f1 ([FEAT] 모임 생성 타입 결정 화면 present 애니메이션 개발)
}
