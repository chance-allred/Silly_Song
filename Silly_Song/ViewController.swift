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
    
    // Connected to TextField's EditingDidBegin
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
        return true
    }
    
    
    // MARK: Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
       
    }
    
    func shortNameFromName(name: String) -> String {
        
        let lowercaseName = name.lowercased()
        
        let set = CharacterSet(charactersIn: "aeiou")
        let range = name.rangeOfCharacter(from: set)
        
        let shortName = lowercaseName.substring(from: (range?.lowerBound)!)
        
        return shortName
    }
    
    func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
        
        let shortName = shortNameFromName(name: fullName)
        let lyrics = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
        
        return lyrics
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

