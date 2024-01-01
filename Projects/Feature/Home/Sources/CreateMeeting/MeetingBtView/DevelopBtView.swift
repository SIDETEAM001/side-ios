import UIKit
import SnapKit
import Shared

class DevelopBtView: UIView{
    let imgBgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.78, alpha: 1)
        imageView.layer.cornerRadius = 44
        return imageView
    }()
    lazy var targetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = SharedDSKitAsset.Icons.fire1.image
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.SH03Bold.font
        label.textAlignment = .center
        label.text = "자기계발"
        return label
    }()
    let tapGesture = UITapGestureRecognizer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addGestureRecognizer(tapGesture)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(){
        [imgBgImageView,targetImageView,titleLabel]
            .forEach{ self.addSubview($0) }
        
        imgBgImageView.snp.makeConstraints { make in
            make.width.height.equalTo(88)
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }
        
        targetImageView.snp.makeConstraints { make in
            make.width.height.equalTo(76)
            make.top.equalTo(imgBgImageView.snp.top).offset(1)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imgBgImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
    }
}
