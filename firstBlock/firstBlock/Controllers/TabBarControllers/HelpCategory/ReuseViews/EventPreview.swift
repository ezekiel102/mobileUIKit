//
//  EventPreview.swift
//  firstBlock
//
//  Created by Рустем on 21.03.2024.
//

import UIKit
import SnapKit

class EventPreview: UITableViewCell {

    static let identifier = "EventPreview"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(event: Event) {
        self.backLayerImage.contents = UIImage(named: event.previewImage)?.cgImage
        self.titleLabel.text = event.title
        self.previewDescriptionLabel.text = event.previewDescription
        self.calendarText.text = event.dateIntervalString
        loadCustomView()
    }

    private var viewWidth: CGFloat { self.frame.width }
    private var viewHeight: CGFloat { self.contentView.frame.height }

    private lazy var backRectangleLayer: CAShapeLayer = {
        let topRectangleLayer = CAShapeLayer()
        topRectangleLayer.path = UIBezierPath(roundedRect: CGRect(x: 0,
                                                                     y: 10,
                                                                     width: self.viewWidth,
                                                                     height: self.viewHeight - 10),
                                              cornerRadius: 5.0).cgPath
        topRectangleLayer.fillColor = UIColor.white.cgColor
        return topRectangleLayer
    }()

    private lazy var backLayerImage: CAShapeLayer = {
        let backLayerImage = CAShapeLayer()
        let width = viewWidth - 2 * 4
        backLayerImage.frame = CGRect(x: 4, y: 14, width: width, height: width / 351 * 231)
        backLayerImage.cornerRadius = 3.0
        backLayerImage.contentsGravity = .resizeAspect

        let gradient = CAGradientLayer()
        gradient.frame = backLayerImage.bounds
        gradient.type = .radial
        gradient.colors = [UIColor.clear.cgColor,
                           UIColor.clear.cgColor,
                           UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.2).cgColor,
                           UIColor.white.cgColor,
                           UIColor.white.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.25, y: 1)
        gradient.locations = [0, 0.7, 0.85, 1, 1.25]

        backLayerImage.addSublayer(gradient)

        return backLayerImage
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .textStyle
        titleLabel.textColor = .blueGrey
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        return titleLabel
    }()

    private lazy var heartLineImageView: UIImageView = {
        let heartLineImageView = UIImageView()
        heartLineImageView.image = UIImage(named: "heartinline")
        return heartLineImageView
    }()

    private lazy var previewDescriptionLabel: UILabel = {
        let previewDescriptionLabel = UILabel()
        previewDescriptionLabel.textColor = .darkSlateBlue
        previewDescriptionLabel.textAlignment = .center
        previewDescriptionLabel.numberOfLines = 3
        return previewDescriptionLabel
    }()

    private lazy var calendarImage: UIImageView = {
        let calendarImage = UIImageView()
        calendarImage.image = UIImage(named: "shape")
        calendarImage.contentMode = .scaleAspectFit
        return calendarImage
    }()

    private lazy var calendarText: UILabel = {
        let calendarText = UILabel()
        calendarText.font = .textStyle17
        calendarText.textColor = .white
        return calendarText
    }()

    private lazy var bottomRectangleLayer: CAShapeLayer = {
        let bottomRectangleLayer = CAShapeLayer()
        bottomRectangleLayer.path = UIBezierPath(roundedRect: CGRect(x: 0,
                                                                     y: self.viewHeight - 31,
                                                                     width: self.viewWidth,
                                                                     height: 31),
                                                 cornerRadius: 0).cgPath
        bottomRectangleLayer.fillColor = UIColor.leaf.cgColor
        return bottomRectangleLayer
    }()

    private lazy var bottomStackView: UIStackView = {
        let bottomStackView = UIStackView()

        bottomStackView.spacing = 10
        bottomStackView.axis = .horizontal
        bottomStackView.alignment = .center
        bottomStackView.distribution = .fill

        bottomStackView.addArrangedSubview(calendarImage)
        bottomStackView.addArrangedSubview(calendarText)

        return bottomStackView
    }()
}

private extension EventPreview {

    func loadCustomView() {
        backgroundColor = .clear
        selectionStyle = .none
        layer.cornerRadius = 5.0
        clipsToBounds = true

        layer.addSublayer(backRectangleLayer)
        backRectangleLayer.addSublayer(backLayerImage)
        backRectangleLayer.addSublayer(bottomRectangleLayer)

        addSubview(titleLabel)
        addSubview(heartLineImageView)
        addSubview(previewDescriptionLabel)
        addSubview(bottomStackView)

        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(46)
            make.bottom.equalTo(heartLineImageView.snp.top).offset(-8)
        }

        heartLineImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(123)
            make.bottom.equalTo(previewDescriptionLabel.snp.top).offset(-8)
        }

        previewDescriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(23)
            make.bottom.equalTo(bottomStackView.snp.top).offset(-16)
        }

        bottomStackView.snp.makeConstraints { make in
            make.height.equalTo(31)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
