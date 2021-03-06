//
//  CountryHeritageTableViewCell.swift
//  ProofOfConcept
//
//  Created by AshwiniT on 24/10/18.
//  Copyright © 2018 Ashwini Tangade. All rights reserved.
//

import UIKit
import SDWebImage

class CountryHeritageTableViewCell:UITableViewCell{
    var titleLabel:UILabel!
    var descriptionLabel:UILabel!
    var displayImageView:UIImageView!
    var bottomLine:UIView!
    
    func setCell(withItem:CountryHeritage){
        titleLabel.text = nil
        descriptionLabel.text = nil
        self.displayImageView.image = nil
        titleLabel.text = withItem.title ?? ""
        descriptionLabel.text = withItem.desc ?? ""
        let imageUrl = withItem.imageHref ?? ""
        if let imageView = displayImageView {
            imageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "noImage"), options: .refreshCached) { (image, error, cacheType, url) in
                if (error != nil || image == nil)
                {
                    print("Image loader- ",error as Any)
                    self.setImage(image: UIImage(named: "noImage")!)
                }else{
                    self.setImage(image: image!)
                }
            }
        }
    }
    
    func setImage(image: UIImage){
        DispatchQueue.main.async {
            self.displayImageView.image = image
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpTableViewCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpTableViewCell(){
        // Description Label constraints added
        descriptionLabel  = UILabel.init()
        self.contentView.addSubview(descriptionLabel)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
        descriptionLabel.font = UIFont.systemFont(ofSize:  CGFloat(Constants.descriptionLabelFontSize), weight: .regular)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Title Label constraints added
        titleLabel  = UILabel.init()
        titleLabel.numberOfLines = 0;
        titleLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Constants.titleLabelFontSize))
        titleLabel.textColor = UIColor.black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(titleLabel)
        
        //Display ImageView constraints added
        displayImageView  = UIImageView.init()
        self.contentView.addSubview(displayImageView)
        displayImageView.contentMode = .scaleAspectFit
        displayImageView.translatesAutoresizingMaskIntoConstraints = false

        // Bottom View constraints added
        bottomLine  = UIView()
        self.contentView.addSubview(bottomLine)
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //set title label constraints
            titleLabel.leadingAnchor.constraint(equalTo: self.displayImageView.trailingAnchor, constant: CGFloat(Constants.marginConstant)),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: CGFloat(Constants.marginConstant)),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor , constant: CGFloat(Constants.marginConstant)),
            
            //set Image view constraint
            displayImageView.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor,constant: CGFloat(Constants.marginConstant)),
            displayImageView.heightAnchor.constraint(equalToConstant: CGFloat(Constants.imageViewWidthConstant)),
            displayImageView.widthAnchor.constraint(equalToConstant: CGFloat(Constants.imageViewWidthConstant)),
            displayImageView.topAnchor.constraint(equalTo: self.titleLabel.topAnchor),
            //set descriptionLabel constraints
            descriptionLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: CGFloat(Constants.gapConstant)),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor,constant: CGFloat(-Constants.marginConstant)),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomLine.topAnchor, constant: CGFloat(-Constants.marginConstant)),
        
            //set bottom line view constraint
            bottomLine.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: CGFloat(-Constants.bottomLineHeightConstant)),
            bottomLine.heightAnchor.constraint(equalToConstant: CGFloat(Constants.bottomLineHeightConstant)),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: displayImageView.bottomAnchor, constant: CGFloat(Constants.marginConstant))
        ])

    }
    
}

