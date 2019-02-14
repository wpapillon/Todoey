//
//  File.swift
//  Todoey
//
//  Created by Yexiao Wu on 2019-02-14.
//  Copyright © 2019 Yexiao Wu. All rights reserved.
//

import Foundation
class Item{

    var m_title : String=""
    var m_done : Bool = false
    
    init(title:String,done:Bool) {
        m_title = title
        m_done = done
    }

}
