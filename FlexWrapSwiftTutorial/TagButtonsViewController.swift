//
//  TagButtonsViewController.swift
//  FlexWrapSwiftTutorial
//
//  Created by agustiyan on 30/11/22.
//

import UIKit

class TagButtonsViewController: UIViewController {

    private let containerView: UIView = {
        let view = UIView()
        // use auto layout
        view.translatesAutoresizingMaskIntoConstraints = false
        // give it a background color so we can see it
        view.backgroundColor = .secondarySystemBackground
        return view
    }()

    private let tagNames: [String] = [
        "Swift",
        "iOS",
        "XCode",
        "Objective-C",
        "UIKit",
        "SwiftUI",
        "Core Data",
        "Realm",
        "Combine",
        "RxSwift",
        "Clean Architecture",
        "MVVM",
        "MVC",
        "MVP",
        "VIPER",
        "TCA",
        "Algorithm",
        "Data Structure"
    ]

    private var tagButtons = [UIButton]()

    private let tagHeight:CGFloat = 30
    private let tagPadding: CGFloat = 16
    private let tagSpacingX: CGFloat = 8
    private let tagSpacingY: CGFloat = 8

    // container view height will be modified when laying out subviews
    private var containerHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()

        // add the container view
        view.addSubview(containerView)

        // initialize height constraint - actual height will be set later
        containerHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: 10.0)

        // constrain container safe-area top / leading / trailing to view with 20-pts padding
        let g = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: g.topAnchor, constant: 20.0),
            containerView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
            containerView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
            containerHeightConstraint,
        ])

        // add the buttons to the scroll view
        addTagButtons()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // call this here, after views have been laid-out
        // this will also be called when the size changes, such as device rotation,
        // so the buttons will "re-layout"
        displayTagButtons()

    }

    private func addTagButtons() -> Void {

        for j in 0..<self.tagNames.count {

            // create a new button
            let newButton = UIButton(type: .system)

            // set its properties (title, colors, corners, etc)
            newButton.setTitle(tagNames[j], for: .normal)
            newButton.layer.masksToBounds = true
            newButton.layer.cornerRadius = 8
            newButton.layer.borderWidth = 1
            newButton.tintColor = .systemBlue
            newButton.configuration = .filled()

            // set its frame width and height
            newButton.frame.size.width = newButton.intrinsicContentSize.width + tagPadding
            newButton.frame.size.height = tagHeight

            // add it to the scroll view
            containerView.addSubview(newButton)

            // append it to tagButtons array
            tagButtons.append(newButton)

        }

    }

    private func displayTagButtons() {

        let containerWidth = containerView.frame.size.width

        var currentOriginX: CGFloat = 0
        var currentOriginY: CGFloat = 0

        // for each button in the array
        tagButtons.forEach { button in

            // if current X + button width will be greater than container view width
            //  "move to next row"
            if currentOriginX + button.frame.width > containerWidth {
                currentOriginX = 0
                currentOriginY += tagHeight + tagSpacingY
            }

            // set the btn frame origin
            button.frame.origin.x = currentOriginX
            button.frame.origin.y = currentOriginY

            // increment current X by btn width + spacing
            currentOriginX += button.frame.width + tagSpacingX

        }

        // update container view height
        containerHeightConstraint.constant = currentOriginY + tagHeight

    }


}
