import RxFlow
import UIKit

public enum MyPageStep: Step {
    case popViewController
    case dismissViewController
    case dismissEditPhotoViewController
    case doubleDismissViewController
    case goToMyPageViewController
    case goToMyActivityViewController(myClubCount: Int, clubBookmarkCount: Int)
    case goToSettingViewController(memberId: Int, email: String)
    case goToModifyProfileViewController
    case goToTermsOfServiceViewController
    case goToPrivacyPolicyViewController
    case goToLocationServicesTermsViewController
    case presentPhotoCameraActionSheet
    case presentDeniedAlert(target: String)
    case presentCameraViewController
    case presentAlbumViewController(type: String)
    case presentEditPhotoViewController(image: UIImage)
    case presentToSelectPositionViewController
    case presentToWithdrawalAlert
    case endMyPage
}
