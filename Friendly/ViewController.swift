//
//  ViewController.swift
//  Friendly
//
//  Created by Dmytro Lyshtva on 18.09.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData() {
           // Create a fetch request for the Category entity
           let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
           
           do {
               // Execute the fetch request to get the array of Category objects
               let categories = try context.fetch(fetchRequest)
               
               // Loop over the Category objects and print each one to the console
               for category in categories {
                   print("Category Name: \(category.categoryName ?? "")")
                   print(categories.count)
                   
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


}

