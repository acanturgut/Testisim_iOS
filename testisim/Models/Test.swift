//
//  Test.swift
//  testisim
//
//  Created by Ahmet Can on 19.08.2018.
//  Copyright © 2018 Testisim. All rights reserved.
//

import Foundation

class Test: NSObject, NSCoding {
    
    var date: String
    var status: Bool
    
    init(date: String, status: Bool){
        self.date = date
        self.status = status
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.date = aDecoder.decodeObject(forKey: "date") as? String ?? ""
        self.status = aDecoder.decodeBool(forKey: "status")
       
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: "date")
        aCoder.encode(status, forKey: "status")
        
    }
}
