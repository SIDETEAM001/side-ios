import UIKit
import Mantis
import RxCocoa

public class CameraViewController: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    public let cameraReactor = CameraReactor()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else {
            self.cameraReactor.action.onNext(.dismissView)
            return
        }
        self.cameraReactor.action.onNext(.selectImage(selectedImage))
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.cameraReactor.action.onNext(.dismissView)
    }
}
