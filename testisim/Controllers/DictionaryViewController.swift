//
//  DictionaryViewController.swift
//  testisim
//
//  Created by Ahmet Can on 20.08.2018.
//  Copyright © 2018 Testisim. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DictionaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var searchActive : Bool = false
    
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle?
    
    var list:[String] = []
    var sublist:[String] = []
    
    var filtered:[String] = []
    var filteredSubTitle:[String] = []
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.isHidden = true
        self.searchTable.isHidden = true
        
        searchTable.rowHeight = UITableViewAutomaticDimension
        
        searchBar.delegate = self
        ref = Database.database().reference()
        
        let usersRef = ref.child("Sozluk")
        usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            for snap in snapshot.children {
                let userSnap = snap as! DataSnapshot
                
                let userDict = userSnap.value as! [String:AnyObject]
                let ack = userDict["Ack"] as! String
                let title = userDict["Kelime"] as! String
                
                self.list.append(title)
                self.sublist.append(ack)
                
            }
            
            self.indicator.isHidden = true
            self.searchBar.isHidden = false
            self.searchTable.isHidden = false
            
            self.searchTable.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // - MARK: Search
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = []
        filteredSubTitle = []
        
        for i in 1...list.count-1 {
            
            if(list[i].lowercased().contains(searchText.lowercased())){
                
                filtered.append(list[i])
                filteredSubTitle.append(sublist[i])
                
            }
        }
        
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
            
        }
        self.searchTable.reloadData()
    }
    
    // - MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchActive) {
            return filtered.count
        }
        return list.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dictionaryCell", for: indexPath) as! DictionaryTableViewCell
        
        cell.title.text = list[indexPath.row]
        cell.content.text = sublist[indexPath.row]
        
        if(searchActive){
            
            cell.title.text = filtered[indexPath.row]
            cell.content.text = filteredSubTitle[indexPath.row]
            
        } else {
            cell.title.text = list[indexPath.row]
            cell.content.text = sublist[indexPath.row]
        }
        
        return cell
        
    }
}
