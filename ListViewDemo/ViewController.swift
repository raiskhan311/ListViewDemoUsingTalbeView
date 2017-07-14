//
//  ViewController.swift
//  ListViewDemo
//
//  Created by mac on 14/07/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var btn_SelectYourLocation: UIButton!
    
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var ContView: UIView!
    
    let locationArray:[String] = ["Indore","Bhopal","Gwalier","Raipur","Jabalpur","Sonkatch","Ashta","Panna","Riwa","Dehli", "Banglore","Hydrabad"]
    
    var cityNameArray :[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ContView.alpha = 0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btn_SelectYourLocation(_ sender: Any) {
        ContView.alpha = 1
        downloadData()
        print(cityNameArray.count)
        tblView.reloadData()
    }
    
    
}

//MARK: - Creat extention for TableView
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityNameArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let cityName = cityNameArray[indexPath.row]
        cell.textLabel?.text = cityName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        btn_SelectYourLocation.titleLabel?.text = cityNameArray[indexPath.row]
        ContView.alpha = 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.purple
    }
}

//MARK: - Create extention for Download json Data

extension ViewController{
    func downloadData()
    {
        WebSerivce.shared.getCity { data in
            let json = try! JSONSerialization.jsonObject(with: data
                , options:[])
            print(json)
            guard let localarr = json as? [Any] else {return}
            for index in 0..<localarr.count{
                guard let localDict = localarr[index] as? NSDictionary else {return}
                guard let cityName = localDict["name"] as? String else {return}
                cityNameArray.append(cityName)
            }
        }
    }
}

