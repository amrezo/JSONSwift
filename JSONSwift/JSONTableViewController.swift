//
//  JSONTableViewController.swift
//  JSONSwift
//
//  Created by Amr Al-Refae on 3/10/18.
//  Copyright © 2018 Amr Al-Refae. All rights reserved.
//

import UIKit

class JSONTableViewController: UITableViewController {
    
    var todoList = [TodoItem]()
    
    struct TodoItem: Decodable {
        let userId: Int
        let id: Int
        let title: String
        let completed: Bool
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        decodeJson()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        
        let todoItem = todoList[indexPath.row]
        
        cell.textLabel?.text = todoItem.title

        return cell
    }
    
    func decodeJson() {
        
        let jsonUrlString = "https://jsonplaceholder.typicode.com/todos"
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                self.todoList = try JSONDecoder().decode([TodoItem].self, from: data)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            } catch let jsonError {
                print("Error! Could not decode JSON: \(jsonError.localizedDescription)")
            }
            
            }.resume()
    }
 

}
