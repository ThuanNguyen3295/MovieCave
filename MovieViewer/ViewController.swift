//
//  ViewController.swift
//  MovieViewer
//
//  Created by Thuan Nguyen on 2/2/17.
//  Copyright © 2017 Thuan Nguyen. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var movies: [NSDictionary]?
    var filteredData: [NSDictionary]?
    var endpoint: String = "now_playing"
    lazy var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
    
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        self.searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
        
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        print(endpoint)
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        //let url = URL(string:)
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(dataDictionary)
                 self.movies = dataDictionary["results"] as! [NSDictionary]
                 self.tableView.reloadData()
                    
                    
                }
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if (self.searchBar.text?.isEmpty)! {
        return self.movies?.count ?? 0
        }
        else {
        return self.filteredData?.count ?? 0
        }
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.selectionStyle = .none
        let movie = (self.searchBar.text!.isEmpty) ? movies![indexPath.row] : filteredData![indexPath.row]
        let title = movie["title"] as! String
        cell.titleLabel.text = title
        
        let overview = movie["overview"] as! String
        cell.overviewLabel.text = overview
        let rating = movie["vote_average"] as! Double
        cell.rateLabel.text = (String)(rating)
        let baseURL = "https://image.tmdb.org/t/p/w500/"
        let posterPath = movie["poster_path"] as! String
        let imageURL = NSURL(string: baseURL + posterPath)
        cell.posterView.setImageWith(imageURL as! URL)
        
        
        
        return cell
    }
    func refreshControlAction(_ refreshControl: UIRefreshControl){
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
       // let task: URLSessionDataTask = session.dataTask(with: URLRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            self.tableView.reloadData()
            refreshControl.endRefreshing()

    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredData = searchText.isEmpty ? movies : movies?.filter({ (movie) -> Bool in
            (movie.value(forKey: "title") as! String).range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        self.tableView.reloadData()
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow
        let index = indexPath?.row
        let movie = (self.searchBar.text!.isEmpty) ? movies![(indexPath?.row)!] : filteredData![(indexPath?.row)!]
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.index = index
        detailViewController.rating = movie["vote_average"] as! Double
        detailViewController.titleLabel = movie["title"] as! String
        let baseURL = "https://image.tmdb.org/t/p/w500/"
        let posterPath = movie["poster_path"] as! String
        detailViewController.imageURL = NSURL(string: baseURL + posterPath)
        detailViewController.overview = movie["overview"] as! String
        detailViewController.votes = movie["vote_count"] as! Int
        detailViewController.releaseDate = movie["release_date"] as! String
        
        
    }
    


}

