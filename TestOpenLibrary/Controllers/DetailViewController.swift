//
//  DetailViewController.swift
//  TestOpenLibrary
//
//  Created by Александр Молчан on 14.04.23.
//

import UIKit
import SnapKit
import SDWebImage

final class DetailViewController: UIViewController {
    private let bookModel: BookObject
    
    private lazy var bookImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .clear
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ok", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.tintColor = .white
        button.backgroundColor = .systemCyan.withAlphaComponent(0.8)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        return button
    }()
    
    init(bookModel: BookObject) {
        self.bookModel = bookModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerConfiguration()
    }
    
    // MARK: -
    // MARK: - Configurations
    
    private func controllerConfiguration() {
        layoutElements()
        makeConstraints()
        setupData()
    }
    
    private func layoutElements() {
        self.view.addSubview(bookImage)
        self.view.addSubview(titleLabel)
        self.view.addSubview(infoLabel)
        self.view.addSubview(confirmButton)
    }
    
    private func makeConstraints() {
        bookImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(bookImage.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualTo(confirmButton.snp.top).inset(-10)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
    }
    
    // MARK: -
    // MARK: - Logic
    
    private func setupData() {
        view.backgroundColor = .white
        var snippetsString = ""
        
        if let year = bookModel.firstPublishYear {
            snippetsString = "\nDate of first published \(year)\n"
        }
        
        bookModel.snippet?.forEach({ snippet in
            snippetsString += snippet
            snippetsString += "\n"
        })
        
        titleLabel.text = bookModel.name
        infoLabel.text = "Rating: \(bookModel.rate ?? 0.0)\(snippetsString)"
        bookImage.image = UIImage(named: "NotFound")?.withTintColor(.magenta, renderingMode: .automatic)

        guard let id = bookModel.imageId else { return }
        let stringId = String(id)
        
        bookImage.sd_setImage(with: URL(string: stringId.formatImageUrl()), placeholderImage: UIImage(systemName: "icloud.and.arrow.down"), options: .progressiveLoad)
    }
    
    @objc private func confirm() {
        dismiss(animated: true)
    }
    
}
