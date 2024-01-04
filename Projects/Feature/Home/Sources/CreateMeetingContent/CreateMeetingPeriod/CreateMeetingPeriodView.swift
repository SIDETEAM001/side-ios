import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Shared

class CreateMeetingPeriodView: UIView{
    let disposeBag = DisposeBag()
    var createMeetingPeriodViewModel: CreateMeetingPeriodViewModel
    var isCalendarViewVisible = false
    var isTimePickerViewVisible = false
    
    let dateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 날짜는 언제인가요?"
        label.font = Fonts.SH03Bold.font
        return label
    }()
    let dateBtView: PeriodBtView = {
        let dateBtView = PeriodBtView(title: "모임 날짜", subTitle: "날짜 선택")
        dateBtView.layer.cornerRadius = 16
        dateBtView.layer.borderWidth = 1
        dateBtView.layer.borderColor = SharedDSKitAsset.Colors.gr10.color.cgColor
        return dateBtView
    }()
    let timeBtView: PeriodBtView = {
        let timeBtView = PeriodBtView(title: "모임 시간", subTitle: "시간 선택")
        timeBtView.layer.cornerRadius = 16
        timeBtView.layer.borderWidth = 1
        timeBtView.layer.borderColor = SharedDSKitAsset.Colors.gr10.color.cgColor
        return timeBtView
    }()
    lazy var calendarView = CalendarView(createMeetingPeriodViewModel: createMeetingPeriodViewModel)
    lazy var timePickerView = TimePickerView(createMeetingPeriodViewModel: createMeetingPeriodViewModel)
    
    init(createMeetingPeriodViewModel: CreateMeetingPeriodViewModel) {
        self.createMeetingPeriodViewModel = createMeetingPeriodViewModel
        super.init(frame: .zero)
        
        calendarView.isHidden = true
        timePickerView.isHidden = true
        //bind()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(){
        dateBtView.tapGesture.rx.event
            .map { _ in Void() }
            .bind(to: createMeetingPeriodViewModel.dateBtViewTapped)
            .disposed(by: disposeBag)
        
        createMeetingPeriodViewModel.dateBtViewTapped
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                if self.isCalendarViewVisible {
                    self.calendarViewDisappear()
                } else {
                    self.calendarViewAppear()
                }
                self.isCalendarViewVisible.toggle()
            })
            .disposed(by: disposeBag)
        
        timeBtView.tapGesture.rx.event
            .map { _ in Void() }
            .bind(to: createMeetingPeriodViewModel.timeBtViewTapped)
            .disposed(by: disposeBag)
        
        createMeetingPeriodViewModel.timeBtViewTapped
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                if self.isTimePickerViewVisible {
                    self.timePickerViewDisappear()
                } else {
                    self.timePickerViewAppear()
                }
                self.isTimePickerViewVisible.toggle()
            })
            .disposed(by: disposeBag)
        
    }
    
    func layout(){
        [dateTitleLabel,dateBtView,timeBtView,calendarView,timePickerView]
            .forEach{ self.addSubview($0) }
        
        dateTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview()
        }
        
        dateBtView.snp.makeConstraints { make in
            make.width.equalTo(163.5)
            make.height.equalTo(56)
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(dateTitleLabel.snp.bottom).offset(16)
        }
        
        timeBtView.snp.makeConstraints { make in
            make.width.equalTo(163.5)
            make.height.equalTo(56)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(dateTitleLabel.snp.bottom).offset(16)
        }
        
        calendarView.snp.makeConstraints { make in
            make.width.equalTo(335)
            make.height.equalTo(0)
            make.centerX.equalToSuperview()
            make.top.equalTo(timeBtView.snp.bottom).offset(16)
        }

        timePickerView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(0)
            make.leading.equalToSuperview()
            make.top.equalTo(timeBtView.snp.bottom).offset(16)
        }
    }
    
    func calendarViewAppear(){
        UIView.animate(withDuration: 0.3){
            self.calendarView.isHidden = false
            self.calendarView.snp.updateConstraints { make in
                make.height.equalTo(358)
            }
            self.layoutIfNeeded()
        }
    }
    
    func calendarViewDisappear(){
        UIView.animate(withDuration: 0.3){
            self.calendarView.isHidden = true
            self.calendarView.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
            self.layoutIfNeeded()
        }
    }
    
    func timePickerViewAppear(){
        UIView.animate(withDuration: 0.3){
            self.timePickerView.isHidden = false
            self.timePickerView.snp.updateConstraints { make in
                make.height.equalTo(168)
            }
            self.layoutIfNeeded()
        }
    }
    
    func timePickerViewDisappear(){
        UIView.animate(withDuration: 0.3){
            self.timePickerView.isHidden = true
            self.timePickerView.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
            self.layoutIfNeeded()
        }
    }
}
