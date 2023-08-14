//
//  FeedStoriesCellInfo.swift
//  InstagramApp
//
//  Created by vasiario on 27.07.2023.
//

import UIKit

struct FeedStoriesItemCellInfo {
  let image: UIImage
  let username: String
  let isAddButtonVisible: Bool
  let isNewStrory: Bool
}

typealias FeedStoriesCellInfo = [FeedStoriesItemCellInfo]
