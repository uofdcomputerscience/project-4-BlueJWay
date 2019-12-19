//
//  MovieViewController.swift
//  FinalProject
//
//  Created by Brendan Flood on 12/18/19.
//  Copyright © 2019 Brendan Flood. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    
    var thisMovie: Movie! = Movie(title: "", year: 1, genre: "", cover: "")
    var service: ReviewService! = ReviewService()
        
        
        @IBOutlet var titleLabel: UILabel!
        @IBOutlet var yearLabel: UILabel!
        @IBOutlet var genreLabel: UILabel!
        @IBOutlet var coverImage: UIImageView!
    @IBOutlet var reviewsTable: UITableView
        
        func setImage() {
            let service = MovieService()
            let movie: Movie! = thisMovie
            service.image(for: movie) { [weak self] (retrievedmovie, image) in
                
                    DispatchQueue.main.async {
                        self?.coverImage.image = image
                    }
            
            }
        }
        
        
        override func viewDidLoad() {
            titleLabel.text = "\(thisMovie.title)"
            yearLabel.text = "Release Year: \(thisMovie.year)"
            genreLabel.text = "Genre: \(thisMovie.genre)"
            setImage()
            service.fetchReviews {
                self.service.reviews = self.service.reviews.filter{$0.movie == self.thisMovie.title}
            }
        }
        
    }

extension MovieViewController: UITableViewDataSource {

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return service.reviews.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
let index = service.reviews[indexPath.item]
    let cell = tableView.dequeueReusableCell(withIdentifier: "reviewcell")!
if let reviewcell = cell as? ReviewCell {
    reviewcell.title.text = "\(index.title)"
    reviewcell.reviewer.text = "Written by: \(index.reviewer)"
    reviewcell.book.text = "Book ID: \(index.bookId)"
    if let date = index.date {
        reviewcell.date.text = "\(formatter.string(from: date))"
    }
    reviewcell.body.text = "Preview: \(index.body)"
                    
        
    
        
    }
    
    //task.resume()
    //}
    return cell

    }
 
}
