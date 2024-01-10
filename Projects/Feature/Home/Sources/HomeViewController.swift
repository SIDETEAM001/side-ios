//
//  HomeViewController.swift
//  FeatureHome
//
//  Created by yoonyeosong on 2023/11/29.
//


import UIKit
import SharedDSKit
import RxSwift

public class HomeViewController: UIViewController {
    let disposeBag = DisposeBag()
    var homeView = HomeView()

    public override func loadView() {
        super.loadView()
        view = homeView
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        homeView.plusButton.rx.tap
            .bind(onNext: { [weak self] in
                let selectMeetingTypeVC = SelectMeetingTypeViewController(selectMeetingTypeViewModel: SelectMeetingTypeViewModel())
                selectMeetingTypeVC.homeNavigationController = self?.navigationController
                self?.present(selectMeetingTypeVC, animated: false)
            })
            .disposed(by: disposeBag)
        homeView.segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        homeView.segmentedControl.selectedSegmentIndex = 0

        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: SharedDSKitAsset.Colors.lightGreen.color, NSAttributedString.Key.font: Fonts.SH02Bold.font]
        let titleTextAttributes2 = [NSAttributedString.Key.font: Fonts.Body02.font, NSAttributedString.Key.foregroundColor: SharedDSKitAsset.Colors.text03.color]
        homeView.segmentedControl.setTitleTextAttributes(titleTextAttributes1, for: .selected)
        homeView.segmentedControl.setTitleTextAttributes(titleTextAttributes2, for: .normal)
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    @objc private func didChangeValue(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            homeView.recommendView.isHidden = false
            homeView.selfDevelopmentView.isHidden = true
            homeView.hobbyView.isHidden = true
        } else if segment.selectedSegmentIndex == 1{
            homeView.recommendView.isHidden = true
            homeView.selfDevelopmentView.isHidden = false
            homeView.hobbyView.isHidden = true
        } else {
            homeView.recommendView.isHidden = true
            homeView.selfDevelopmentView.isHidden = true
            homeView.hobbyView.isHidden = false
        }
    }

}
