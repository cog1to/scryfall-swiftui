//
//  TagList.swift
//  Scryfall
//
//  Created by Alexander on 16.08.2021.
//

import Foundation
import UIKit
import SwiftUI

class TagList: UIView {

    // MARK: - Public

    var tags: [String] = [] {
        didSet {
            reloadViews()
        }
    }

    // MARK: - Private

    var tagViews: [UIButton] = []

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func reloadViews() {
        tagViews.forEach { $0.removeFromSuperview() }
        let font = Style.Fonts.uiSmall

        tagViews = tags.enumerated().map { (index, tag) in
            let tagView = HighlightedButton(frame: .zero)

            tagView.contentEdgeInsets = UIEdgeInsets(
                top: Dimensions.padding,
                left: Dimensions.padding,
                bottom: Dimensions.padding,
                right: Dimensions.padding
            )
            tagView.translatesAutoresizingMaskIntoConstraints = false
            tagView.titleLabel?.font = font
            tagView.setTitleColor(UIColor(named: "BrightText"), for: .normal)

            tagView.backgroundColor = UIColor(named: "Accent")
            tagView.highlightColor = UIColor(named: "AccentTint")            
            tagView.layer.cornerRadius = 2.0

            tagView.setTitle(tag.uppercased(), for: .normal)
            tagView.tag = index
            tagView.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

            return tagView
        }

        tagViews.forEach { self.addSubview($0) }

        invalidateIntrinsicContentSize()
        setNeedsLayout()
    }

    // MARK: - Action

    var onActionTapped: ((Int) -> ())?

    @objc private func buttonTapped(_ sender: UIButton) {
        onActionTapped?(sender.tag)
    }

    // MARK: - Layout

    /**
     * Content height cached value. We need this to properly incapsulate the
     * view into the SwiftUI hierarchy.
     *
     * The layout of custom views inside SwiftUI is really weird. You'd think it
     * would be based on auto-layout, and thus using `intrinsicContentSize` and
     * `systemLayoutSizeFitting()` methods and what-not. And you would be
     * partially right. It does use `intrinsicContentSize`, but it takes it at
     * face value: the view will be of it's intrinsic content size, disregarding
     * available width or height of the parent.
     *
     * Moreover, if you explicitly say to the view that it should, for example,
     * resist vertical compression, it will kind of do so: it will resize itself
     * and it's subviews correctly according to the available width. But the
     * parent view will still use it's `intrinsicContentSize` as both width and
     * height measurement, and your custom view will get laid out of bounds.
     *
     * So to make the view occupy parent's width and provide proper height value
     * it must calculate it's height manually, and then update intrinsic content
     * size according to the available width. Which is not what
     * `intrinsicContentSize` is supposed to be fucking used for! Whatever.
     *
     * P.S. https://fix.code-error.com/multiline-label-with-uiviewrepresentable/
    **/
    var contentHeight: CGFloat = .zero {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        // Occupy all of the available width, provide a height required to fit
        // all of the content.
        CGSize(width: UIView.noIntrinsicMetric, height: contentHeight)
    }

    override var frame: CGRect {
        didSet {
            // When the frame has changed, we need to recalculate a new height
            // based on available width.
            guard frame != oldValue else { return }
            contentHeight = height(forWidth: frame.width)
        }
    }

    private func height(forWidth width: CGFloat) -> CGFloat {
        var currentX: CGFloat = 0, currentY: CGFloat = 0
        var lastSize: CGSize = .zero

        for button in tagViews {
            lastSize = button.sizeThatFits(
                CGSize(
                    width: width,
                    height: CGFloat.greatestFiniteMagnitude
                )
            )

            if (currentX + lastSize.width) > width {
                currentY += lastSize.height + Dimensions.spacing
                currentX =  0
            }

            currentX += lastSize.width + Dimensions.spacing
        }

        return currentY + lastSize.height
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        var currentX: CGFloat = 0, currentY: CGFloat = 0
        var lastSize: CGSize = .zero

        for button in tagViews {
            lastSize = button.sizeThatFits(self.frame.size)
            if (currentX + lastSize.width) > self.frame.size.width {
                currentY += lastSize.height + Dimensions.spacing
                currentX =  0
            }

            button.frame = CGRect(
                origin: CGPoint(x: currentX, y: currentY),
                size: CGSize(width: lastSize.width, height: lastSize.height)
            )

            currentX += lastSize.width + Dimensions.spacing
        }

        setNeedsDisplay()
    }

    // MARK: - Dynamic size

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
            let font = Style.Fonts.uiSmall
            tagViews.forEach { $0.titleLabel?.font = font }
            contentHeight = height(forWidth: frame.width)
        }
    }

    // MARK: - Dimensions

    enum Dimensions {
        static let padding: CGFloat = 7.0
        static let spacing: CGFloat = 4.0
    }

    // MARK: - Custom button

    class HighlightedButton: UIButton {
        var highlightColor: UIColor?
        var originalColor: UIColor?

        override var isHighlighted: Bool {
            didSet {
                backgroundColor = isHighlighted ? highlightColor : originalColor
            }
        }

        override var backgroundColor: UIColor? {
            didSet {
                if originalColor == nil {
                    originalColor = backgroundColor
                }
            }
        }
    }
}

struct TagListWrapper: UIViewRepresentable {
    let tags: [String]

    func makeUIView(context: Context) -> TagList {
        let view = TagList()
        view.tags = tags
        view.translatesAutoresizingMaskIntoConstraints = false

        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.setContentHuggingPriority(.required, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .vertical)

        return view
    }

    func updateUIView(_ uiView: TagList, context: Context) {
        uiView.tags = tags
    }
}
