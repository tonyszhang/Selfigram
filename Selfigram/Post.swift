//
//  Post.swift
//  Selfigram
//
//  Created by Tony Shu Zhang on 2017-03-02.
//  Copyright © 2017 Tony Shu Zhang. All rights reserved.
//

import Foundation
import UIKit

class Post {
    let image: UIImage
    let user: User
    let comment: String
    
    init(image: UIImage, user: User, comment: String){
        self.image = image
        self.user = user
        self.comment = comment
        
    }
}
