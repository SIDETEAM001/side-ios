import UIKit
import SnapKit
import Shared

class SideProjectBtView: UIView{
    let tapGesture = UITapGestureRecognizer()
    let borderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 40*Constants.standardHeight
        view.layer.borderWidth = 1
        view.layer.borderColor = SharedDSKitAsset.Colors.lightGreen.color.cgColor
        view.isHidden = true
        return view
    }()
    let imgBgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(red: 0.78, green: 0.89, blue: 0.98, alpha: 1)
        imageView.layer.cornerRadius = 36*Constants.standardHeight
        return imageView
    }()
    lazy var targetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = SharedDSKitAsset.Icons.image378.image
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.SH01Bold.font
        label.textAlignment = .center
        label.text = "사이드 프로젝트"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addGestureRecognizer(tapGesture)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(){
        [borderView,imgBgImageView,targetImageView,titleLabel]
            .forEach{ self.addSubview($0) }
        
        borderView.snp.makeConstraints { make in
            make.width.height.equalTo(80*Constants.standardHeight)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        imgBgImageView.snp.makeConstraints { make in
            make.width.height.equalTo(72*Constants.standardHeight)
            make.centerX.centerY.equalTo(borderView)
        }
        
        targetImageView.snp.makeConstraints { make in
            make.width.equalTo(50*Constants.standardWidth)
            make.height.equalTo(36.847*Constants.standardHeight)
            make.top.equalTo(imgBgImageView.snp.top).offset(18*Constants.standardHeight)
            make.leading.equalTo(imgBgImageView.snp.leading)
                .offset(12.5*Constants.standardWidth)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}
