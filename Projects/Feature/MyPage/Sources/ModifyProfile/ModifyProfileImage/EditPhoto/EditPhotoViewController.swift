import UIKit
import Mantis
import RxSwift
import RxCocoa

public class EditPhotoViewController: CropViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}

extension EditPhotoViewController: CropViewControllerDelegate {
    public func cropViewControllerDidCrop(_ cropViewController: Mantis.CropViewController, cropped: UIImage, transformation: Mantis.Transformation, cropInfo: Mantis.CropInfo) {
        EditPhotoReactor.shared.action.onNext(.setImage(cropped))
        EditPhotoReactor.shared.action.onNext(.doubleDismissView)
    }
    
    public func cropViewControllerDidCancel(_ cropViewController: CropViewController, original: UIImage) {
        EditPhotoReactor.shared.action.onNext(.dismissView)
    }
}
