//
//  MovieDetailViewController.swift
//  CustomTableView
//
//  Created by Dilan Öztürk on 18.02.2023.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieDetailViewController: UIViewController {
    
    var detayFilmAdi = "" // detay sayfasında verileri göstermek için önce gerekli değişkenler oluşturulur
    var resimYolu = ""
    var yonetmen = ""

    @IBOutlet weak var movieDetailImage: UIImageView!
    @IBOutlet weak var movieDetailName: UILabel!
    @IBOutlet weak var createdByLaebl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDetailName.text = detayFilmAdi // değişkenleri outlet lere eşitleriz
        Alamofire.request(resimYolu).responseImage { response in
            if let gelenResimData = response.result.value { // bu kodla arka planda resim yüzbinlerce parçaya bölünür
                print(gelenResimData)
                self.movieDetailImage.image = gelenResimData // burada birleştirilir
            }
        }
        createdByLaebl.text = yonetmen
       
    }
    


}
