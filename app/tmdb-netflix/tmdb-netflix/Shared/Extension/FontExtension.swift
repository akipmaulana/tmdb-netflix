//
//  FontExtension.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import UIKit

extension UIFont {
    
    open class func sourceSansProBold(size: CGFloat) -> UIFont {
        return UIFont(name: "SourceSansPro-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    open class func sourceSansProSemiBold(size: CGFloat) -> UIFont {
        return UIFont(name: "SourceSansPro-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    open class func sourceSansProRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "SourceSansPro-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    open class func sourceSansProLight(size: CGFloat) -> UIFont {
        return UIFont(name: "SourceSansPro-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

extension CGFloat {
    
    static var h2: CGFloat {
        return 60
    }
    
    static var h3: CGFloat {
        return 48
    }
    
    static var h4: CGFloat {
        return 34
    }
    
    static var h5: CGFloat {
        return 24
    }
    
    static var h6: CGFloat {
        return 20
    }
    
    static var title: CGFloat {
        return 18
    }
    
    static var subtitle1: CGFloat {
        return 16
    }
    
    static var subtitle2: CGFloat {
        return 14
    }
    
    static var body: CGFloat {
        return 14
    }
    
    static var button: CGFloat {
        return 14
    }
    
    static var caption: CGFloat {
        return 12
    }
    
    static var overline: CGFloat {
        return 10
    }
    
    static var tiny: CGFloat {
        return 6
    }
}
