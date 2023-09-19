//
//  SwipeCardsDataSource.swift
//  Friendly
//
//  Created by Dmytro Lyshtva on 19.09.2023.
//

import UIKit

protocol SwipeCardsDataSource {
    func numbersOfCardsToShow() -> Int
    func card(at index: Int) -> SwipeCardView
    func emptyView() -> UIView?
}

protocol SwipeCardsDelegate {
    func swipeDidEnd(on view: SwipeCardView)
}
