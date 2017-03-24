//
//  FeedTableViewController.swift
//  Selfigram
//
//  Created by Tony Shu Zhang on 2017-03-07.
//  Copyright © 2017 Tony Shu Zhang. All rights reserved.
//

import UIKit
import Parse

class FeedTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

//    var words = ["Hello", "my", "name", "is", "Selfigram"]
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let query = Post.query() {
            
            query.order(byDescending: "createdAt")
            query.includeKey("user")
            query.findObjectsInBackground(block: { (posts, error) -> Void in
                if let posts = posts as? [Post] {
                    self.posts = posts
                    self.tableView.reloadData()
                }
            })
        }
        
//        let me = User(name: "Tony", picture: UIImage(named: "Astronaut_Fire")!)
//        
//        let post0 = Post(image: UIImage(named: "Astronaut_Fire")!, user: me, comment: "test 0")
//        let post1 = Post(image: UIImage(named: "Astronaut_Fire")!, user: me, comment: "test 1")
//        let post2 = Post(image: UIImage(named: "Astronaut_Fire")!, user: me, comment: "test 2")
//        let post3 = Post(image: UIImage(named: "Astronaut_Fire")!, user: me, comment: "test 3")
//        let post4 = Post(image: UIImage(named: "Astronaut_Fire")!, user: me, comment: "test 4")
//        
//        posts = [post0, post1, post2, post3, post4]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Flicker API test run
//        let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=e33dc5502147cf3fd3515aa44224783f&tags=toronto")!
//        
//        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
//            
//            //convert to JSON
//            if let jsonUnformated = try? JSONSerialization.jsonObject(with: data!, options: []) {
//                let json = jsonUnformated as? [String: AnyObject]
//                let photosDictionary = json?["photos"] as? [String:AnyObject]
//                let photosArray = photosDictionary?["photo"] as? [[String:AnyObject]]
//                
//                for photo in photosArray! {
//                    
//                    if let farmID = photo["farm"] as? Int,
//                        let serverID = photo["server"] as? String,
//                        let photoID = photo["id"] as? String,
//                        let secret = photo["secret"] as? String {
//                        
//                        let photoURLString = "https://farm\(farmID).staticflickr.com/\(serverID)/\(photoID)_\(secret).jpg"
//                        print(photoURLString)
//                        if let photoURL = URL(string: photoURLString) {
//                            
//                            let me = User(name: "Tony", picture: UIImage(named: "Astronaut_Fire")!)
//                            
//                            let post = Post(imageURL: photoURL, user: me, comment: "From Flicker!")
//                            
//                            self.posts.append(post)
//                        }
//                    }
//                    
//                }
//                
//                OperationQueue.main.addOperation {
//                    self.tableView.reloadData()
//                }
//                
//                //print("\(photosArray)")
//            } else {
//                print("error with response data")
//            }
//            
//            
//            print ("inside dataTaskWithURL with data = \(data!)")
//            
//        })
//        
//        task.resume() //runs the task
//        print ("outside dataTaskWithURL")
        
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
        return self.posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! SelfieCell

        // Configure the cell...
    
        let post = self.posts[indexPath.row]
        
        cell.post = post
        
// Flicker API stuff
//
//        let task = URLSession.shared.downloadTask(with: post.imageURL) { (url, response, error) -> Void in
//            
//            if let imageURL = url, let imageData = try? Data(contentsOf: imageURL) {
//                OperationQueue.main.addOperation {
//                    
//                    cell.selfieImageView.image = UIImage(data: imageData)
//                    
//                }
//            }
//            
//        }
//        
//        task.resume()
        
        //cell.selfieImageView.image = post.image
            
        
        return cell
    }
    
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        
        print("Feed Camera Button Pressed")
        
        // 1: Create an ImagePickerController
        let pickerController = UIImagePickerController()
        
        // 2: Self in this line refers to this View Controller
        //    Setting the Delegate Property means you want to receive a message
        //    from pickerController when a specific event is triggered.
        pickerController.delegate = self
        
        if TARGET_OS_SIMULATOR == 1 {
            // 3. We check if we are running on a Simulator
            //    If so, we pick a photo from the simulator’s Photo Library
            // We need to do this because the simulator does not have a camera
            pickerController.sourceType = .photoLibrary
        } else {
            // 4. We check if we are running on an iPhone or iPad (ie: not a simulator)
            //    If so, we open up the pickerController's Camera (Front Camera, for selfies!)
            pickerController.sourceType = .camera
            pickerController.cameraDevice = .front
            pickerController.cameraCaptureMode = .photo
        }
        
        // Preset the pickerController on screen
        self.present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // 1. When the delegate method is returned, it passes along a dictionary called info.
        //    This dictionary contains multiple things that maybe useful to us.
        //    We are getting an image from the UIImagePickerControllerOriginalImage key in that dictionary
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            // Flickr API stuff
            //let me = User(name: "Tony Feed", picture: UIImage(named: "Astronaut_Fire")!)
            //let post = Post(image: image, user: me, comment: "Test Feed")
            //posts.insert(post, at: 0)
            
            if let imageData = UIImageJPEGRepresentation(image, 0.9),
                let imageFile = PFFile(data: imageData),
                let user = PFUser.current(){
                
                let post = Post(image: imageFile, user: user, comment: "Parse rocks!")
                
                post.saveInBackground(block: { (success, error) -> Void in
                    if success {
                        print("Post successfully saved in Parse")
                    
                        self.posts.insert(post, at: 0)
                        
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.tableView.insertRows(at: [indexPath], with: .automatic)
                    
                    }
                    
                })
            }
        }
        
        
        dismiss(animated: true, completion: nil)
        
        tableView.reloadData()
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
