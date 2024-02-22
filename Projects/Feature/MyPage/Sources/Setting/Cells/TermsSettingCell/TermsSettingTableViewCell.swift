import UIKit
import RxSwift
import ReactorKit
import Shared
import SnapKit

class TermsSettingTableViewCell: UITableViewCell, ReactorKit.View {
    var disposeBag = DisposeBag()
    let mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = SharedDSKitAsset.Colors.gr100.color
        label.font = Fonts.Body02.font
        return label
    }()
    let rightButton: UIButton = {
        let button = UIButton()
        button.setImage(SharedDSKitAsset.Icons.iconArrowRight16.image, for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        [mainLabel, rightButton]
            .forEach { self.contentView.addSubview($0) }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16*Constants.standardHeight)
            make.leading.equalToSuperview().offset(20*Constants.standardWidth)
            make.bottom.equalToSuperview().offset(-16*Constants.standardHeight)
        }
        
        rightButton.snp.makeConstraints { make in
            make.width.height.equalTo(16*Constants.standardHeight)
            make.trailing.equalToSuperview().offset(-20*Constants.standardWidth)
            make.centerY.equalTo(mainLabel)
        }
    }
}

extension TermsSettingTableViewCell{
    func bind(reactor: TermsSettingTableViewCellReactor) {
        reactor.state.map { $0.mainLabelText }
            .distinctUntilChanged()
            .bind(to: mainLabel.rx.text)
            .disposed(by: disposeBag)
    }
}