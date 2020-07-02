//
//  DetailTableViewController.swift
//  FireLabs
//
//  Created by Aba-Bakri on 7/2/20.
//  Copyright © 2020 Ababakri Ibragimov. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    private var comments = [Comment]()
    var id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadComments()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return comments.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell", for: indexPath) as! DetailTableViewCell
        cell.idLabel.text = "\(comments[indexPath.row].id)"
        cell.nameLabel.text = "Name: \(comments[indexPath.row].name)"
        cell.emailLabel.text = "Email: \(comments[indexPath.row].email)"
        cell.bodyLabel.text = "Comment: \(comments[indexPath.row].body)"
        return cell
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Добавить комментарий", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Введите имя"
        }
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Введите email"
        }
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Введите комментарий"
        }
        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { (alertAction: UIAlertAction!) in
            let nameTextField = alert.textFields![0] as UITextField
            let emailTextField = alert.textFields![1] as UITextField
            let commentTextField = alert.textFields![2] as UITextField
            
            if nameTextField.text != "" && emailTextField.text != "" && commentTextField.text != "" {
                let newItem = Comment(id: self.comments.count+1, name: nameTextField.text!, email: emailTextField.text!, body: commentTextField.text!)
                self.comments.append(newItem)
                self.tableView.reloadData()
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func downloadComments() {
        let url = URL(string: "http://jsonplaceholder.typicode.com/comments?postId=\(id)")
        guard let downloadURL = url else { return }
        URLSession.shared.dataTask(with: downloadURL) { (data, response, error) in
            guard let data = data, error == nil, response != nil else {
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                let tempComments = try decoder.decode([Comment].self, from: data)
                self.comments = tempComments

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print("Error, something went wrong.")
            }
        }.resume()
    }
}
