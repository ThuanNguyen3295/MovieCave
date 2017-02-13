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
    var rating: Double!
    var titleLabel: String!
    var index: Int!
    var detailMovies: [NSDictionary]?
    var imageURL: NSURL!
    var overview: String!
    var votes: Int!
    var releaseDate: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //detailLabel.text = ("U clicked on a movie \(index)")
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height)
        
        
        
        
        
                    self.detailLabel.text = self.titleLabel
                    self.posterView.setImageWith(self.imageURL as! URL)
                    
                    self.overViewLabel.text = "    " + overview
                    overViewLabel.sizeToFit()
                    self.ratingLabel.text = (String)(self.rating) + " (" + (String)(self.votes) + " votes)"
                    self.releaseDateLabel.text =  releaseDate
        
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
