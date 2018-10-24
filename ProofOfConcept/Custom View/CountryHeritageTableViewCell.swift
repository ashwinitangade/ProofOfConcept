//
//  CountryHeritageTableViewCell.swift
//  ProofOfConcept
//
//  Created by AshwiniT on 24/10/18.
//  Copyright © 2018 Ashwini Tangade. All rights reserved.
//

import UIKit

class CountryHeritageTableViewCell:UITableViewCell{
    var titleLabel:UILabel!
    var descriptionLabel:UILabel!
    var displayImageView:UIImageView!
    var imageHeight:CGFloat!
    var bottomLine:UIView!
    
    func setCell(withItem:CountryHeritage){
        titleLabel.text = withItem.title
        descriptionLabel.text = withItem.desc
        if let image = UIImage(named: withItem.imageHref){
            displayImageView.image = image
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
        displayImageView.contentMode = .scaleAspectFill
        displayImageView.translatesAutoresizingMaskIntoConstraints = false

        // Bottom View constraints added
        bottomLine  = UIView()
        self.contentView.addSubview(bottomLine)
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        
        //set Image view constraint
        let displayImageViewLeadingConstraint = displayImageView.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: CGFloat(Constants.marginConstant))
        let displayImageViewCenterYConstraint = displayImageView.centerYAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.centerYAnchor)

        let displayImageViewTrailingConstraint = displayImageView.trailingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor, constant: CGFloat(-Constants.marginConstant))
        let displayImageViewWidthConstraint = displayImageView.widthAnchor.constraint(equalToConstant: CGFloat(Constants.imageViewWidthConstant))
   
        //set descriptionLabel constraints
        let descriptionLabelLeadingConstraint = descriptionLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor)
        let descriptionLabelBottomConstraint = descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: CGFloat(Constants.marginConstant))
        let descriptionLabelTopConstraint = descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: CGFloat(Constants.gapConstant))
        let descriptionLabelTrailingConstraint = descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor,constant: CGFloat(-Constants.marginConstant))
       
       //set title label constraints
        let titleLabelLeadingConstraint = titleLabel.leadingAnchor.constraint(equalTo: self.displayImageView.trailingAnchor, constant: CGFloat(-Constants.marginConstant))
        let titleLableBottomContraint = titleLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: CGFloat(Constants.gapConstant))
        let titleLabelTopConstraint = titleLabel.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor , constant: CGFloat(Constants.marginConstant))
        
        //set bottom line view constraint
        let bottomLineLeadingConstraint = bottomLine.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor)
        let bottomLineTrailingConstraint = bottomLine.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor)
        let bottomLineTopConstraint = bottomLine.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: CGFloat(Constants.gapConstant))
        let bottomLineBottomConstraint = bottomLine.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: CGFloat(-Constants.bottomLineHeightConstant))
        let bottomLineHeightConstraint = bottomLine.heightAnchor.constraint(equalToConstant: CGFloat(Constants.bottomLineHeightConstant))

        self.contentView.addConstraints([displayImageViewTrailingConstraint,displayImageViewCenterYConstraint,displayImageViewWidthConstraint,displayImageViewLeadingConstraint,descriptionLabelLeadingConstraint,descriptionLabelBottomConstraint,descriptionLabelTopConstraint,descriptionLabelTrailingConstraint,titleLableBottomContraint,titleLabelLeadingConstraint,titleLabelTopConstraint,bottomLineLeadingConstraint,bottomLineTrailingConstraint,bottomLineTopConstraint,bottomLineBottomConstraint,bottomLineHeightConstraint])
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }
}

