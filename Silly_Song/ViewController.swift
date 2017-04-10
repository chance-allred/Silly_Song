//
//  ViewController.swift
//  Silly_Song
//
//  Created by Chance Allred on 1/29/17.
//  Copyright © 2017 Chance Allred. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    // MARK: Properties
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")
    
    
    // MARK: IBActions
    
    // Connected to TextField's editingDidBegin
    @IBAction func reset(_ sender: AnyObject) {
        print("Resetting Values")
        nameField.text = ""
        lyricsView.text = ""
        
    }
    
    // Connected to TextField's editingDidEnd
    @IBAction func displayLyrics(_ sender: AnyObject) {
        print("Displaying lyrics")
        
        if let name = nameField.text {
            let lyrics = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: name)
            lyricsView.text = lyrics
        }
        let lyrics = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameField.text!)
        lyricsView.text = lyrics
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameField.resignFirstResponder()
        return false // MARK: Note - Double check this
    }
    
    
    // MARK: Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
       
    }
    
    func shortNameFromName(name: String) -> String {
        
        var lowercaseName = name.lowercased()
        
        /* If name starts with a vowel*/
        if let firstChar = lowercaseName.characters.first {
            switch firstChar {
            case "a": return lowercaseName
            case "e": return lowercaseName
            case "i": return lowercaseName
            case "o": return lowercaseName
            case "u": return lowercaseName
            default: break
            }
        }
        
        // If vowel is present after first character
        let set = CharacterSet(charactersIn: "aeiou")
        
        if let range = name.rangeOfCharacter(from: set) {
            let shortName = lowercaseName.substring(from: (range.lowerBound))
            
            return shortName
        }
        
        // All other cases
        return lowercaseName
        
    }
    
    func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
        
        let shortName = shortNameFromName(name: fullName)
        let lyrics = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
        
        return lyrics
    }


}

