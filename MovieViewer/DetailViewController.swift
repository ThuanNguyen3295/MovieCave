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
                        let posterURL = NSURL(string: baseHighURL +  posterPath)
                        self.posterView.setImageWith(posterURL! as URL)
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
