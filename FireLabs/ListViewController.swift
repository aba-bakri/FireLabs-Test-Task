//
//  TableViewController.swift
//  FireLabs
//
//  Created by Aba-Bakri on 7/1/20.
//  Copyright © 2020 Ababakri Ibragimov. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    final let url = URL(string: "http://jsonplaceholder.typicode.com/posts")
    private var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadPosts()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "PostID: \(posts[indexPath.row].id)"
        cell.detailTextLabel?.text = posts[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailTableViewController {
            destination.title = "PostID: \(posts[(tableView.indexPathForSelectedRow?.row)!].id)"
            destination.id = posts[(tableView.indexPathForSelectedRow?.row)!].id
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
    func downloadPosts() {
        guard let downloadURL = url else { return }
        URLSession.shared.dataTask(with: downloadURL) { (data, response, error) in
            guard let data = data, error == nil, response != nil else {
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                let tempPosts = try decoder.decode([Post].self, from: data)
                self.posts = Array(tempPosts[0..<30])

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print("Error, something went wrong.")
            }
        }.resume()
    }
}
    
