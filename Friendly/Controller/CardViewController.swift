//
//  CardViewController.swift
//  Friendly
//
//  Created by Dmytro Lyshtva on 19.09.2023.
//

import UIKit

class CardViewController: UIViewController {

    // MARK: - Property
    
    var viewModeldata = [
        CardsDataModel(text: "Як ви ставитеся до людей, які намагаються 'продати' себе з найкращого боку, створюючи специфічне перше враження?", categoryName: "Перше враження"),
        CardsDataModel(text: "Чи можна довіряти першому враженню і наскільки воно важливе в рішеннях, які ми приймаємо?", categoryName: "Перше враження"),
        CardsDataModel(text: "Розкажіть про ситуацію, коли ваше перше враження було дуже відмінним від реальності.", categoryName: "Перше враження")
    ]
    
    var stackContainer: StackViewContainer!
    
    // MARK: - Init
    
    override func loadView() {
        
        view = UIView()
        view.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        stackContainer = StackViewContainer()
        view.addSubview(stackContainer)
        configureStackContainer()
        stackContainer.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stackContainer.dataSource = self
    }
    
    func configureStackContainer() {
        stackContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackContainer.widthAnchor.constraint(equalToConstant: 300).isActive = true
        stackContainer.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }
}

// MARK: - SwipeCardsDataSource

extension CardViewController: SwipeCardsDataSource {
    func numbersOfCardsToShow() -> Int {
        viewModeldata.count
    }
    
    func card(at index: Int) -> SwipeCardView {
        let card = SwipeCardView()
        card.dataSource = viewModeldata[index]
        return
    }
    
    func emptyView() -> UIView? {
        return nil
    }
}
