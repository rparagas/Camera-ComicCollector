//
//  ViewController.swift
//  Camera-ComicCollector
//
//  Created by Ray Paragas on 9/12/16.
//  Copyright © 2016 Ray Paragas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var comics : [Comic] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let comic = comics[indexPath.row]
        cell.textLabel?.text = comic.title
        cell.imageView?.image = UIImage(data: comic.image as! Data)
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            comics = try context.fetch(Comic.fetchRequest()) as! [Comic]
            tableView.reloadData()
        } catch {
            print("ERROR")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comic = comics[indexPath.row]
        performSegue(withIdentifier: "comicSegue", sender: comic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! ComicViewController
        nextVC.comic = sender as? Comic
    }

}

