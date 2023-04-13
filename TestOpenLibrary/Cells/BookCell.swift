//
//  BookCell.swift
//  TestOpenLibrary
//
//  Created by Александр Молчан on 13.04.23.
//

import UIKit
import SnapKit
import SDWebImage

final class BookCell: UITableViewCell {
    static let id = String(describing: BookCell.self)
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var firstDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var bookImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .clear
        return image
    }()
    
    private var bookModel: BookObject
    
    init(bookModel: BookObject) {
        self.bookModel = bookModel
        super.init(style: .default, reuseIdentifier: BookCell.id)
        configurateCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurateCell() {
        layoutElements()
        makeConstraints()
        setupData()
    }
    
    private func layoutElements() {
        addSubview(titleLabel)
        addSubview(firstDateLabel)
        addSubview(bookImage)
    }
    
    private func makeConstraints() {
        let imageInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        bookImage.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(imageInsets)
            make.width.equalTo(50)
            make.height.equalTo(70)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(5)
            make.leading.equalTo(bookImage.snp.trailing).inset(-16)
        }
        
        firstDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(bookImage.snp.trailing).inset(-16)
        }
    }
    
    private func setupData() {
        titleLabel.text = bookModel.name
        firstDateLabel.text = "Year of first publish: \(bookModel.firstPublishYear)"
        bookImage.image = UIImage(systemName: "cloud.circle")
        
        guard let id = bookModel.imageId else { return }
        let stringId = String(id)
        bookImage.sd_setImage(with: URL(string: stringId.formatImageUrl() ))
    }
    
}

extension String {
    func formatImageUrl() -> String {
        return "https://covers.openlibrary.org/b/id/\(self)-M.jpg"
    }
}
