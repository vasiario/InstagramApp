//
//  FeedPostCell.swift
//  InstagramApp
//
//  Created by vasiario on 11.08.2023.
//

import SnapKit
import UIKit

class FeedPostCell: UITableViewCell {
  //  MARK: - Public
  func configure(with info: FeedPostItemInfo) {
    userImageView.image = info.userImage
    usernameLabel.text = info.username
    subtitleLabel.text = info.postSubtitle
    postImageView.image = info.postImage
    likesLabel.text = "\(info.numberOfLikes) Likes"
    if let comment = info.comment {
      configureCommentLabel(with: comment)
    }
  }
  //  MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    initialize()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  //MARK: - Private constants
  private enum UIConstants {
    static let userImageSize: CGFloat = 30
    static let contentInset: CGFloat = 12
    static let userImageTopInset: CGFloat = 6
    static let usernameLabelFontSize: CGFloat = 14
    static let subtitleLabelFontSize: CGFloat = 12
    static let usernameStackToProfileImageOffSet: CGFloat = 12
    static let postImageToUserImageOffSet: CGFloat = 6
    static let actionStackHeight: CGFloat = 24
    static let actionStackPostImageOffSet: CGFloat = 6
    static let actionsStackSpacing: CGFloat = 12
    static let actionsStackToLikesLabelOffSet: CGFloat = 12
    static let likesLabelFontSize: CGFloat = 14
    static let commentLabelFontSize: CGFloat = 14
    static let commentToLikesOffSet: CGFloat = 12

  }

  //  MARK: - Private properties
  private let userImageView: UIImageView = {
    let view = UIImageView()
    view.layer.cornerRadius = UIConstants.userImageSize / 2
    view.clipsToBounds = true
    return view
  }()

  private let usernameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: UIConstants.usernameLabelFontSize, weight: .bold)
    return label
  }()

  private let subtitleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: UIConstants.subtitleLabelFontSize)
    return label
  }()

  private let optionsButton: UIButton = {
    let button = UIButton(type: .system)
    button.tintColor = .black
    button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
    return button
  }()

  private let postImageView: UIImageView = {
    let view = UIImageView()
    return view
  }()

  private let likeButton: UIButton = {
    let button = UIButton(type: .system)
    button.tintColor = .black
    button.setImage(UIImage(systemName: "heart"), for: .normal)
    return button
  }()

  private let commentButton: UIButton = {
    let button = UIButton(type: .system)
    button.tintColor = .black
    button.setImage(UIImage(systemName: "bubble.right"), for: .normal)
    return button
  }()

  private let shareButton: UIButton = {
    let button = UIButton(type: .system)
    button.tintColor = .black
    button.setImage(UIImage(systemName: "paperplane"), for: .normal)
    return button
  }()

  private let likesLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: UIConstants.subtitleLabelFontSize, weight: .bold)
    return label
  }()

  private let commentLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: UIConstants.commentLabelFontSize)
    return label
  }()
}

//MARK: - Private methods
private extension FeedPostCell {
  func initialize() {
    selectionStyle = .none
    contentView.addSubview(userImageView)
    userImageView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(UIConstants.contentInset)
      make.top.equalToSuperview().inset(UIConstants.likesLabelFontSize)
      make.size
        .equalTo(UIConstants.userImageSize)
    }

    let usernameStack = UIStackView()
    usernameStack.axis = .vertical
    usernameStack.addArrangedSubview(usernameLabel)
    usernameStack.addArrangedSubview(subtitleLabel)

    contentView.addSubview(usernameStack)
    usernameStack.snp.makeConstraints { make in
      make.centerY.equalTo(userImageView)
      make.leading.equalTo(userImageView.snp.trailing).offset(UIConstants.usernameStackToProfileImageOffSet)
    }

    contentView.addSubview(optionsButton)
    optionsButton.snp.makeConstraints { make in
      make.top.trailing.equalToSuperview().inset(UIConstants.contentInset)
    }

    contentView.addSubview(postImageView)
    postImageView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(userImageView.snp.bottom).offset(UIConstants.postImageToUserImageOffSet)
      make.height.equalTo(contentView.snp.width)
    }

    let actionStack = UIStackView()
    actionStack.axis = .horizontal
    actionStack.addArrangedSubview(likeButton)
    actionStack.addArrangedSubview(commentButton)
    actionStack.addArrangedSubview(shareButton)
    actionStack.spacing = UIConstants.actionsStackSpacing
    contentView.addSubview(actionStack)
    actionStack.snp.makeConstraints { make in
      make.height.equalTo(UIConstants.actionStackHeight)
      make.leading.equalToSuperview().inset(UIConstants.contentInset)
      make.top.equalTo(postImageView.snp.bottom).offset(UIConstants.actionStackPostImageOffSet)
    }

    contentView.addSubview(likesLabel)
    likesLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(UIConstants.contentInset)
      make.top.equalTo(actionStack.snp.bottom).offset(UIConstants.actionsStackToLikesLabelOffSet)
    }

    contentView.addSubview(commentLabel)
    commentLabel.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
      make.top.equalTo(likesLabel.snp.bottom).offset(UIConstants.commentToLikesOffSet)
      make.bottom.equalToSuperview().inset(UIConstants.contentInset)
    }


  }
  func configureCommentLabel(with comment: CommentShortInfo) {
    let string = comment.username + " " + comment.commentText
let attributedString = NSMutableAttributedString(string: string)
    let range = NSRange(location: .zero, length: comment.username.count)
    attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: UIConstants.commentLabelFontSize), range: range)
    commentLabel.attributedText = attributedString
  }
}
