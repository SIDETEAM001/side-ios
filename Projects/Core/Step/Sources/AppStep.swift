//
//  AppStep.swift
//  CoreStep
//
//  Created by 강민성 on 3/3/24.
//

import Foundation
import RxFlow

public enum AppStep: Step {
    // Global
    case popViewController
    case popToRootViewController
    case dismiss
    case present
    
    // SignIn
    case signInRequired
    case userIsSignedIn
    case userIsSignedOut
    case forgotId
    case forgotIdPhoneNumberIsRequired
    case forgotIdEmailisRequired
    case forgotPassword
    case forgotPasswordPhoneNumberIsRequired
    case forgotPasswordEmailIsRequired
    case newPasswordIsRequired(String)
    case userChangedPassword
    
    // SignUp
    case agreementsIsRequried
    // Profile
    
    //TabBar
    case goToTabBar
    // Home
    
    // Chat
    
    // MyPage
}
