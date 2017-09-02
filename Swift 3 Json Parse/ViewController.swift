//
//  ViewController.swift
//  Swift 3 Json Parse
//
//  Created by Muhammed Esad Kaya on 02/09/2017.
//  Copyright © 2017 Muhammed Esad Kaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    
    var myTitleArray = [String]()
    var myImagesArray = [String]()

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let urlString = "http://www.bucayapimarket.com/json.php";
        let myurl = URL(string: urlString)
        
        
        let task = URLSession.shared.dataTask(with: myurl!) { (data, response, error) in
            
            if error != nil //if there is a error
            {
                print(error!)
            }
            else
            {
                do
                {
                    let myJson = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSArray
                    
                    if let jsonDic = myJson
                    {
                        for i in 0..<jsonDic.count
                        {
                            if let jsonObj = jsonDic[i] as? NSDictionary
                            {
                                if let titleArray = jsonObj["baslik"] as? String
                                {
                                    self.myTitleArray.append(titleArray)
                                }
                                if let ImageArray = jsonObj["resim"] as? String
                                {
                                    self.myImagesArray.append(ImageArray)
                                }
                            }
                        }
                        print(self.myTitleArray)
                    }
                    DispatchQueue.main.async {
                        self.tblView.reloadData()
                    }
                }
                catch
                {
                    print(error)
                }
            }
        }
        task.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return myTitleArray.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CampaignTableViewCell
        
        cell.titleLable.text = myTitleArray[indexPath.row]
        cell.timeLabel.text = "3 days"
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 130
    }
}

