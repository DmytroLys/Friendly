//
//  JsonDecoder.swift
//  Friendly
//
//  Created by Dmytro Lyshtva on 18.09.2023.
//

import Foundation
import CoreData

struct JsonDecoder {
    
    func preloadData(context: NSManagedObjectContext) {
            
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            let categories = try context.fetch(fetchRequest)
            guard categories.isEmpty else {
                // Data already exists, no need to preload again
                return
            }
        } catch let error {
            print("Failed to fetch data: \(error)")
            // You might decide to return here or allow to attempt to preload data
             return
        }
            
        guard let url = Bundle.main.url(forResource: "PreloadData", withExtension: "json") else { return }
        
        do {
            // Load and decode the JSON data
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            
            let jsonCategories = try decoder.decode([CategoryJSON].self, from: data)
            
            for jsonCategory in jsonCategories {
                // Create CoreData Category object
                let category = Category(context: context)
                category.categoryName = jsonCategory.categoryName
                
                // Create CoreData Question objects
                for questionText in jsonCategory.questions {
                    let question = Question(context: context)
                    question.text = questionText
                    question.category = category
                }
            }
            
            // Save the context to persist the data
            try context.save()
            
        } catch let error {
            print("Failed to preload data: \(error)")
        }
    }

    struct CategoryJSON: Codable {
        let categoryName: String
        let questions: [String]
    }
    
}
