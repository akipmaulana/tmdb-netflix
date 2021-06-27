//
//  Typealiases.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 26/06/21.
//  
//

import UIKit

typealias ApiSuccessClosure<BR: Codable> = (_ response: BR) -> Void
typealias ErrorClosure = (Error) -> Void
typealias LoadableReusableView = NibLoadableView & ReusableView
typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)
