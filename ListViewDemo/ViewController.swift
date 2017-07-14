//
//  ViewController.swift
//  ListViewDemo
//
//  Created by mac on 14/07/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Outlet connection for Select Your City
    @IBOutlet weak var btn_SelectYourLocation: UIButton!
    
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var ContView: UIView!
    
    //MARK:- Outlet connection for select Your State
    
    @IBOutlet weak var btn_SelectYourState: UIButton!
    @IBOutlet weak var tblView1: UITableView!
    @IBOutlet weak var ContView1: UIView!
    
//    let locationArray:[String] = ["Indore","Bhopal","Gwalier","Raipur","Jabalpur","Sonkatch","Ashta","Panna","Riwa","Dehli", "Banglore","Hydrabad"]
    
    var cityNameArray :[String] = []
    var stateNameArray :[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ContView.alpha = 0
        ContView1.alpha = 0
        downloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btn_SelectYourLocation(_ sender: Any) {
        ContView.alpha = 1
//        print(cityNameArray.count)
        tblView.reloadData()
    }
    
    @IBAction func btn_SelectYourCity(_ sender: Any) {
        ContView1.alpha = 1
        tblView1.reloadData()
//        print(stateNameArray.count)
    }
    
    
    
}

//MARK: - Creat extention for TableView
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return cityNameArray.count
        
        var count:Int?
        if tableView == self.tblView{
            count = cityNameArray.count
        }
        if tableView == self.tblView1{
            count = stateNameArray.count
        }
        return count!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
//        let cityName = cityNameArray[indexPath.row]
//        cell.textLabel?.text = cityName
//        return cell
        
        var cell:UITableViewCell?
        
        if tableView == tblView{
            cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            let cityName = cityNameArray[indexPath.row]
            cell?.textLabel?.text = cityName
        }
        if tableView == tblView1{
            cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
            let stateName = stateNameArray[indexPath.row]
            cell?.textLabel?.text = stateName
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblView{
            btn_SelectYourLocation.titleLabel?.text = cityNameArray[indexPath.row]
            ContView.alpha = 0
        }
        else
        {
            btn_SelectYourState.titleLabel?.text = stateNameArray[indexPath.row]
            ContView1.alpha = 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == tblView{
            cell.backgroundColor = UIColor.purple
        }
        else
        {
            cell.backgroundColor = UIColor.purple
        }
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
                guard let stateName = localDict["state"] as? String else {return}
                stateNameArray.append(stateName)
                cityNameArray.append(cityName)
            }
        }
    }
}

