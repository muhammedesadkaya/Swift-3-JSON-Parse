//
//  ViewController.swift
//  Swift 3 Json Parse
//
//  Created by Muhammed Esad Kaya on 02/09/2017.
//  Copyright © 2017 Muhammed Esad Kaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
                    let myJson = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
                    
                    for i in 0...5
                    {
                        
                        let jsonDic = myJson[i] as! NSDictionary
                        
                        print(jsonDic["baslik"] as! NSString)
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


}

