//
//  DetailViewController.swift
//  MovieViewer
//
//  Created by Thuan Nguyen on 2/4/17.
//  Copyright © 2017 Thuan Nguyen. All rights reserved.
//

import UIKit
import MBProgressHUD

class DetailViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    var imageURL: NSURL!
    var movie: NSDictionary!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height)
        
                    let title = movie["title"] as? String
                    self.detailLabel.text = title
        
                    let overview = movie["overview"] as? String
                    self.overViewLabel.text = "    " + overview!
                    overViewLabel.sizeToFit()
        
                    let rating = movie["vote_average"] as! Double
                    let votes = movie["vote_count"] as! Int
                    self.ratingLabel.text = (String)(rating) + " (" + (String)(votes) + " votes)"
                    let releaseDate = movie["release_date"] as! String
                    self.releaseDateLabel.text =  releaseDate
        
                    let baseLowURL = "https://image.tmdb.org/t/p/w45/"
                    let baseHighURL = "https://image.tmdb.org/t/p/w500/"
        
        
        
                    if let posterPath = movie["poster_path"] as? String{
                        let lowImageRequest = NSURLRequest(url: NSURL(string: baseLowURL + posterPath)! as URL)
                        let highImageRequest = NSURLRequest(url: NSURL(string: baseHighURL + posterPath)! as URL)

                        self.posterView.setImageWith(lowImageRequest as URLRequest, placeholderImage: nil, success: { (lowImageRequest, lowImageRespone, lowImage) in
                            self.posterView.alpha = 0.0
                            self.posterView.image = lowImage;
                            
                            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                                
                                self.posterView.alpha = 1.0
                                
                            }, completion: { (sucess) -> Void in
                                
                                // The AFNetworking ImageView Category only allows one request to be sent at a time
                                // per ImageView. This code must be in the completion block.
                                self.posterView.setImageWith(
                                    highImageRequest as URLRequest,
                                    placeholderImage: lowImage,
                                    success: { (highImageRequest, highImageResponse, highImage) -> Void in
                                        
                                        self.posterView.image = highImage;
                                        
                                },
                                    failure: { (request, response, error) -> Void in
                                        // do something for the failure condition of the large image request
                                        // possibly setting the ImageView's image to a default image
                                })
                            })
                        }, failure: { (highImageRequest, highImageRespone, highImage) in
                            let posterURL = NSURL(string: baseHighURL + posterPath )
                            self.posterView.setImageWith(posterURL as! URL)
                        })
                    }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
