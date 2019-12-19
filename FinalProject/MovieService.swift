//
//  MovieService.swift
//  FinalProject
//
//  Created by Brendan Flood on 12/18/19.
//  Copyright © 2019 Brendan Flood. All rights reserved.
//

import UIKit

class MovieService: NSObject {
   
        var movies: [Movie] = [Movie(title: "Avengers: Endgame", year: 2019, genre: "Action", cover: ""), Movie(title: "Superbad", year: 2007, genre: "Comedy", cover: ""), Movie(title: "The Exorcist", year: 1973, genre: "Horror", cover: ""), Movie(title: "The Prestige", year: 2007, genre: "Drama", cover: "")]
        private var movieImages: [URL: UIImage] = [:]
        
        let url = URL(string: "https://uofd-tldrserver-develop.vapor.cloud/movies")!

        static var shared: MovieService = MovieService()
        
        func fetchmovies(completion: @escaping () -> Void) {
            let task = URLSession(configuration: .ephemeral).dataTask(with: url) { [weak self] (data, response, error) in
                if let data = data {
                    if let newmovies = try? JSONDecoder().decode([Movie].self, from: data) {
                        self?.movies = newmovies
                        completion()
                    }
                }
            }
            task.resume()
        }
        
        func createmovie(movie: Movie, completion: @escaping () -> Void) {
            let encoder = JSONEncoder()
            guard let body = try? encoder.encode(movie) else { return }
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = body
            let task = URLSession(configuration: .ephemeral).dataTask(with: request) { (data, response, error) in
                completion()
            }
            task.resume()
        }
        
        func image(for movie: Movie, completion: @escaping (Movie, UIImage?) -> Void) {
            guard let imageURL = movie.cover else { completion(movie, nil); return }
            if movieImages[imageURL] != nil { completion(movie, movieImages[imageURL]); return }
            let task = URLSession(configuration: .default).dataTask(with: imageURL) { [weak self] (data, response, error) in
                guard let data = data else { completion(movie, nil); return }
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.movieImages[imageURL] = image
                    }
                    completion(movie, image)
                } else {
                    completion(movie, nil)
                }
            }
            task.resume()
        }
        
    }

