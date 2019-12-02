//
//  ScoreReusableHeader.swift
//  musicSheet
//
//  Created by Jz D on 2019/8/20.
//  Copyright © 2019 上海莫小臣有限公司. All rights reserved.
//

import UIKit


protocol ScoreReusableHeaderDelegate: class{
    func sideMore_come()
}


class ScoreReusableHeader: UICollectionReusableView {
    
    
    weak var delegate: ScoreReusableHeaderDelegate?
    
    @IBOutlet weak var symbol: UIImageView!
    @IBOutlet weak var text: UILabel!
   
    
    
    func config(symbol name: String, title: String, showMore show: Bool){
        text.text = title
       
        symbol.image = UIImage(named: name)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
  
    }
    
}
