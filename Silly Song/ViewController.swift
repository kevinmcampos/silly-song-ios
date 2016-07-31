//
//  ViewController.swift
//  Silly Song
//
//  Created by Kevin Campos on 31/07/16.
//  Copyright © 2016 Memorify. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joinWithSeparator("\n")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }
    
    func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
        let shortName = shortNameForName(fullName)
        
        let lyrics = lyricsTemplate
            .stringByReplacingOccurrencesOfString("<FULL_NAME>", withString: fullName)
            .stringByReplacingOccurrencesOfString("<SHORT_NAME>", withString: shortName)
        
        return lyrics
    }
    
    func shortNameForName(fullName: String) -> String {
        let lowercaseName = fullName.lowercaseString.stringByReplacingOccurrencesOfString(" ", withString: "")
        let vowelSet  = NSCharacterSet(charactersInString: "aeioöu")
        if let firstVowelRange = lowercaseName.rangeOfCharacterFromSet(vowelSet, options: .CaseInsensitiveSearch) {
            return lowercaseName.substringFromIndex(firstVowelRange.startIndex)
        }
        return lowercaseName
    }
    
    @IBAction func reset(sender: AnyObject) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(sender: AnyObject) {
        if (self.nameField.text != nil) {
            self.lyricsView.text = lyricsForName(bananaFanaTemplate, fullName: self.nameField.text!)
        }
    }
    
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

