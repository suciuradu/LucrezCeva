//
//  UtilExtentions.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 02/01/2019.
//  Copyright © 2019 LucrezCeva. All rights reserved.
//

import UIKit
import Kingfisher

extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
}

extension UIImageView {
    public func fromUrl(_ url: String) {
        let base = "\(ApiContract.Endpoints.BASE_URL)\(url)"
        self.kf.setImage(with:URL.init(string: base))
    }
}
