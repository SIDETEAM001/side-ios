import ReactorKit
import UIKit.UIImage
import RxFlow
import RxCocoa
import CoreStep

public class CameraReactor: ReactorKit.Reactor, Stepper {
    public let initialState: State
    public var steps = PublishRelay<Step>()

    public init() {
        self.initialState = State(selectedImage: nil)
    }
    
    public enum Action {
        case selectImage(UIImage)
        case dismissView
    }
    
    public enum Mutation{
        
    }
    
    public struct State{
        var selectedImage: UIImage?
    }

    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .selectImage(let image):
            self.steps.accept(MyPageStep.presentEditPhotoViewController(image: image))
            return .empty()
        case .dismissView:
            self.steps.accept(MyPageStep.dismissViewController)
            return .empty()
        }
    }
}
