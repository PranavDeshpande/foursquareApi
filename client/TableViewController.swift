//
//  TableViewController.swift
//  client
//
//  Created by Pranav Shashikant Deshpande on 7/13/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//

import UIKit

let clientID = "2ZY1DYEP5ZCRPL45RUJ2I1HOR2TTK1MBUD1XQMNQOZOXD524"
let clientScret = "VN2RI0K3IGRRP0V5Y5SFK0HHVB2F0GPM3B2OFDQ3Y5TMZY5Y"

class TableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet var searchTxt: UITableView!
    
    
    
    var hospitalNames = [String]() //hostpitalNamesArray
    
    //var tableData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFourSquareData(type: "Restaurant")
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return hospitalNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)

        if let content = hospitalNames[indexPath.row] as? String {
            cell.textLabel?.text = content
        }

        return cell
    }
    
    func getFourSquareData(type:String) {
        
        let urlStr = String(format: "https://api.foursquare.com/v2/venues/search?near=Fremont&query=%@&client_id=%@&client_secret=%@&v=20130815", type, clientID,clientScret)
        
        let url = URL(string: urlStr)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest){(data, respponse, error) in
            if error == nil {
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, Any> {
                        guard let arr = jsonResult as? [String:Any] else {
                            return
                        }
                        let res = arr["response"] as? [String:Any]
                        let res1 = res?["venues"] as? [[String:Any]]
                        print(res1?[0])
                        
                        for result in res1! {
                            print(result["name"] as! String)
                            self.hospitalNames.append(result["name"] as! String)
                        }
                        DispatchQueue.main.sync {
                            print("here", self.hospitalNames)
                            self.tableView.reloadData()
                        }
                        
                    }
                }
                catch{
                    print("error")
                }
            }
            
    }.resume()
    }
    
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !(searchBar.text?.isEmpty)! {
            hospitalNames.removeAll()
            getFourSquareData(type: searchBar.text!)
            self.tableView.reloadData()
        }
        searchBar.resignFirstResponder()
    }
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
 
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
