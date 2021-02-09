//
//  DirectoryView.swift
//  fileMan
//
//  Created by Евгений on 08.02.2021.
//

import Foundation
import UIKit

final class DirectoryViewController: UITableViewController {
    
    // MARK: - Properties
    private var directory: Directory
    
    private let fileManagerService: FileManagerService
    
    // MARK: - Initializers
    init(_ directory: Directory, fileManagerService: FileManagerService) {
        self.directory = directory
        self.fileManagerService = fileManagerService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDirectory()
        setupUI()
    }
    
    // MARK: - Actions
    @objc private func addDirectoryButtonTapped() {
        Alert.showAlert(sender: self, type: .addDirectory) { [weak self] directoryName in
            
            guard let url = self?.directory.url else { return }
            
            self?.fileManagerService.createDirectory(in: url, withName: directoryName)
            self?.updateDirectory()
            self?.tableView.reloadData()
        }
    }
    
    @objc private func addFileButtonTapped() {
        Alert.showAlert(sender: self, type: .addFile) { [weak self] fileName in
            guard let url = self?.directory.url else { return }
            
            self?.fileManagerService.writeFile(in: url, withName: fileName)
            self?.updateDirectory()
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        title = directory.name
        
        let addDirectoryBarButton = UIBarButtonItem(
            image: UIImage(named: ImageNames.addDirectory.rawValue),
            style: .plain,
            target: self,
            action: #selector(addDirectoryButtonTapped)
        )
        
        let addFileBarButton = UIBarButtonItem(
            image: UIImage(named: ImageNames.addFile.rawValue),
            style: .plain,
            target: self,
            action: #selector(addFileButtonTapped)
        )
        
        navigationItem.rightBarButtonItems = [addFileBarButton, addDirectoryBarButton]
    }
    
    // MARK: - Private methods
    private func updateDirectory() {
        do {
            guard let directory = try Directory.getDirectory(for: directory.url) else { return }
            self.directory = directory.sortedObjects().filteredHiddenFiles()
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - TableViewDataSource
extension DirectoryViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        directory.objectCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let object = directory.objects[indexPath.row]
        let objectType: ObjectType = object.isDirectory ? .directory : .file
        
        return UITableViewCell.getObjectCell(for: objectType, withTitle: object.name)
    }
}

// MARK: - TableViewDelegate
extension DirectoryViewController {
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let url = directory.url else { return }
        
        let object = directory.objects[indexPath.row]
        
        if editingStyle == .delete {
            fileManagerService.deleteObject(in: url, withName: object.name)
            updateDirectory()
            //            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            //            tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedObject = directory.objects[indexPath.row]
        
        // MARK: - Navigation
        if selectedObject.isDirectory {
            do {
                guard let openingDirectory = try Directory.getDirectory(for: selectedObject.url) else { return }
                
                let selectedDirectoryVC = DirectoryViewController(openingDirectory,
                                                                  fileManagerService: fileManagerService)
                
                navigationController?.pushViewController(selectedDirectoryVC, animated: true)
            } catch {
                print(error.localizedDescription)
            }
        } else {
            let openingFile = File(name: selectedObject.name,
                                   content: fileManagerService.readFile(url: selectedObject.url))
            
            let selectedFileVC = FileEditorViewController(openingFile,
                                                          fileManagerService: fileManagerService)
            
            navigationController?.pushViewController(selectedFileVC, animated: true)
        }
    }
}
