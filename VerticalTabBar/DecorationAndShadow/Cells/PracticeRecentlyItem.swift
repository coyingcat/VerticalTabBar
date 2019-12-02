//
//  PracticeRecentlyItem.swift
//  musicSheet
//
//  Created by Jz D on 2019/8/20.
//  Copyright © 2019 上海莫小臣有限公司. All rights reserved.
//

import UIKit


class PracticeRecentlyItem: UICollectionViewCell{

    @IBOutlet weak var audioTag: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var line: UIView!
 
    func config( _ title: String, description: String){
        name.text = title
        detail.text = description
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        
    }

}
