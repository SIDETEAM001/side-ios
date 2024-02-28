import UIKit
import Domain
import RxFlow

final public class MyPageFlow: Flow {
    
    public var root: Presentable {
        return self.rootViewController
    }
    
    var provider: ServiceProviderType
    
    private let rootViewController: UINavigationController
    let selectPositionReactor = SelectPositionReactor()
    var settingReactor: SettingReactor?
    
    public init(with provider: ServiceProviderType, with rootViewController: UINavigationController) {
        self.provider = provider
        self.rootViewController = rootViewController
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MyPageStep else { return .none }
        switch step {
        case .popViewController:
            return popViewController()
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
        case .presentToSelectPositionViewController:
            return coordinateToSelectPositionViewController()
        case .presentToWithdrawalAlert:
            return coordinateToWithdrawalAlert()
        //TODO: AppStep 연결 후 주석 삭제
//        case .endMyPage:
//            return .end(forwardToParentFlowWithStep: AppStep.signInRequired)
        }
    }
    
    private func popViewController() -> FlowContributors {
        self.rootViewController.popViewController(animated: true)
        
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
