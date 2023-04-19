//
//  MainViewController.swift
//  TestOpenLibrary
//
//  Created by Александр Молчан on 13.04.23.
//

import UIKit
import SnapKit
import SDWebImage

final class MainViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .magenta
        return spinner
    }()
    
    private var booksArray = [BookObject]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerConfiguration()
        getData()
    }
    
    // MARK: -
    // MARK: - Configurations
    
    private func controllerConfiguration() {
        registerCells()
        layoutElements()
        makeConstraints()
    }
    
    private func registerCells() {
        tableView.register(BookCell.self, forCellReuseIdentifier: BookCell.id)
    }
    
    private func layoutElements() {
        self.view.addSubview(tableView)
        self.view.addSubview(spinner)
    }
    
    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: -
    // MARK: - Logic
    
    private func getData() {
        spinner.startAnimating()
        ProviderManager().getBooksData { [weak self] responce in
            self?.booksArray = responce.docs.sorted(by: { $0.rate ?? 0 > $1.rate ?? 0 })
            self?.spinner.stopAnimating()
        } failure: { [weak self] error in
            self?.spinner.stopAnimating()
            self?.showAlert()
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Network Error!", message: "Please, try again later.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
}

// MARK: -
// MARK: - TableViewDataSource Extension

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        booksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        BookCell(bookModel: booksArray[indexPath.row])
    }
    
}

// MARK: -
// MARK: - TableViewDelegate Extension

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVc = DetailViewController(bookModel: booksArray[indexPath.row])
        present(detailVc, animated: true)
    }
}
