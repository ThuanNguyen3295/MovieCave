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
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var overViewLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var index: Int!
    var detailMovies: [NSDictionary]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //detailLabel.text = ("U clicked on a movie \(index)")
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(dataDictionary)
                    self.detailMovies = dataDictionary["results"] as! [NSDictionary]
                    let movie = self.detailMovies![self.index]
                    let title = movie["title"] as! String
                    self.detailLabel.text = title
                    let baseURL = "https://image.tmdb.org/t/p/w500/"
                    let posterPath = movie["poster_path"] as! String
                    let imageURL = NSURL(string: baseURL + posterPath)
                    self.posterView.setImageWith(imageURL as! URL)
                    self.overViewLabel.text = "      \(movie["overview"] as! String)"
                    let rate = movie["vote_average"] as! Double
                    let votes = movie["vote_count"] as! Double
                    self.ratingLabel.text = (String)(rate) + " (" + (String)(votes) + " votes)"
                    self.releaseDateLabel.text =  movie["release_date"] as! String
                    
                }
            }
        }
        
        task.resume()
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
