//
//  LostFound.swift
//  DemoProject
//
//  Created by Rajat Sharma on 19/07/20.
//name TEXT, itemname TEXT, lostdate INTEGER , Place TEXT , Mobile INTEGER
//  Copyright © 2020 InnovationM. All rights reserved.
//



public class LostFound {
    var name: String = ""
    var itemname: String = ""
    var finddate: String = ""
    var place: String = ""
    var  mobile: String = ""
    
    
    init(name: String, itemname: String ,finddate: String, place: String ,mobile: String){
       
        self.name = name
        self.itemname = itemname
        self.finddate = finddate
        self.place = place
        self.mobile = mobile
    }


}
