//
//  FileView.swift
//  fileMan
//
//  Created by Евгений on 08.02.2021.
//

import Foundation
import UIKit

final class FileEditorViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var textView: UITextView!
    
    // MARK: - Properties
    private let file: File
    
    private let fileManagerService: FileManagerService
    
    // MARK: - Initializers
    init(_ file: File, fileManagerService: FileManagerService) {
        self.file = file
        self.fileManagerService = fileManagerService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = file.name
        textView.text = file.content
    }
}
