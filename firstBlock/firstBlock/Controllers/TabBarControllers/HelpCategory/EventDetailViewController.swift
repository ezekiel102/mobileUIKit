//
//  EventDetailViewController.swift
//  firstBlock
//
//  Created by Рустем on 24.03.2024.
//

import UIKit
import SnapKit

class EventDetailViewController: UIViewController {

    var event: Event!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.tabBarController?.tabBar.isHidden = true
        navigationController?.setupNavigationBar()
        navigationItem.title = event.title
        addShareButton()
        addBackButton()
        loadCustomView()
    }

    private var viewWidth: CGFloat { self.view.frame.width }
    private var viewHeight: CGFloat { self.view.frame.height }
    private var heightNeedForTextView: CGFloat {
        let textViewForHeight = UITextView(frame: CGRect(x: 0, y: 0,
                                                         width: self.viewWidth - 40,
                                                         height: CGFloat.greatestFiniteMagnitude))
        textViewForHeight.text = self.event.description
        textViewForHeight.font = .textStyle7
        textViewForHeight.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textViewForHeight.textContainer.lineFragmentPadding = 0
        textViewForHeight.sizeToFit()
        return textViewForHeight.frame.height
    }

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        return scrollView
    }()

    private let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        return contentView
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = self.event.title
        titleLabel.font = .textStyle3
        titleLabel.textColor = .blueGrey
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 3
        return titleLabel
    }()

    private lazy var calendarStackView: UIStackView = {
        let calendarStackView = UIStackView()

        calendarStackView.spacing = 10
        calendarStackView.axis = .horizontal
        calendarStackView.alignment = .center
        calendarStackView.distribution = .equalCentering

        let calendarImage = UIImageView()
        calendarImage.image = UIImage(named: "iconCal")
        calendarImage.contentMode = .scaleAspectFit

        let calendarText = UILabel()
        calendarText.text = self.event.dateIntervalString
        calendarText.font = .textStyle18
        calendarText.textColor = .grey

        calendarStackView.addArrangedSubview(calendarImage)
        calendarStackView.addArrangedSubview(calendarText)

        return calendarStackView
    }()

    private lazy var ownerLabel: UILabel = {
        let ownerLabel = UILabel()
        ownerLabel.text = self.event.owner
        ownerLabel.font = .textStyle12
        ownerLabel.textColor = .charcoalGrey
        return ownerLabel
    }()

    private lazy var navStackView: UIStackView = {
        let hsv = UIStackView()

        hsv.spacing = 10
        hsv.axis = .horizontal
        hsv.alignment = .top
        hsv.distribution = .equalSpacing

        let iconNavImage = UIImageView()
        iconNavImage.image = UIImage(named: "iconNav")
        iconNavImage.contentMode = .scaleAspectFit

        let locationLabel = UILabel()
        locationLabel.text = self.event.location
        locationLabel.font = .textStyle7
        locationLabel.textColor = .charcoalGrey
        locationLabel.numberOfLines = 3

        hsv.addArrangedSubview(iconNavImage)
        hsv.addArrangedSubview(locationLabel)

        return hsv
    }()

    func phoneLabel(text: String) -> UILabel {
        let contactLabel = UILabel()
        contactLabel.text = text
        contactLabel.font = .textStyle7
        contactLabel.textColor = .charcoalGrey
        return contactLabel
    }

    private lazy var contactStackView: UIStackView = {
        let vsv = UIStackView()
        vsv.spacing = 2
        vsv.axis = .vertical
        vsv.alignment = .leading
        vsv.distribution = .fill

        for phone in self.event.contacts {
            vsv.addArrangedSubview(phoneLabel(text: phone))
        }

        let hsv = UIStackView()
        hsv.spacing = 10
        hsv.axis = .horizontal
        hsv.alignment = .top
        hsv.distribution = .fill

        let iconPhoneImage = UIImageView()
        iconPhoneImage.image = UIImage(named: "iconPhone")
        iconPhoneImage.contentMode = .scaleAspectFit

        hsv.addArrangedSubview(iconPhoneImage)
        hsv.addArrangedSubview(vsv)

        return hsv
    }()

    private lazy var mailLabel: UITextView = {
        let mailLabel = UITextView()
        let string = "Напишите нам"
        let attribute: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.leaf,
            .font: UIFont.textStyle5,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .link: "https://www.ya.ru"]
        mailLabel.attributedText = NSAttributedString(string: string, attributes: attribute)
        mailLabel.isUserInteractionEnabled = true
        mailLabel.isSelectable = true
        mailLabel.isEditable = false
        mailLabel.isScrollEnabled = false
        mailLabel.textContainer.lineFragmentPadding = 0
        mailLabel.textContainerInset = .zero
        mailLabel.sizeToFit()
        return mailLabel
    }()

    private lazy var mailStackView: UIStackView = {
        let textsv = UIStackView()
        textsv.spacing = 1
        textsv.axis = .horizontal
        textsv.alignment = .center
        textsv.distribution = .fill

        let questionLabel = UILabel()
        questionLabel.font = .textStyle7
        questionLabel.text = "У вас есть вопросы?"
        questionLabel.textColor = .charcoalGrey

        textsv.addArrangedSubview(questionLabel)
        textsv.addArrangedSubview(mailLabel)

        mailLabel.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(20)
        }

        let hsv = UIStackView()

        hsv.spacing = 10
        hsv.axis = .horizontal
        hsv.alignment = .center
        hsv.distribution = .fill

        let mailImage = UIImageView()
        mailImage.image = UIImage(named: "mail")
        mailImage.contentMode = .scaleAspectFit

        hsv.addArrangedSubview(mailImage)
        hsv.addArrangedSubview(textsv)

        return hsv
    }()

    private lazy var ownerTextStack: UIStackView = {
        let vsv = UIStackView()

        vsv.spacing = 16
        vsv.axis = .vertical
        vsv.alignment = .leading
        vsv.distribution = .fill

        vsv.addArrangedSubview(navStackView)
        vsv.addArrangedSubview(contactStackView)
        vsv.addArrangedSubview(mailStackView)

        return vsv
    }()

    private lazy var mainImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: self.event.mainImage)
        image.contentMode = .scaleAspectFit
        return image
    }()

    private lazy var imageStackView: UIStackView = {
        let vsv = UIStackView()
        vsv.spacing = 10
        vsv.axis = .vertical
        vsv.alignment = .leading
        vsv.distribution = .fill

        let secondary1ImageView = UIImageView()
        secondary1ImageView.image = UIImage(named: self.event.secondary1Image)
        secondary1ImageView.contentMode = .scaleAspectFit

        let secondary2ImageView = UIImageView()
        secondary2ImageView.image = UIImage(named: self.event.secondary2Image)
        secondary2ImageView.contentMode = .scaleAspectFit

        vsv.addArrangedSubview(secondary1ImageView)
        vsv.addArrangedSubview(secondary2ImageView)

        let hsv = UIStackView()
        hsv.spacing = 10
        hsv.axis = .horizontal
        hsv.alignment = .top
        hsv.distribution = .fill

        let mainImageView = UIImageView()
        mainImageView.image = UIImage(named: self.event.mainImage)
        mainImageView.contentMode = .scaleAspectFit

        hsv.addArrangedSubview(mainImageView)
        hsv.addArrangedSubview(vsv)

        return hsv
    }()

    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        let string = self.event.description
        let attribute: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.charcoalGrey,
                .font: UIFont.textStyle7]
        textView.attributedText = NSAttributedString(string: string, attributes: attribute)
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        textView.isSelectable = true
        textView.isEditable = false
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.textContainer.lineFragmentPadding = 0
        textView.sizeToFit()
        return textView
    }()

    private lazy var linkLabel: UITextView = {
        let linkLabel = UITextView()
        let string = "Перейти на сайт организации"
        let attribute: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.leaf,
            .font: UIFont.textStyle5,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .link: "https://www.ya.ru"]
        linkLabel.attributedText = NSAttributedString(string: string, attributes: attribute)
        linkLabel.isUserInteractionEnabled = true
        linkLabel.isSelectable = true
        linkLabel.isEditable = false
        linkLabel.textAlignment = .left
        linkLabel.textContainerInset = UIEdgeInsets.zero
        linkLabel.textContainer.lineFragmentPadding = 0
        linkLabel.sizeToFit()
        return linkLabel
    }()

    private lazy var avatarsView: UIView = {
        let avatarsView = UIView()
        avatarsView.backgroundColor = .lightGrey
        avatarsView.layer.borderWidth = 1
        avatarsView.layer.borderColor = UIColor.whiteTwo.cgColor

        let avatarsStack = UIStackView()
        avatarsStack.spacing = -4
        avatarsStack.axis = .horizontal
        avatarsStack.distribution = .fill
        avatarsStack.alignment = .center

        func avatarView(avatar: String) -> UIImageView {
            let image = UIImageView()
            image.image = UIImage(named: avatar)
            image.contentMode = .scaleAspectFit
            return image
        }

        func count(countReminder: Int) -> UILabel {
            let count = UILabel()
            count.text = "+\(countReminder)"
            count.font = .textStyle20
            count.textColor = .grey
            return count
        }

        if self.event.participants.count > 5 {
            let avatars = self.event.participants.reversed()[0...4]
            let countReminder = count(countReminder: self.event.participants.count - 5)
            for avatar in avatars {
                avatarsStack.addArrangedSubview(avatarView(avatar: avatar.photo))
            }

            avatarsView.addSubview(avatarsStack)
            avatarsView.addSubview(countReminder)

            countReminder.snp.makeConstraints { make in
                make.leading.equalTo(avatarsStack.snp.trailing).offset(10)
                make.centerY.equalToSuperview()
            }
        } else {
            for avatar in self.event.participants {
                avatarsStack.addArrangedSubview(avatarView(avatar: avatar.photo))
            }
            avatarsView.addSubview(avatarsStack)
        }
        avatarsStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        return avatarsView
    }()

    func addTabBarButton(image: String, title: String) -> UIButton {
        let button = UIButton()

        button.backgroundColor = .white

        let barButtonImage = UIImageView()
        barButtonImage.image = UIImage(named: image)
        barButtonImage.contentMode = .scaleAspectFit

        let barButtonlabel = UILabel()
        barButtonlabel.text = title
        barButtonlabel.font = .textStyle16
        barButtonlabel.textColor = .warmGrey
        barButtonlabel.numberOfLines = 2
        barButtonlabel.textAlignment = .center

        button.addSubview(barButtonImage)
        button.addSubview(barButtonlabel)

        button.snp.makeConstraints { make in
            make.width.equalTo((viewWidth - 3) / 4)
            make.height.equalTo(70)
        }

        barButtonImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(button.snp.top).inset(25)
        }

        barButtonlabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(6)
        }

        button.addTarget(self, action: #selector(tabbarbuttonpressed), for: .touchUpInside)
        return button
    }

    @objc func tabbarbuttonpressed() {
        print("wow")
    }

    private lazy var actionView: UIStackView = {
        let actionView = UIStackView()
        actionView.backgroundColor = .white
        actionView.axis = .horizontal
        actionView.spacing = 0
        actionView.distribution = .equalCentering
        actionView.alignment = .center

        let tabBarButtonsItems = [ ("shirt", "Помощь\nвещами"), ("hands", "Стать\nволотером"),
                                   ("tools", "Проф.\nпомощь"), ("coins", "Помочь\nденьгами")]

        for item in tabBarButtonsItems {

            actionView.addArrangedSubview(addTabBarButton(image: item.0, title: item.1))

            if item.0 != tabBarButtonsItems.last!.0 {
                lazy var hSeparator: UIView = {
                    let line = UIView()
                    line.backgroundColor = .gray
                    line.layer.opacity = 0.45
                    return line
                }()

                hSeparator.snp.makeConstraints { make in
                    make.width.equalTo(1)
                    make.height.equalTo(35)
                }

                actionView.addArrangedSubview(hSeparator)
            }
        }

        return actionView
    }()
}

