import RxCocoa
import ReactorKit
import RxFlow
import CoreStep

public class TermsReactor: ReactorKit.Reactor, Stepper{
    public var initialState: State
    public var steps = PublishRelay<Step>()
    
    public init(){
        self.initialState = State()
    }
    
    public enum Action {
        case backButtonTapped
    }
    
    public enum Mutation {
        
    }
    
    public struct State{
        
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .backButtonTapped:
            self.steps.accept(MyPageStep.popViewController)
            return .empty()
        }
    }
}
