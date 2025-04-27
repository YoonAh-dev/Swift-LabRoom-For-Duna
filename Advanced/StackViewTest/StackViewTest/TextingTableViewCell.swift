//
//  TextingTableViewCell.swift
//  StackViewTest
//
//  Created by SHIN YOON AH on 4/27/25.
//

import UIKit
import SnapKit
import SDWebImage

final class TextingTableViewCell: UITableViewCell {
    
    let labelContainer = LabelWithBadgesView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let container = UIStackView()
        container.axis = .horizontal
        container.spacing = 10
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        
        contentView.addSubview(container)
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        let view1 = UIView()
        view1.backgroundColor = .red
        view1.snp.makeConstraints {
            $0.width.equalTo(30)
        }
        let view2 = UIView()
        view2.backgroundColor = .blue
        view2.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        let view3 = UIView()
        view3.backgroundColor = .yellow
        view3.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        container.addArrangedSubview(view1)
        container.addArrangedSubview(labelContainer)
        container.addArrangedSubview(view2)
        container.addArrangedSubview(view3)
    }
    
    public func configure() {
        labelContainer.configureUI()
    }
}

final class LabelWithBadgesView: UIView {
    let gifBadge: SDAnimatedImageView = {
        let view = SDAnimatedImageView()
        view.image = SDAnimatedImage(named: "fire.gif")
        view.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        return view
    }()
    let badgeView1: UIView = {
        let view = UIView()
        view.backgroundColor = .magenta
        view.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        return view
    }()
    let badgeView2: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        return view
    }()
    let badgeView3: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        return view
    }()
    let badgeView4: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(resource: .appleIcon)
        view.frame = CGRect(x: 0, y: 0, width: 32, height: 14)
        return view
    }()
    let badgeView5: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        return view
    }()
    lazy var badges: [UIView] = [gifBadge, badgeView1, badgeView2, badgeView3, badgeView4, badgeView5, badgeView5, badgeView5, badgeView5]
    
    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.backgroundColor = .green
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = UIFont.systemFont(ofSize: 16)
        addSubview(label)
        label.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    func configureUI() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0  // lineSpacing은 조절할 필요 없으면 0으로 설정
        paragraphStyle.minimumLineHeight = 14  // 최소 lineHeight
        paragraphStyle.maximumLineHeight = 14
        paragraphStyle.lineBreakMode = .byTruncatingTail
        let fullText = NSMutableAttributedString(string: "요요요요요요요요")
        let textFont = UIFont.systemFont(ofSize: 16) // 텍스트의 폰트 크기
        let attributes: [NSAttributedString.Key: Any] = [
            .font: textFont,
            .paragraphStyle: paragraphStyle
        ]
        
        // Badge 이미지를 NSTextAttachment로 변환
        for badge in badges {
            let renderer = UIGraphicsImageRenderer(size: badge.bounds.size)
            let badgeImage = renderer.image { ctx in
                badge.layer.render(in: ctx.cgContext)
            }

            let attachment = NSTextAttachment()
            attachment.image = badgeImage
            attachment.bounds = CGRect(x: 0, y: -4, width: attachment.image!.size.width, height: 14)

            let badgeAttrString = NSAttributedString(attachment: attachment)
            fullText.append(badgeAttrString)
            fullText.append(NSAttributedString(string: " ")) // 뱃지 사이에 약간의 띄어쓰기
            fullText.addAttributes(attributes, range: NSRange(location: 0, length: fullText.length))
        }

        label.attributedText = fullText
    }
}

final class LabelWithBadgesView2: UIView {
    let gifBadge: SDAnimatedImageView = {
        let view = SDAnimatedImageView()
        view.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        return view
    }()
    let badgeView1: UIView = {
        let view = UIView()
        view.backgroundColor = .magenta
        view.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        return view
    }()
    let badgeView2: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        return view
    }()
    let badgeView3: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        return view
    }()
    let badgeView4: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(resource: .appleIcon)
        view.frame = CGRect(x: 0, y: 0, width: 32, height: 14)
        return view
    }()
    let badgeView5: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        return view
    }()
    lazy var badges: [UIView] = [gifBadge, badgeView1, badgeView2, badgeView3, badgeView4, badgeView5]
    
    private var singleLineHeight: CGFloat {
        // 폰트에 따라 한 줄 높이 계산
        return UIFont.systemFont(ofSize: 16).lineHeight
    }
    
    private let textView = UITextView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let fittingSize = textView.sizeThatFits(CGSize(width: textView.bounds.width, height: CGFloat.greatestFiniteMagnitude))
        let visibleHeight = min(fittingSize.height, singleLineHeight * 2)
        let verticalInset = max(0, (textView.bounds.height - visibleHeight) / 2)
        textView.textContainerInset.top = verticalInset
        textView.textContainerInset.bottom = verticalInset
    }

    private func setup() {
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = false
        textView.backgroundColor = .green
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        addSubview(textView)
        
        textView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.lessThanOrEqualTo(singleLineHeight * 2) // ✨ 2줄까지만!!
        }
        
        textView.textContainer.lineBreakMode = .byTruncatingTail
    }

    func configureUI() {
        // Badge를 넣고 싶은 곳에 U+FFFC (object replacement character)를 삽입
        let fullText = NSMutableAttributedString(string: "안녕해요반가워요", attributes: [
            .font: UIFont.systemFont(ofSize: 16)
        ])

        for (index, badge) in badges.enumerated() {
            if index == 0 {
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 16),
                    NSAttributedString.Key("isGifBadge"): true // ✅ 직접 표시!!
                ]
                let attachmentString = NSAttributedString(string: " ", attributes: attributes)
                fullText.append(attachmentString)
            }
            let renderer = UIGraphicsImageRenderer(size: badge.bounds.size)
            let badgeImage = renderer.image { ctx in
                badge.layer.render(in: ctx.cgContext)
            }

            let attachment = NSTextAttachment()
            attachment.image = badgeImage
            attachment.bounds = CGRect(x: 0, y: -1, width: badge.frame.width, height: 14) // y: -3 살짝 올려서 baseline 맞추기

            let badgeAttrString = NSAttributedString(attachment: attachment)
            fullText.append(badgeAttrString)
            if index == 0 {
                continue
            }
            fullText.append(NSAttributedString(string: " ")) // 뱃지 사이에 약간의 띄어쓰기
        }

        textView.attributedText = fullText

        DispatchQueue.main.async {
            self.addBadges()
        }
    }

    private func addBadges() {
        guard let attributedText = textView.attributedText else { return }
        
        let layoutManager = textView.layoutManager
        let textContainer = textView.textContainer
        let fullRange = NSRange(location: 0, length: attributedText.length)

        attributedText.enumerateAttributes(in: fullRange, options: []) { attributes, range, _ in
            if let isGifBadge = attributes[NSAttributedString.Key("isGifBadge")] as? Bool, isGifBadge {
                let glyphRange = layoutManager.glyphRange(forCharacterRange: range, actualCharacterRange: nil)
                let glyphRect = layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)

                let badgeView = SDAnimatedImageView()
                badgeView.image = SDAnimatedImage(named: "fire.gif")
                badgeView.frame = CGRect(
                    x: glyphRect.origin.x,
                    y: glyphRect.origin.y + 2 + textView.textContainerInset.top,
                    width: 16,
                    height: 16
                )

                self.textView.addSubview(badgeView)
            }
        }
    }
}

#Preview {
    TextingTableViewCell()
}
