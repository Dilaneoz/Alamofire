//
//  ViewController.swift
//  CustomTableView
//
//  Created by Opendart Yazılım ve Bilişim Hizmetleri on 12.02.2023.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
// xml ve json birer dosya formatıdır (ya da web servisi). buradaki bilgiler karışıktır. daha iyi okuyabilmek için jsonviewer gibi programlar kullanılır. web servisten gelen dataya karşılık bir model oluşturmamız gerek. bunu ayrı bir class oluşturup değişkenleri tanımlayarak yaparız ve constructor başlatırız (bu örnekte Movie class ı). daha sonra bilgilerin görüneceği class a gelip (bu örnekte view controller) verilerin geleceği url e talepte bulunulur. buradan gelen datalar da içine önceki oluşturduğumuz class (bu örnekte Movie) tipinde veri alan bir array ile eşleştirilir. sonra ilgili kütüphaneye (bu örnekte alamofire) request fonksiyonuyla talepte bulunulur. bunun sonucunda da bize bir json yanıtı döner. bu url çağırıldığında bize bir array gelir. bu array a karşılık ilgili class ta biz de bir array oluştururuz (içinde string veriler olan bir json array i) (let moviesArray  : NSArray  = json as! NSArray). bu veriler url deki gibi tutulamıyor o yüzden biz bunu ios un anlayacağı nesnelere dönüştürüyoruz (json objesi ios objesine dönüştürülür). Movie nesnesi oluşturulur ve name/team vs değişkenlerini json dan gelen name/team değişkenleriyle eşleştirir (Movie (name: (moviesArray[i] as AnyObject).value(forKey: "name") as? String).

// temel hatlarıyla burada yapılan; servisten gelen datayı al, tableview da göster, oluşturduğun ekrandaki dataları da al, servise tekrar gönder
    @IBOutlet weak var movieTableView: UITableView!
    
    let URL_GET_DATA = "https://simplifiedcoding.net/demos/marvel/"
    
    var filmler = [Movie]() // Movie tipinde veri alan bir array oluşturduk
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //lambda expression closure
        Alamofire.request(URL_GET_DATA).responseJSON{ response in // alamofire kütüphanesini kullanarak ilgili servisten veri çekme talebinde bulunulur
           // print(response.result.value)
            
            if let json = response.result.value {
                
                // bu kodu bu kadar uzun yazmaya gerek yok aslında ama hoca yeni versiyona göre nasıl yazıldığını bulamadı
                let moviesArray  : NSArray  = json as! NSArray // şuanda bu array içinde veri yok. aşağıdaki kodlarla json dan gelen veriler dönüştürülerek array a eklenir
                print(moviesArray)
                
                for i in 0..<moviesArray.count // var olan json array i içinde dön
                {
                    self.filmler.append( // nesneleri aşağıda ios nesnesine dönüştürdükten sonra filmler array ine ekle
                          Movie (name: (moviesArray[i] as AnyObject).value(forKey: "name") as? String, // burada 5 tane Movie tipinde nesne oluşturulur (çünkü json tipindeki nesneler ios a uygun değildi) ve string e çevrilerek Movie array ine eklenir. "moviesArray[i] as AnyObject).value(forKey: "name") as? String" bu kod aslında "Captaion Amerika" ya eşit
                          team: (moviesArray[i] as AnyObject).value(forKey: "team") as? String,
                          imageurl: (moviesArray[i] as AnyObject).value(forKey: "imageurl") as? String,
                          bio: (moviesArray[i] as AnyObject).value(forKey: "bio") as? String,
                          createdby : (moviesArray[i] as AnyObject).value(forKey: "createdby") as? String))

                }
                print(self.filmler)
                self.movieTableView.reloadData() // oluşturulan nesneler tableView a verilir
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filmler.count
    }
    
    // gizli bir for döngüsü var
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! MovieTableViewCell // table view ın içindeki cell e mutlaka bir identifier atamak gerekir. array in içerisindeki her bir obje için bir cell oluşturulur
        
        // verileri servisten çekme
        // let siradakiFilm = self.filmler[indexPath.row]
        // cell.movieName.text = siradakiFilm.name
        // aşağıdaki kodlar yukarıdaki iki kod şeklinde de yazılabilir ama daha uzun
        cell.movieName.text = self.filmler[indexPath.row].name
        cell.movieTeamName.text = self.filmler[indexPath.row].team
        Alamofire.request(self.filmler[indexPath.row].imageurl!).responseImage { response in // resmi ilgili url den download eder
            if let image = response.result.value {
                print(image)
                cell.movieImage.image = image
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("detay tıklandı")
        print(indexPath)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "detay") as? MovieDetailViewController // gitmek istediğimiz sayfadan bir nesne oluşturulur
        
        vc?.detayFilmAdi = self.filmler[indexPath.row].name! // oluşturduğumuz nesneye değer atarız
        vc?.resimYolu = self.filmler[indexPath.row].imageurl ?? "resimyoluyok"
        vc?.yonetmen = self.filmler[indexPath.row].createdby!
        self.navigationController?.pushViewController(vc!, animated: true) // diğer sayfaya geçişi sağlar
    }


}

