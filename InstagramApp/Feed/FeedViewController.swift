//
//  FeedViewController.swift
//  InstagramApp
//
//  Created by vasiario on 24.07.2023.
//

import SnapKit
import UIKit

final class FeedViewController: UIViewController {
  //  MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    initialize()
  }
}

//MARK: - Private properties
private let localTableView = UITableView()
private var items: [FeedItemType] = [
  .stories([
    FeedStoriesItemCellInfo(image: UIImage(named: "monkey")!, username: "Me",
                            isAddButtonVisible: true, isNewStrory: false),
    FeedStoriesItemCellInfo(image: UIImage(named: "monkey")!, username: "Burry",
                            isAddButtonVisible: false, isNewStrory: true),
    FeedStoriesItemCellInfo(image: UIImage(named: "monkey")!, username: "Minki",
                            isAddButtonVisible: false, isNewStrory: true),
    FeedStoriesItemCellInfo(image: UIImage(named: "monkey")!, username: "Dinki",
                            isAddButtonVisible: false, isNewStrory: true),
    FeedStoriesItemCellInfo(image: UIImage(named: "monkey")!, username: "Masha",
                            isAddButtonVisible: false, isNewStrory: false),
    FeedStoriesItemCellInfo(image: UIImage(named: "monkey")!, username: "Gena",
                            isAddButtonVisible: false, isNewStrory: false),
    FeedStoriesItemCellInfo(image: UIImage(named: "monkey")!, username: "Vika",
                            isAddButtonVisible: false, isNewStrory: false),
    FeedStoriesItemCellInfo(image: UIImage(named: "monkey")!, username: "Sergey",
                            isAddButtonVisible: false, isNewStrory: false)
  ])
]

//MARK: - Private methods
private extension FeedViewController {
  func initialize() {
    view.backgroundColor = .white
    navigationController?.navigationBar.tintColor = .black
    navigationItem.leftBarButtonItems = makeLeftBarButtonItems()
    navigationItem.rightBarButtonItems = makeRightBarButtonItems()
    localTableView.dataSource = self
    localTableView.separatorColor = .clear
    localTableView.register(FeedStoriesSetCell.self, forCellReuseIdentifier: String(describing: FeedStoriesSetCell.self))
    localTableView.register(FeedPostCell.self, forCellReuseIdentifier: String(describing: FeedPostCell.self))
    view.addSubview(localTableView)
    localTableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  func makeLeftBarButtonItems() -> [UIBarButtonItem] {
    let logoBarButtonItem = UIBarButtonItem(customView: LogoView())
    let dropDownButtomItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "chevron.down"), target: self, action: nil, menu: makeDropDownMenu())
    return [logoBarButtonItem, dropDownButtomItem]
  }

  func makeRightBarButtonItems() -> [UIBarButtonItem] {
    let addBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "paperplane.fill"), style: .plain, target: self, action: #selector(didTapPlusButton))
    let directBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(didTapDirectButton))
    return [addBarButtonItem, directBarButtonItem]
  }

  @objc func didTapPlusButton() {
    print("pressed didTapPlusButton")
  }

  @objc func didTapDirectButton() {
    print("pressed didTapDirectButton")
  }

  func makeDropDownMenu() -> UIMenu {
    let subItem = UIAction(title: "Подписки", image: UIImage(systemName: "person.2")) { _ in
      print("Subs")
    }

    let favsItem = UIAction(title: "Избранное", image: UIImage(systemName: "star")) { _ in
      print("Favourite")
    }
    return UIMenu(children: [subItem, favsItem])
  }
}

//MARK: - UITableViewDataSource
extension FeedViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = items[indexPath.row]
    switch item {
    case .stories(let info):
      let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeedStoriesSetCell.self), for: indexPath) as! FeedStoriesSetCell
      cell.configure(with: info)
      return cell
    case .post(let post):
      let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeedPostCell.self), for: indexPath) as! FeedPostCell
      cell.configure(with: post)
      return cell
    }
  }
}
