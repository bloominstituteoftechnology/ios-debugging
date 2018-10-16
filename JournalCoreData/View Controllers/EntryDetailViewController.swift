//
//  EntryDetailViewController.swift
//  JournalCoreData
//
//  Created by Spencer Curtis on 8/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    @IBAction func saveEntry(_ sender: Any) {
        
        guard let title = titleTextField.text,
            
            let bodyText = bodyTextView.text else { return }
        
        let moodIndex = moodSegmentedControl.selectedSegmentIndex
        var mood = Mood.allMoods[moodIndex]
        
//        switch moodSegmentedControl.selectedSegmentIndex {
//        case 0:
//            mood = Mood.bad.rawValue
//        case 1:
//            mood = Mood.neutral.rawValue
//        case 2:
//            mood = Mood.good.rawValue
//        default:
//            break
//        }
        
        if let entry = entry {
            
            entry.title = title
            entry.bodyText = bodyText
            entry.mood = mood.rawValue
            
            entryController?.put(entry: entry)
            entryController?.saveToPersistentStore()
            // Why? Maybe because the functions are representations and therefore
            // won't act the same as calling the function nested in a function.
        } else {
            let entry = Entry(title: title, bodyText: bodyText, mood: mood.rawValue)
            entryController?.put(entry: entry)
            entryController?.saveToPersistentStore()
        }
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        guard let entry = entry,
            isViewLoaded else {
                title = "Create Entry"
                return
        }
        
        title = entry.title
        titleTextField.text = entry.title
        bodyTextView.text = entry.bodyText
        
        var segmentIndex = 0
        
        switch entry.mood {
        case Mood.bad.rawValue:
            segmentIndex = 0
        case Mood.neutral.rawValue:
            segmentIndex = 1
        case Mood.good.rawValue:
            segmentIndex = 2
        default:
            break
        }
        
        moodSegmentedControl.selectedSegmentIndex = segmentIndex
    }
    
    var entryController: EntryController?
    
    @IBOutlet weak var moodSegmentedControl: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!

}
