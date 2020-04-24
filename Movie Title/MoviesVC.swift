//
//  ViewController.swift
//  Movie Title
//
//  Created by Alaa Adel on 4/21/20.
//  Copyright © 2020 Alaa Adel. All rights reserved.
//

import UIKit
import SafariServices

class MoviesVC: UIViewController, UITextFieldDelegate, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [Movie]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
    }
    
    // textField .....
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        movieSearch()
        return true
    }
    
    func movieSearch() {
        textField.resignFirstResponder()
        
        guard let text = textField.text, !text.isEmpty else {return}
        
        
        movies.removeAll()
    
        URLSession.shared.dataTask(with: URL(string: "https://www.omdbapi.com/?i=tt3896198&apikey=acd34381&s=\(text)&type=movie")!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {return}
            
            // convert to Json
            var result: MovieResult?
            do {
                result = try JSONDecoder().decode(MovieResult.self, from: data)
            }
            catch {
                print("error: \(error)")
            }
            guard let finalResult = result else {return}
            
            // Update movie array
            let newMovies = finalResult.Search
            self.movies.append(contentsOf: newMovies)
            
            // refresh tableView
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            
        }).resume()
        
    }
    
    // tableView ...
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // show movies data
        let url = "https://www.imdb.com/title/\(movies[indexPath.row].imdbID)/"
        let vc = SFSafariViewController(url: URL(string: url)!)
        present(vc, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
struct MovieResult: Codable {
    let Search: [Movie]
}
struct Movie:Codable {
    let Title: String
    let Year: String
    let imdbID: String
    let _Type: String
    let Poster: String
    
    private enum CodingKeys: String, CodingKey {
        case Title, Year, imdbID, _Type = "Type", Poster
    }
}







