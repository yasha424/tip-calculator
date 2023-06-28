//
//  HeaderView.swift
//  tip-calculator
//
//  Created by Yasha Serhiienko on 28.06.2023.
//

import UIKit

class HeaderView: UIView {
    
    private let topText: String
    private let bottomText: String
    
    private lazy var topLabel: UILabel = {
        LabelFactory.build(text: topText, font: ThemeFont.bold(ofSize: 18))
    }()
    
    private lazy var bottomLabel: UILabel = {
        LabelFactory.build(text: bottomText, font: ThemeFont.regular(ofSize: 16))
    }()

    private let topSpacerView = UIView()
    private let bottomSpacerView = UIView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            topSpacerView,
            topLabel,
            bottomLabel,
            bottomSpacerView
        ])
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = -4
        return stackView
    }()
    
    init(topText: String, bottomText: String) {
        self.topText = topText
        self.bottomText = bottomText
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        topSpacerView.snp.makeConstraints { make in
            make.height.equalTo(bottomSpacerView.snp.height)
        }
    }
    
}
