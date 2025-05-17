//
//  SectionHeader.swift
//  iTunesAppHyeonjin
//
//  Created by 유현진 on 5/15/25.
//

import UIKit
import SnapKit

final class SectionHeader: UICollectionReusableView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
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
    
    func configure(title: String, subTitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
}

private extension SectionHeader {
    func setAttributes() {
        backgroundColor = .systemBackground
    }
    
    func setHierarchy() {
        [titleLabel, subTitleLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        addSubview(stackView)
    }
    
    func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
