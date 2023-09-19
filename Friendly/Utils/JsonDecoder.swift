//
//  JsonDecoder.swift
//  Friendly
//
//  Created by Dmytro Lyshtva on 18.09.2023.
//

import Foundation
import CoreData

struct JsonDecoder {
    
   static func preloadData(context: NSManagedObjectContext) {
            
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
    
  static  func fetchData(context: NSManagedObjectContext) {
           // Create a fetch request for the Category entity
           let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
           
           do {
               // Execute the fetch request to get the array of Category objects
               let categories = try context.fetch(fetchRequest)
               
               // Loop over the Category objects and print each one to the console
               for category in categories {
                   print("Category Name: \(category.categoryName ?? "")")
                   
                   // Get the questions related to the current category
                   if let questions = category.questions?.array as? [Question] {
                       for question in questions {
                           print("    Question: \(question.text ?? "")")
                       }
                   }
               }
           } catch let error {
               // Print any errors that occur during the fetch to the console
               print("Could not fetch data: \(error.localizedDescription)")
           }
       }

  private  struct CategoryJSON: Codable {
        let categoryName: String
        let questions: [String]
    }
    
}