private extension EventDetailViewController {

    func loadCustomView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20))
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(1.5).priority(250)
        }

        mainTextLabels()
        imageStack()
        descriptionTextLabels()
        footer()
    }

    func mainTextLabels() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(calendarStackView)
        contentView.addSubview(ownerLabel)
        contentView.addSubview(ownerTextStack)

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }

        calendarStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(17)
            make.leading.equalToSuperview()
        }

        ownerLabel.snp.makeConstraints { make in
            make.top.equalTo(calendarStackView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }

        ownerTextStack.snp.makeConstraints { make in
            make.top.equalTo(ownerLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
        }
    }

    func imageStack() {
        contentView.addSubview(imageStackView)

        imageStackView.snp.makeConstraints { make in
            make.top.equalTo(ownerTextStack.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
        }
    }

    func descriptionTextLabels() {
        contentView.addSubview(descriptionTextView)
        contentView.addSubview(linkLabel)

        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(imageStackView.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading)
            make.height.equalTo(heightNeedForTextView)
            make.width.equalTo(viewWidth - 40)
        }

        linkLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(16)
            make.leading.equalTo(contentView.snp.leading)
            make.height.equalTo(20)
            make.width.equalTo(viewWidth - 40)
        }
    }

    func footer() {
        view.addSubview(avatarsView)
        view.addSubview(actionView)

        avatarsView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(68)
            make.bottom.equalTo(actionView.snp.top)
        }

        actionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }
    }
}
