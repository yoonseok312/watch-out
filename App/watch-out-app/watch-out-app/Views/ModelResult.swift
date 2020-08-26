//
//  ModelResult.swift
//  watch-out-app
//
//  Created by Ryan Taylor on 2020/08/24.
//  Copyright © 2020 Ryan Taylor. All rights reserved.
//

import Foundation

class ModelResult: NSObject {
    @objc dynamic var word = "Watch-out이 듣고 있습니다..."
    
    func update(word: String) {
        self.word = word
    }
}
