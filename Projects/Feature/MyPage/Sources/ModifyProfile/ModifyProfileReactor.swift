import Foundation
import Photos
import RxCocoa
import ReactorKit
import RxFlow
import Domain
import CoreStep

public class ModifyProfileReactor: ReactorKit.Reactor, Stepper{
    public var initialState: State
    public var steps = PublishRelay<Step>()
    let provider: ServiceProviderType
    
    public init(provider: ServiceProviderType){
        self.initialState = State()
        self.provider = provider
    }
    
    public enum Action {
        case loadData
        case backButtonTapped
        case cameraButtonTapped
        case requestCameraAuthorization
        case requestPhotoLibraryAuthorization
        case setPhotoAuthType(String)
        case setCameraAuthType(String)
        case saveButtonTapped
        case updateNickname(String)
        case updateBirth(String)
        case updatePosition(String)
        case positionTextFieldViewTapped
        case toggleDevelopItem(IndexPath)
        case toggleHobbyItem(IndexPath)
        case updateDevelopContentSize(CGSize)
        case updateHobbyContentSize(CGSize)
    }
    
    public enum Mutation {
        case setProfileImage(String)
        case setNickname(String)
        case setBitrh(String)
        case setPosition(String)
        case updateDevelopCellData([ModifyProfileCellData])
        case updateHobbyCellData([ModifyProfileCellData])
        case toggleDevelopItem(IndexPath)
        case toggleHobbyItem(IndexPath)
        case setDevelopContentSize(CGSize)
        case setHobbyContentSize(CGSize)
    }
    
