//
//  Post.swift
//  Selfigram
//
//  Created by Tony Shu Zhang on 2017-03-02.
//  Copyright © 2017 Tony Shu Zhang. All rights reserved.
//

import Foundation
import UIKit
import Parse

class Post: PFObject, PFSubclassing {

//    let imageURL: URL
//    let user: User
//    let comment: String
    
    @NSManaged var image:PFFile
    @NSManaged var user:PFUser
    @NSManaged var comment:String
    
//    init(imageURL: URL, user: User, comment: String){
//        self.imageURL = imageURL
//        self.user = user
//        self.comment = comment
//    }
    
    convenience init(image:PFFile, user:PFUser, comment:String){
        // You can name the property you are passing into the function the
        // same name as the class' property. To distinguish the two
        // add "self." to the beginning of the class' property.
        self.init()
        self.image = image
        self.user = user
        self.comment = comment
    }
    
    static func parseClassName() -> String {
        // sets what the table name on Parse will be called
        return "Post"
    }
}
