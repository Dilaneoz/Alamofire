//
//  Movie.swift
//  CustomTableView
//
//  Created by Opendart Yazılım ve Bilişim Hizmetleri on 12.02.2023.
//

import Foundation

class Movie {
    
    var name : String? // optional
    var team : String? // web servisinden verileri alabilmek için ilk yapılması gereken bir class oluşturup almak istediğimiz dataların değişkenlerini oluşturmaktır
    var imageurl : String?
    var bio : String?
    var createdby : String?
    
    // class ta oluşturduğumuz değişkenlere değer atamak istiyorsak bir constructor tanımlarız. json daki nesnelerle ios nesnelerini eşleştirmeyi bu şekilde sağlarız
    init(name: String? = nil, team: String? = nil, imageurl: String? = nil, bio: String? = nil, createdby: String? = nil) {
        self.name = name
        self.team = team
        self.imageurl = imageurl
        self.bio = bio
        self.createdby = createdby
    }
}
