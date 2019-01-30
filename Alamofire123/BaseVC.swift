//
//  BaseVC.swift
//  Alamofire123
//
//  Created by XongoLab on 10/10/18.
//  Copyright © 2018 XongoLab. All rights reserved.
//

import UIKit
import Alamofire

class BaseVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
@IBOutlet weak var TblView: UITableView!
    var arrdata = [String:AnyObject]()
    var array:[AnyObject] = []
    var consumer_id = "CON1536580194965377944"
    var code = "EN"
    let activityView = UIActivityIndicatorView(activityIndicatorStyle:UIActivityIndicatorViewStyle.whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()
        TblView.rowHeight = 200
        TblView.delegate = self
        TblView.dataSource = self
        title = "Alamofire Api"
        
        activityView.center = self.view.center
        activityView.color = UIColor.black
        activityView.startAnimating()
         self.view.addSubview(activityView)
       
        
      //  let param:[String:AnyObject] = ["consumer_id":consumer_id as AnyObject,"code":code as AnyObject]
        
        getdata()
    }
    func getdata(){
        
        let url = "https://api.chefsy.ca/api/consumer/get-consumer-profile"
        //let param:Parameters = ["consumer_id":"CON1536580194965377944" , "code":"EN"]
        let param:[String:AnyObject] = ["consumer_id":consumer_id as AnyObject,"code":code as AnyObject]

        Alamofire.request(url, method: .post, parameters: param, encoding: URLEncoding.default, headers: nil).validate().responseJSON { (response) in
            switch response.result{
            case .success:
                print(response.result.value!)

                let jsondata = response.result.value as AnyObject
                print(jsondata)

                if let result = jsondata["payload"] as? NSDictionary {

                    self.arrdata = result as! [String:AnyObject]

                    print(result)

                    if let address = result["delivery_address"] as? NSArray {

                        self.array = address as [AnyObject]
                        print(self.array)

                    }

                }
                DispatchQueue.main.async() {
                    self.activityView.stopAnimating()
                    self.activityView.isHidden = true
                    self.TblView.reloadData()
                }
                break
            case .failure(let error):
                    print("Error is occuring....",error.localizedDescription)
                    break
            }
        }
    }
//            let json = JSON(response.result.value as Any)
//                self.update(jsondata:json)
//                print (json)
//                self.TblView.reloadData()
//        }
//
//}
//    func update(jsondata:JSON){
//        for(m,n) in jsondata["payload"]{
//        let newdata = ("\(m)\(n)")
//            currency.append(newdata)
//            print(currency)
//    }
//}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
    let dictionary = array[indexPath.row]
        cell.LblFirst.text = ("Address: \(dictionary["address"] as! String)!")
        cell.LblAddressid.text = ("Address ID: \(dictionary["address_id"] as! String)!")
        cell.LblApt_Name.text = ("Apartment Name: \(dictionary["apt_name"] as! String)!")
        return cell
    }
    
}
