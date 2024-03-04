import ReactorKit
import UIKit.UIImage

public class AlbumCollectionViewCellReactor: ReactorKit.Reactor {
    public let initialState: State

    init(image: UIImage?, isSelected: Bool = false) {
        self.initialState = State(image: image, isSelected: isSelected)
    }
    
    public enum Action {
        case selectImage(Bool)
    }
    
    public enum Mutation {
        case setSelected(Bool)
    }

    public struct State {
        var image: UIImage?
        var isSelected: Bool = false
    }

    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .selectImage(let status):
            return .just(.setSelected(status))
        }
    }

    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setSelected(let isSelected):
            newState.isSelected = isSelected
        }
        return newState
    }
}
