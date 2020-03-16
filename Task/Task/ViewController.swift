//
//  ViewController.swift
//  Task
//
//  Created by apple on 13/03/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Foundation
import SDWebImage


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableViewObj: UITableView!
    
    var dataArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataServerApi()
    }
    
    //MARK: - Data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.selectionStyle = .none
        
        cell.titleNameOutlet.text = (dataArray[indexPath.row] as AnyObject).object(forKey: "title") as? String ?? ""
        cell.descriptionOutlet.text = "Description : " + ((dataArray[indexPath.row] as AnyObject).object(forKey: "description") as? String ?? "")
        let image = (dataArray[indexPath.row] as AnyObject).object(forKey: "imageHref") as? String ?? ""
        
        cell.imageViewOutlet.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "imageplaceholder"))
        
        return cell
    }
    
    //MARK : - API SERVER CALL
    
    func dataServerApi(){
        
        let urlString = PLACES_DESCRIPTION_API
        
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            let utf8Data = String(decoding: data!, as: UTF8.self).data(using: .utf8)
            
            DispatchQueue.main.async {
                
                do
                {
                    let jsonData = try JSONSerialization.jsonObject(with: utf8Data!, options: .allowFragments) as? NSDictionary
                    
                    self.dataArray = (jsonData as AnyObject).object(forKey: "rows") as? NSArray ?? []
                    
                    self.tableViewObj.dataSource = self
                    self.tableViewObj.delegate = self
                    self.tableViewObj.reloadData()
                    
                }
                catch
                {
                    
                }
            }
        }
        session.resume()
        
    }
}

