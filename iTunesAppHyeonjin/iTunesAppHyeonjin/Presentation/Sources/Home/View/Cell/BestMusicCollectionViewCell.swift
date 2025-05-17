//
//  BestMusicCollectionViewCell.swift
//  iTunesAppHyeonjin
//
//  Created by 유현진 on 5/17/25.
//

import UIKit
import SnapKit

final class BestMusicCollectionViewCell: UICollectionViewCell {
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
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
        label.font = .systemFont(ofSize: 11)
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
        thumbnailImageView.loadImage(urlString: track.thumbnailURL100.replacingOccurrences(of: "100x100", with: "600x600"), to: thumbnailImageView.frame.size, scale: 1)
        titleLabel.text = track.title
        artistLabel.text = track.artist
    }
}

private extension BestMusicCollectionViewCell {
    func setAttributes() {
        backgroundColor = .clear
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.shadowRadius = 4
        layer.masksToBounds = false
        
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
    }
    
    func setHierarchy() {
        [thumbnailImageView, stackView].forEach {
            contentView.addSubview($0)
        }
        
        [titleLabel, artistLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func setConstraints() {
        thumbnailImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(8)
        }
    }
}
