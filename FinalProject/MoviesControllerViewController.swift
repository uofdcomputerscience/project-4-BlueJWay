//
//  MoviesControllerViewController.swift
//  FinalProject
//
//  Created by Brendan Flood on 12/18/19.
//  Copyright © 2019 Brendan Flood. All rights reserved.
//

import UIKit

class MoviesControllerViewController: UIViewController {

        var movies: [Movie] = [Movie(title: "Avengers: Endgame", year: 2019, genre: "Action", cover: ""), Movie(title: "Superbad", year: 2007, genre: "Comedy", cover: ""), Movie(title: "The Exorcist", year: 1973, genre: "Horror", cover: ""), Movie(title: "The Prestige", year: 2007, genre: "Drama", cover: "")]
    
    
       
        var selectedMovie: Movie?
        @IBOutlet weak var tableView: UITableView!
        var viewButton: MovieButton!
           
        var service: MovieService = MovieService()
           
        @IBAction func refresh(_ sender: UIButton){
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
        
        override func viewDidLoad() {
               super.viewDidLoad()
               // Do any additional setup after loading the view.
            service.fetchmovies() {
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
                
            }
               tableView.dataSource = self
               
           }
        
        
    }

    extension MovieViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = service.movies[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "moviecell")!
        if let moviecell = cell as? MovieCell {
            moviecell.titleLabel.text = "\(index.title)"
            moviecell.button.movieTag = index
            //let session = URLSession(configuration: .ephemeral)
            //let task = session.dataTask(with: URL(string: service.image(for: index, completion: {_,_ in index}))!) { (data, response, error) in
                //if let data = data {
                //    let image = UIImage(data: data)
                //    DispatchQueue.main.async {
                        
            service.image(for: index) { [weak self] (retrievedmovie, image) in
            
                DispatchQueue.main.async {
                    moviecell.movieImage.image = image
                }
                            
                
                
            }
        }
        //task.resume()
        //}
        return cell

        
        
        

    }
    }

    extension MovieViewController: UITableViewDelegate {

        
        
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //    // the actual function name is much longer, but I’m not working inside of Xcode right now
    //    selectedmovie = service.movies[indexPath.row]
    //
    //}
        override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
            guard let button = sender as? UIButton else { return }
            guard let cell = button.superview?.superview as? UITableViewCell else { return }
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            selectedmovie = service.movies[indexPath.row]
            if segue.destination is movieDetailViewController
            {
                let movieDetail = segue.destination as? MovieViewController
                movieDetail?.thismovie = selectedmovie
            }
        }

    }
