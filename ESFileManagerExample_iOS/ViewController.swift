//
//  ViewController.swift
//  ESFileManagerExample_iOS
//
//  Created by Дмитрий Торопкин on 15.05.2020.
//  Copyright © 2020 Dmitriy Toropkin. All rights reserved.
//

import UIKit
import ESFileManager

final class ViewController: UIViewController {

    private var fileManager: ESFileManagerProtocol!
    
    // property with logs
    private var logString: String! {
        didSet {
            self.logLabel.text = logString
        }
    }
    //label for show logs
    @IBOutlet weak var logLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareVC()
    }
    
    /// Set default directory for filemanager and other prepare action for screen
    private func prepareVC() {
        // create file manager with default "Document" directory. You can read about this in ESFileManagerDirectory enum
        fileManager = ESFileManager(defaultDirectory: .documents(useBackups: false))
        // init string with log
        logString = ""
    }
    
    /// Write file on default directory
    private func writeFile() {
        // create data to write
        let data = "Swift is amazing!".data(using: .utf8)
        
        let fileName = ESFileNameModel(name: "SwiftDoc", fileExtension: .txt)
        let file = ESFileModel(data: data, name: fileName)
        
        // write data. At = nil cause we use default directory from prepareVC method
        fileManager.write(file: file, at: nil) { (error) in
            if let error = error {
                self.logString = "You don't record the file with error: \(error.localizedDescription)"
                return
            }
            self.logString = "You successful recorded the file!"
        }
    }
    
    /// Read file from default directory
    private func readFile() {
        // create name and extension of file to read
        let file = ESFileNameModel(name: "SwiftDoc", fileExtension: .txt)
        
        //read this file. At = nil cause we use default directory
        fileManager.read(fileStorage: file, at: nil) { (file, error) in
            //fetch error
            if let error = error {
                self.logString = "You don't read the file with error: \(error.localizedDescription)"
                return
            }
            //fetch empty state of file
            guard let data = file?.data else {
                self.logString = "You have read file but its empty!"
                return
            }
            //show our file
            let stringFile = String(data: data, encoding: .utf8)
            self.logString = "You successful read the file! File is: \n \(String(describing: stringFile))"
        }
    }
    
    private func removeFile() {
        // create name and extension of file to remove
        let file = ESFileNameModel(name: "SwiftDoc", fileExtension: .txt)
        
        //remove this file. At = nil cause we use default directory
        fileManager.remove(file: file, at: nil) { (error) in
            //fetch error
            if let error = error {
                self.logString = "You don't read the file with error: \(error.localizedDescription)"
                return
            }
            //show our file
            self.logString = "You successful remove this file!"
        }
    }
    
    @IBAction func writeButtonAction(_ sender: UIButton) {
    
        switch sender.tag {
        case 0: writeFile()
        default: logString = "Custom directory doesnt support right now!"
        }
    }
    
    
    @IBAction func readButtonAction(_ sender: UIButton) {
        
        switch sender.tag {
        case 0: readFile()
        default: logString = "Custom directory doesnt support right now!"
        }
    }
    
    @IBAction func removeButtonAction(_ sender: UIButton) {
        removeFile()
    }
}

