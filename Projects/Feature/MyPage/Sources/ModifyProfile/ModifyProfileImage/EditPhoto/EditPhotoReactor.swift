import ReactorKit
import UIKit.UIImage
import RxFlow
import RxCocoa
import CoreStep

public class EditPhotoReactor: ReactorKit.Reactor, Stepper {
    public static let shared = EditPhotoReactor()
    public let initialState: State
    public var steps = PublishRelay<Step>()

    public init() {
        self.initialState = State(image: nil)
    }
    
    public enum Action {
        case setImage(UIImage?)
        case clearImage
        case doubleDismissView
        case dismissView
    }

    public enum Mutation {
        case setImage(UIImage?)
    }

    public struct State {
        var image: UIImage?
    }

    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .setImage(let image):
            return .just(.setImage(image))
        case .clearImage:
            return .just(.setImage(nil))
        case .doubleDismissView:
            self.steps.accept(MyPageStep.doubleDismissViewController)
            return .empty()
        case .dismissView:
            self.steps.accept(MyPageStep.dismissViewController)
            return .empty()
        }
    }

    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setImage(let image):
            newState.image = image
        }
        return newState
    }
}
