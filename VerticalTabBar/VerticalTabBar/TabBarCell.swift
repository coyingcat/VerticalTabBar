//
//  TabBarCell.swift
//  VerticalTabBar
//
//  Created by Jz D on 2019/8/25.
//  Copyright © 2019 Jz D. All rights reserved.
//

import UIKit

class TabBarCell: UITableViewCell {
    
    open var selectedImageTintColor = UIColor(red: 41.0/255.0, green: 147.0/255.0, blue: 239.0/255.0, alpha: 1.0){
        didSet{
            setNeedsDisplay()
        }
    }
    var icon: UIImage?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.backgroundColor = UIColor.clear
        textLabel?.textColor = UIColor.lightGray
        textLabel?.textAlignment = .center
        textLabel?.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var textLabelFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: textLabel?.font.lineHeight ?? 0)
        textLabelFrame.origin.y = bounds.size.height - textLabelFrame.size.height - 15
        textLabel?.frame = textLabelFrame
        
    }
    
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
         // flip the coordinates system
        context?.translateBy(x: 0, y: bounds.height)
        context?.scaleBy(x: 1, y: -1)
        
        // draw an image in the center of the cell
        guard let imageSize = icon?.size else {
            return
        }
        
        let imageRect = CGRect(x: (bounds.size.width - imageSize.width)/2.0,  y: (bounds.size.height - imageSize.height)/2.0 + 15, width: imageSize.width, height: imageSize.height)
        // draw either a selection gradient/glow or a regular image
        guard isSelected else {
            if let iconImage = icon {
                UIImage(cgImage: iconImage.cgImage!, scale: iconImage.scale, orientation: UIImage.Orientation.down).withHorizontallyFlippedOrientation().draw(in: imageRect)
            }
            return
        }
        
        // setup shadow
        let shadowOffset = CGSize(width: 0, height: 1)
        let shadowBlur: CGFloat = 3
        let cgShadowColor = UIColor.black.cgColor
        // setup gradient
        let alphas: [CGFloat] = [0.8,0.6, 0, 0.1,0.5]
        let locations: [CGFloat] = [0, 0.55, 0.55, 0.7, 1]
        let components: [CGFloat] = [1, 1, 1, alphas[0], 1,
                                     1, 1, alphas[1], 1, 1,
                                     1, alphas[2], 1, 1,1,
                                     alphas[3],1, 1,1,alphas[4]]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let colorGradient = CGGradient(colorSpace: colorSpace, colorComponents: components, locations: locations, count: 5) else {
            return
        }
        // set shadow
        context?.setShadow(offset: shadowOffset, blur: shadowBlur, color: cgShadowColor)
        // set transparency layer and clip to mask
        context?.beginTransparencyLayer(auxiliaryInfo: nil)
        context?.clip(to: imageRect, mask: icon!.cgImage!)
        // fill and end the transparency layer
        context?.setFillColor(selectedImageTintColor.cgColor)
        context?.fill(imageRect)
        let start = CGPoint(x: imageRect.midX, y: imageRect.origin.y)
        let end = CGPoint(x: imageRect.midX - imageRect.height/4, y: imageRect.height + imageRect.minY)
        context?.drawLinearGradient(colorGradient, start: end, end: start, options: [])
        context?.endTransparencyLayer()
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        setNeedsDisplay()
    }
    
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        setNeedsDisplay()
    }
    
}
