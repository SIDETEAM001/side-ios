import UIKit
import Domain
import CoreStep
import FeatureMyPage
import RxFlow
import Mantis

final public class MyPageFlow: Flow {
    
    public var root: Presentable {
        return self.rootViewController
    }
    
    var provider: ServiceProviderType
    
    private let rootViewController: UINavigationController
    let selectPositionReactor = SelectPositionReactor()
    var settingReactor: SettingReactor?
    var modifyProfileReactor: ModifyProfileReactor?
    
    public init(with provider: ServiceProviderType, with rootViewController: UINavigationController) {
        self.provider = provider
        self.rootViewController = rootViewController
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MyPageStep else { return .none }
        switch step {
        case .popViewController:
            return popViewController()
        case .dismissViewController:
            return dismissViewController()
        case .dismissEditPhotoViewController:
            return dismissEditPhotoViewController()
        case .doubleDismissViewController:
            return doubleDismissViewController()
        case .goToMyPageViewController:
            return coordinateToMyPageViewController()
        case .goToMyActivityViewController(let myClubCount, let clubBookmarkCount):
            return coordinateToMyActivityViewController(myClubCount: myClubCount, clubBookmarkCount: clubBookmarkCount)
        case .goToSettingViewController(let memberId, let email):
            return coordinateToSettingViewController(memberId: memberId, email: email)
        case .goToModifyProfileViewController:
            return coordinateToModifyProfileViewController()
        case .goToTermsOfServiceViewController:
            return coordinateToTermsOfServiceViewController()
        case .goToPrivacyPolicyViewController:
            return coordinateToPrivacyPolicyViewController()
        case .goToLocationServicesTermsViewController:
            return coordinateToLocationServicesTermsViewController()
        case .presentPhotoCameraActionSheet:
            return coordinateToPhotoCameraActionSheet()
        case .presentDeniedAlert(let target):
            return coordinateToDeniedAlert(target: target)
        case .presentCameraViewController:
            return coordinateToCameraController()
        case .presentAlbumViewController(let type):
            return coordinateToAlbumViewController(type: type)
        case .presentEditPhotoViewController(let image):
            return coordinateToEditPhotoViewController(image: image)
        case .presentToSelectPositionViewController:
            return coordinateToSelectPositionViewController()
        case .presentToWithdrawalAlert:
            return coordinateToWithdrawalAlert()
        case .endMyPage:
            return .end(forwardToParentFlowWithStep: AppStep.signInRequired)
        }
    }
    
    private func popViewController() -> FlowContributors {
        self.rootViewController.popViewController(animated: true)
        
        return .none
    }
    
    private func dismissViewController() -> FlowContributors {
        self.rootViewController.dismiss(animated: true)
        return .none
    }
    
    private func dismissEditPhotoViewController() -> FlowContributors {
        self.rootViewController.presentedViewController?.dismiss(animated: true)
        return .none
    }
    
    private func doubleDismissViewController() -> FlowContributors {
        self.rootViewController.dismiss(animated: true, completion: {
            self.rootViewController.dismiss(animated: true)
        })
        return .none
    }
    
