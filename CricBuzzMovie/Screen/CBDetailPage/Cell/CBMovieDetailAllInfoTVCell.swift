//
//  CBMovieDetailAllInfoTVCell.swift
//  CricBuzzMovie
//
//  Created by Sanju on 01/10/23.
//

import UIKit



class CBMovieDetailAllInfoTVCell: UITableViewCell {
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var actor: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var writer: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var story: UILabel!
    
    
    func populate(language: String, actor: String, director: String, writer: String, genre: String, story: String) {
        self.language.text = language
        self.actor.text = actor
        self.director.text = director
        self.writer.text = writer
        self.genre.text = genre
        self.story.text = story
    }
}
