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
        JsonDecoder.fetchData(context: context)
    }
}

