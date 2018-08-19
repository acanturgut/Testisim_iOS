//
//  File.swift
//  testisim
//
//  Created by Ahmet Can on 19.08.2018.
//  Copyright © 2018 Testisim. All rights reserved.
//

import Foundation

class TestisimDateFormaterUtil {
    
    init() {}
    
    func getCurrentDate()  -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy - hh:mm"
        return dateFormatter.string(from:Date())
    }
    
}
