//
//  ViewController.swift
//  Meow Fest
//
//  Created by Brian Sakhuja on 12/12/18.
//  Copyright © 2018 Brian Sakhuja. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage


class ViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    
    var cats = [Cat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.downloadJSONFromURL()
        
    }
    
    func downloadJSONFromURL() {
        let JSONURL = URL(string: "https://chex-triplebyte.herokuapp.com/api/cats?page=0")!
        URLSession.shared.dataTask(with: JSONURL, completionHandler: { (data, response, error) in
            if let jsonObj = try? JSON(data: data!) {
                self.initializeCats(_from: jsonObj)
            }
        }).resume()
    }
    
    func initializeCats(_from jsonData: JSON) {
        for catIndex in 0..<jsonData.count {
            let catJSON = jsonData[catIndex]
            let catDateAsString = catJSON["timestamp"].string
            let catImageURL = URL(string: catJSON["image_url"].string!)
            let catTitle = catJSON["title"].string
            let catDescription = catJSON["description"].string
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            let date = dateFormatter.date(from:catDateAsString!)!
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
            let finalDate = calendar.date(from:components)

            let catObject = Cat(date: finalDate!, imageURL: catImageURL!, title: catTitle!, description: catDescription!)
            
            cats.append(catObject)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cat = cats[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell") as! CatsTableViewCell
        cell.titleLabel.text = cat.title
        cell.dateLabel.text = cat.date.description
        cell.catImage.sd_setImage(with: cat.imageURL, placeholderImage: UIImage(named: "placeholder.png"))
        cell.descriptionLabel.text = cat.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }

    
    
}