    private func coordinateToMyPageViewController() -> FlowContributors {
        let reactor = MyPageReactor(provider: self.provider)
        let viewController = MyPageViewController(with: reactor)
        self.rootViewController.pushViewController(viewController, animated: false)
        
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
    private func coordinateToMyActivityViewController(myClubCount: Int, clubBookmarkCount: Int) -> FlowContributors {
        let reactor = MyActivityReactor(provider: self.provider, myClubCount: myClubCount, clubBookmarkCount: clubBookmarkCount)
        let viewController = MyActivityViewController(with: reactor)
        viewController.hidesBottomBarWhenPushed = true
        self.rootViewController.pushViewController(viewController, animated: true)
        
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
    private func coordinateToSettingViewController(memberId: Int, email: String) -> FlowContributors {
        let reactor = SettingReactor(provider: self.provider, memberId: memberId, email: email)
        self.settingReactor = reactor
        let viewController = SettingViewController(with: reactor)
        viewController.hidesBottomBarWhenPushed = true
        self.rootViewController.pushViewController(viewController, animated: true)
        
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
    private func coordinateToModifyProfileViewController() -> FlowContributors {
        let selectPositionReactor = self.selectPositionReactor
        let reactor = ModifyProfileReactor(provider: self.provider)
        self.modifyProfileReactor = reactor
        let viewController = ModifyProfileViewController(with: reactor, selectPositionReactor: selectPositionReactor)
        viewController.hidesBottomBarWhenPushed = true
        self.rootViewController.pushViewController(viewController, animated: true)
        
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
    private func coordinateToTermsOfServiceViewController() -> FlowContributors {
        let reactor = TermsReactor()
        let viewController = TermsOfServiceViewController(with: reactor)
        self.rootViewController.pushViewController(viewController, animated: true)
        
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
    private func coordinateToPrivacyPolicyViewController() -> FlowContributors {
        let reactor = TermsReactor()
        let viewController = PrivacyPolicyViewController(with: reactor)
        self.rootViewController.pushViewController(viewController, animated: true)
        
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
    private func coordinateToLocationServicesTermsViewController() -> FlowContributors {
        let reactor = TermsReactor()
        let viewController = LocationServicesTermsViewController(with: reactor)
        self.rootViewController.pushViewController(viewController, animated: true)
        
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
    private func coordinateToPhotoCameraActionSheet() -> FlowContributors {
        let alert = UIAlertController(title: "사부작", message: nil, preferredStyle: .actionSheet)
        let photoLibraryAction = UIAlertAction(title: "앨범에서 사진선택", style: .default) { [weak self] _ in
            self?.modifyProfileReactor?.action.onNext(.requestPhotoLibraryAuthorization)
        }
        let cameraAction = UIAlertAction(title: "카메라 촬영", style: .default) { [weak self] _ in
            self?.modifyProfileReactor?.action.onNext(.requestCameraAuthorization)
        }
        alert.addAction(photoLibraryAction)
        alert.addAction(cameraAction)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.rootViewController.present(alert, animated: true, completion: nil)
                        
        return .none
    }
    
    private func coordinateToDeniedAlert(target: String) -> FlowContributors {
        let alert = UIAlertController(title: nil, message: "\(target) 기능을 사용하려면\n’\(target)’ 접근권한을 허용해야 합니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "설정", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.rootViewController.present(alert, animated: true, completion: nil)
        
        return .none
    }
    
    private func coordinateToCameraController() -> FlowContributors {
        let viewController = CameraViewController()
        viewController.sourceType = .camera
        viewController.allowsEditing = true
        viewController.cameraDevice = .rear
        viewController.cameraCaptureMode = .photo
        self.rootViewController.present(viewController, animated: true)
                                                     
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.cameraReactor))
    }
    
    private func coordinateToAlbumViewController(type: String) -> FlowContributors {
        let reactor = AlbumReactor(photoAuthType: type)
        let viewController = AlbumViewController(with: reactor)
        self.rootViewController.present(viewController, animated: true)
        
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
    private func coordinateToEditPhotoViewController(image: UIImage) -> FlowContributors {
        var config = Mantis.Config()
        config.cropMode = .async
        config.cropViewConfig.showAttachedRotationControlView = false
        config.cropToolbarConfig.toolbarButtonOptions = [.clockwiseRotate, .reset, .ratio, .autoAdjust, .horizontallyFlip]
        let viewController: EditPhotoViewController = Mantis.cropViewController(image: image, config: config)
        viewController.modalPresentationStyle = .overFullScreen
        self.rootViewController.presentedViewController?.present(viewController, animated: true)
                        
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: EditPhotoReactor.shared))
    }
    
    private func coordinateToSelectPositionViewController() -> FlowContributors {
        let reactor = self.selectPositionReactor
        let viewController = SelectPositionViewController(with: reactor)
        self.rootViewController.present(viewController, animated: false)
        
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }

    private func coordinateToWithdrawalAlert() -> FlowContributors {
        let alert = UIAlertController(title: "정말 탈퇴하시겠습니까?", message: "회원 탈퇴 시 계정 정보는 삭제되어\n복구가 불가해요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "탈퇴하기", style: .default, handler: { _ in
            self.settingReactor?.action.onNext(.withdrawalConfirm)
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.rootViewController.present(alert, animated: true, completion: nil)
        
        return .none
    }
}
