//
//  Store.swift
//  watch-out-app
//
//  Created by Ryan Taylor on 2020/08/30.
//  Copyright © 2020 Ryan Taylor. All rights reserved.
//
import SwiftUI

/**
 설정값들을 UserDefaults를 이용하여 iOS에 저장하고 가져오는 Class 입니다.
 
 없음
 
 - important
 @Published로 인하여 어디서든 수정/조회가 가능하지만 그로인하여 원본 데이터가 의도하지 않게 바뀔 수 있습니다.
 잘 못해서 Bool type아닌 값이나 조회를 할 때 다른 값을 할당하지 않도록 해주세요.
 
 - Author:
 김창윤
 */
class UserDefaultsManager: ObservableObject {
    
    /**
     "불이야" 소음에 대한 설정값 입니다.
     */
    @Published var bulyiyaToggle: Bool = !UserDefaults.standard.bool(forKey: "bulyiya") {
        didSet {
            UserDefaults.standard.set(!self.bulyiyaToggle, forKey: "bulyiya")
            UserDefaults.standard.synchronize()
        }
    }
    
    /**
     "수지" 음성에 대한 설정값 입니다.
     */
    @Published var suzyToggle: Bool = !UserDefaults.standard.bool(forKey: "suzy") {
        didSet {
            UserDefaults.standard.set(!self.suzyToggle, forKey: "suzy")
            UserDefaults.standard.synchronize()
        }
    }
    
    /**
     "yes" 음성에 대한 설정값 입니다.
     */
    @Published var yesToggle: Bool = !UserDefaults.standard.bool(forKey: "yes") {
        didSet {
            UserDefaults.standard.set(!self.yesToggle, forKey: "yes")
            UserDefaults.standard.synchronize()
        }
    }
}
