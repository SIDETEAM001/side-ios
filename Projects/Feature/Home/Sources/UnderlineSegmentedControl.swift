//
//  UnderlineSegmentedControl.swift
//  FeatureHome
//
//  Created by yoonyeosong on 2023/12/07.
//

import UIKit
import Shared

class UnderlineSegmentedControl: UISegmentedControl {
    private lazy var underlineView: UIView = {
        let width = self.bounds.size.width / CGFloat(self.numberOfSegments) - 10
        let height: CGFloat = 2.0
        let xPosition = CGFloat(self.selectedSegmentIndex * Int(width))
        let yPosition = self.bounds.size.height - 2.0
        let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        let view = UIView(frame: frame)
        view.backgroundColor = SharedDSKitAsset.Colors.lightGreen.color
        self.addSubview(view)
        return view
      }()

      override init(frame: CGRect) {
        super.init(frame: frame)
        self.render()
      }
      override init(items: [Any]?) {
        super.init(items: items)
        self.render()
      }
      required init?(coder: NSCoder) {
        fatalError()
      }

      private func render() {
        let image = UIImage()
        self.setBackgroundImage(image, for: .normal, barMetrics: .default)
        self.setBackgroundImage(image, for: .selected, barMetrics: .default)
        self.setBackgroundImage(image, for: .highlighted, barMetrics: .default)

        self.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
      }

      override func layoutSubviews() {
        super.layoutSubviews()

        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(self.selectedSegmentIndex) + 6
        UIView.animate(
          withDuration: 0.1,
          animations: {
            self.underlineView.frame.origin.x = underlineFinalXPosition
          }
        )
      }

}
