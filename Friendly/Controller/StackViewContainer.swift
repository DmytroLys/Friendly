//
//  StackViewContainer.swift
//  Friendly
//
//  Created by Dmytro Lyshtva on 19.09.2023.
//

import UIKit

class StackViewContainer: UIStackView,SwipeCardsDelegate {
    
    // MARK: - Properties
    
    var numberOfCardsToShow = 0
    var cardsToBeVisible = 3
    var cardViews : [SwipeCardView] = []
    var remainingCards: Int = 0
    
    let horizontalInset: CGFloat = 10.0
    let verticalInset: CGFloat = 10.0
    
    var visibleCards: [SwipeCardView] {
        return subviews as? [SwipeCardView] ?? []
    }
    
    var dataSource: SwipeCardsDataSource? {
        didSet {
            reloadData()
        }
    }
    
    
    func reloadData() {
        guard let dataSource = dataSource else { return }
        setNeedsLayout()
        layoutIfNeeded()
        numberOfCardsToShow = dataSource.numbersOfCardsToShow()
        remainingCards = numberOfCardsToShow
        
        for i in 0..<min(numberOfCardsToShow,cardsToBeVisible) {
            addCardView(cardView: dataSource.card(at: i), atIndex: i )
        }
        
    }
    
    private func addCardView(cardView: SwipeCardView,atIndex index: Int) {
        cardView.delegate = self
        addCardFrame(index: index,cardView: cardView)
        cardViews.append(cardView)
        insertSubview(cardView, at: 0)
        remainingCards -= 1
    }
    
    private func addCardFrame(index: Int, cardView: SwipeCardView) {
        var cardViewFrame = bounds
        let horizontalInset = (CGFloat(index) * self.horizontalInset)
        let verticalInset = (CGFloat(index) * self.verticalInset)
        
        cardViewFrame.size.width -= 2 * horizontalInset
        cardViewFrame.origin.x += horizontalInset
        cardViewFrame.origin.y += verticalInset
        
        cardView.frame = cardViewFrame
        
    }
    
    func swipeDidEnd(on view: SwipeCardView) {
        <#code#>
    }
}