    public struct State {
        var developCellData: [ModifyProfileCellData] = DevelopCellData.cellData
        var hobbyCellData: [ModifyProfileCellData] = HobbyCellData.cellData
        var profileImage: String = ""
        var nickname: String = ""
        var birth: String = ""
        var position: String = ""
        var developContentSize: CGSize = .zero
        var hobbyContentSize: CGSize = .zero
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadData:
            return self.provider.myPageService.getMyProfile().responseData()
                .flatMap { response, data -> Observable<Mutation> in
                    do {
                        let decoder = JSONDecoder()
                        let myProfileResponse = try decoder.decode(GetMyProfileResponse.self, from: data)
                        let nickname = myProfileResponse.nickname
                        let profileImage = myProfileResponse.profileImageUrl
                        let birth = myProfileResponse.birth
                        let position = myProfileResponse.jobMajor
                        let updatedDevelopCellData = self.currentState.developCellData.map { cell -> ModifyProfileCellData in
                            var modifiedCell = cell
                            modifiedCell.isSelected = myProfileResponse.develops.contains { $0 == cell.item }
                            return modifiedCell
                        }
                        let updatedHobbyCellData = self.currentState.hobbyCellData.map { cell -> ModifyProfileCellData in
                            var modifiedCell = cell
                            modifiedCell.isSelected = myProfileResponse.hobbies.contains{ $0 == cell.item }
                            return modifiedCell
                        }
                        return Observable.concat([
                            .just(.setProfileImage(profileImage)),
                            .just(.setNickname(nickname)),
                            .just(.setBitrh(birth)),
                            .just(.setPosition(position)),
                            .just(.updateDevelopCellData(updatedDevelopCellData)),
                            .just(.updateHobbyCellData(updatedHobbyCellData))
                        ])
                    } catch {
                        return .empty()
                    }
                }
        case .backButtonTapped:
            self.steps.accept(MyPageStep.popViewController)
            return .empty()
        case .cameraButtonTapped:
            self.steps.accept(MyPageStep.presentPhotoCameraActionSheet)
            return .empty()
        case .requestCameraAuthorization:
            self.requestCameraAuthorization()
            return .empty()
        case .requestPhotoLibraryAuthorization:
            self.requestPhotoLibraryAuthorization()
            return .empty()
        case .setPhotoAuthType(let type):
            if type == "authorized" || type == "limited" {
                self.steps.accept(MyPageStep.presentAlbumViewController(type: type))
            }
            else{
                self.steps.accept(MyPageStep.presentDeniedAlert(target: "사진"))
            }
            return .empty()
        case .setCameraAuthType(let type):
            if type == "authorized" {
                self.steps.accept(MyPageStep.presentCameraViewController)
            }
            else{
                self.steps.accept(MyPageStep.presentDeniedAlert(target: "카메라"))
            }
            return .empty()
        case .saveButtonTapped:
            let clubCategories = (self.currentState.developCellData + self.currentState.hobbyCellData)
                .filter { $0.isSelected }
                .map { $0.item }
            if let userImage = EditPhotoReactor.shared.currentState.image {
                return self.provider.myPageService.transformImageToURL(image: [userImage])
                    .flatMapLatest { uploadRequest -> Observable<String> in
                        return uploadRequest.rx.responseData()
                            .flatMap { response, data -> Observable<String> in
                                let decoder = JSONDecoder()
                                do {
                                    let getUrlImageResponse = try decoder.decode(TransformImageToURLResponse.self, from: data)
                                    if let urlImage = getUrlImageResponse.urls.first {
                                        return Observable.just(urlImage)
                                    }
                                    else {
                                        return Observable.error(NSError(domain: "No URL Found", code: -1, userInfo: nil))
                                    }
                                }
                                catch {
                                    return Observable.error(error)
                                }
                            }
                    }
                    .flatMapLatest{ urlImage -> Observable<Mutation> in
                        return self.provider.myPageService.modifyMyProfile(nickname: self.currentState.nickname, birth: self.currentState.birth, profileImageUrl: urlImage, jobCategory: self.currentState.position, clubCategories: clubCategories).responseData()
                            .flatMap{ response, data -> Observable<Mutation> in
                                self.steps.accept(MyPageStep.popViewController)
                                return .empty()
                            }
                    }
            }
            else{
                return self.provider.myPageService.modifyMyProfile(nickname: self.currentState.nickname, birth: self.currentState.birth, profileImageUrl: self.currentState.profileImage, jobCategory: self.currentState.position, clubCategories: clubCategories).responseData()
                    .flatMap{ response, data -> Observable<Mutation> in
                        self.steps.accept(MyPageStep.popViewController)
                        return .empty()
                    }
            }
        case .updateNickname(let nickname):
            return .just(.setNickname(nickname))
        case .updateBirth(let birth):
            let digitsText = birth.replacingOccurrences(of: "-", with: "")
            var formattedText = ""
            for (index, character) in digitsText.enumerated() {
                if index == 4 || index == 6 {
                    formattedText += "-"
                }
                formattedText.append(character)
            }
            let formattedBirth = formattedText.count > 10 ? String(formattedText.prefix(10)) : formattedText
            return .just(.setBitrh(formattedBirth))
        case .updatePosition(let position):
            return .just(.setPosition(position))
        case .positionTextFieldViewTapped:
            self.steps.accept(MyPageStep.presentToSelectPositionViewController)
            return .empty()
        case .toggleDevelopItem(let indexPath):
            return .just(.toggleDevelopItem(indexPath))
        case .toggleHobbyItem(let indexPath):
            return .just(.toggleHobbyItem(indexPath))
        case .updateDevelopContentSize(let size):
            return .just(.setDevelopContentSize(size))
        case .updateHobbyContentSize(let size):
            return .just(.setHobbyContentSize(size))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateDevelopCellData(let cellData):
            newState.developCellData = cellData
        case .updateHobbyCellData(let cellData):
            newState.hobbyCellData = cellData
        case .setProfileImage(let image):
            newState.profileImage = image
        case .setNickname(let nickname):
            newState.nickname = nickname
        case .setBitrh(let birth):
            newState.birth = birth
        case .setPosition(let position):
            newState.position = position
        case .toggleDevelopItem(let indexPath):
            newState.developCellData[indexPath.row].isSelected.toggle()
        case .toggleHobbyItem(let indexPath):
            newState.hobbyCellData[indexPath.row].isSelected.toggle()
        case .setDevelopContentSize(let size):
            newState.developContentSize = size
        case .setHobbyContentSize(let size):
            newState.hobbyContentSize = size
        }
        return newState
    }
    
    public func requestCameraAuthorization() {
        DispatchQueue.main.async {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                self.action.onNext(.setCameraAuthType("authorized"))
            case .denied:
                self.action.onNext(.setCameraAuthType("denied"))
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted{
                        self.action.onNext(.setCameraAuthType("authorized"))
                    }
                    else{
                        self.action.onNext(.setCameraAuthType("denied"))
                    }
                }
            default:
                break
            }
        }
    }

    public func requestPhotoLibraryAuthorization() {
        DispatchQueue.main.async {
            let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
            switch status {
            case .authorized:
                self.action.onNext(.setPhotoAuthType("authorized"))
            case .limited:
                self.action.onNext(.setPhotoAuthType("limited"))
            case .denied:
                self.action.onNext(.setPhotoAuthType("denied"))
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization { newStatus in
                    if newStatus == .authorized{
                        self.action.onNext(.setPhotoAuthType("authorized"))
                    }
                    if newStatus == .limited {
                        self.action.onNext(.setPhotoAuthType("limited"))
                    }
                    else if newStatus == .denied{
                        self.action.onNext(.setPhotoAuthType("denied"))
                    }
                    else{
                        self.action.onNext(.setPhotoAuthType(""))
                    }
                }
            default:
                self.action.onNext(.setPhotoAuthType(""))
            }
        }
    }
}
