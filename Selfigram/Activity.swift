//
//  Activity.swift
//  Selfigram
//
//  Created by Tony Shu Zhang on 2017-03-23.
//  Copyright © 2017 Tony Shu Zhang. All rights reserved.
//

import Foundation
import Parse

class Activity: PFObject, PFSubclassing {
    
    @NSManaged var type: String
    @NSManaged var user: PFUser
    @NSManaged var post: Post

    
    convenience init(type: String, user: PFUser, post: Post){
        self.init()
        self.type = type
        self.user = user
        self.post = post
    }
    
    static func parseClassName() -> String {
        
        return "Activity"
    }
}
