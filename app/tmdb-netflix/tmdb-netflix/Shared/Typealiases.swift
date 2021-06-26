//
//  Typealiases.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 26/06/21.
//  
//

import Foundation

typealias ApiSuccessClosure<BR: Codable> = (_ response: BR) -> Void
typealias ErrorClosure = (Error) -> Void
