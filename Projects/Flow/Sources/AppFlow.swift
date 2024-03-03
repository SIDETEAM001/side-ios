//
//  AppFlow.swift
//  Flow
//
//  Created by 강민성 on 3/3/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxFlow
import FeatureSignIn
import FeatureHome
import FeatureMyPage
import SharedDSKit
import Domain
import CoreStep

public struct AppStepper: Stepper {
    
    public let steps = PublishRelay<Step>()
    private let provider: ServiceProviderType
    private let disposeBag: DisposeBag = .init()
    
    public init(provider: ServiceProviderType) {
        self.provider = provider
    }
}

public final class AppFlow: Flow {
    public var root: Presentable {
        return self.rootWindow
    }
    
    private let rootWindow: UIWindow
    private let provider: ServiceProviderType
    
    public init(with window: UIWindow, provider: ServiceProviderType) {
        self.rootWindow = window
        self.provider = provider
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        
        switch step {
        case .signInRequired:
            return coordinateToSignInViewController()
            
        case .userIsSignedIn:
            return coordinateToTPTabBarContoller()
            
            //MARK: 아래 goToTabBar은 지울것
        case .goToTabBar:
            return coordinateToTPTabBarContoller()
            
        default:
            return .none
        }
    }
    
    private func coordinateToSignInViewController() -> FlowContributors {
        let signInFlow = SignInFlow(with: provider)
        
        Flows.use(signInFlow, when: .created) { [unowned self] root in
            self.rootWindow.rootViewController = root
        }
        
        let nextStep = OneStepper(withSingleStep: SignInStep.signInRequired)
        
        return .one(flowContributor: .contribute(withNextPresentable: signInFlow, withNextStepper: nextStep))
        
    }
    /*
    private func coordinateToHomeViewController() -> FlowContributors {
        let homeFlow = HomeFlow(with: provider)
        
        Flows.use(homeFlow, when: .created) { [unowned self] root in
            self.rootWindow.rootViewController = root
        }
        
        let nextStep = OneStepper(withSingleStep: AppStep.userIsSignedIn)
        
        return .one(flowContributor: .contribute(withNextPresentable: homeFlow, withNextStepper: nextStep))
    }
    */
    
    private func coordinateToTPTabBarContoller() -> FlowContributors {
        let TPTabBarController = TPTabBarController()
        let homeNavigationController = UINavigationController()
        let chatNavigationController = UINavigationController()
        let myPageNavigationController = UINavigationController()
        
        let homeFlow = HomeFlow(with: provider, with: homeNavigationController)
        //let chatFlow =
        let myPageFlow = MyPageFlow(with: provider, with: myPageNavigationController)
        
        Flows.use(homeFlow, myPageFlow, when: .created) { [weak self] (homeRoot,myPageRoot) in
            
            homeRoot.tabBarItem = UITabBarItem(title: "모임", image: SharedDSKitAsset.Icons.iconHome24.image, tag: 0)
            myPageRoot.tabBarItem = UITabBarItem(title: "마이 페이지", image: SharedDSKitAsset.Icons.iconMy24.image, tag: 2)
            
            TPTabBarController.viewControllers = [homeRoot, myPageRoot]
            self?.rootWindow.rootViewController = TPTabBarController
        }

        return .multiple(flowContributors: [
            .contribute(withNextPresentable: homeFlow, withNextStepper: OneStepper(withSingleStep: HomeStep.goToHomeViewController)),
            .contribute(withNextPresentable: myPageFlow, withNextStepper: OneStepper(withSingleStep: MyPageStep.goToMyPageViewController))
        ])
    }
}
