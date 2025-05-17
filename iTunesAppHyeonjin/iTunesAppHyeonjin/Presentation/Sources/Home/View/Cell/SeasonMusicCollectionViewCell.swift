//
//  SeasonMusicCollectionViewCell.swift
//  iTunesAppHyeonjin
//
//  Created by 유현진 on 5/14/25.
//

import UIKit
import SnapKit

final class SeasonMusicCollectionViewCell: UICollectionViewCell {
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 14
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let albumLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .light)
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttributes()
        setHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(track: Track) {
        titleLabel.text = track.title
        artistLabel.text = track.artist
        albumLabel.text = track.albumName
        thumbnailImageView.loadImage(urlString: track.thumbnailURL100, to: thumbnailImageView.frame.size, scale: 1)
    }
}

private extension SeasonMusicCollectionViewCell {
    func setAttributes() {
        backgroundColor = .systemBackground
    }
    
    func setHierarchy() {
        addSubview(thumbnailImageView)
        
        [titleLabel, artistLabel, albumLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        addSubview(stackView)
    }
    
    func setConstraints() {
        thumbnailImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(8)
            make.width.equalTo(thumbnailImageView.snp.height)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(8)
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(8)
        }
    }
}
