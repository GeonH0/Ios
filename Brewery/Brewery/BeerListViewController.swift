//
//  BeerListViewController.swift
//  Brewery
//
//  Created by 김건호 on 2023/07/28.
//

import UIKit

class BeerListViewController : UITableViewController {
    var beerList = [Beer]()
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UiNavigationBar
        title = "브루어리"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //UITableView 설정
        
        tableView.register(BeerListCell.self, forCellReuseIdentifier: "BeerListCell")
        tableView.rowHeight = 150
        
        fetchBeer(of: currentPage)
    }
    
}


//UITableView DataSource,Delegate
extension BeerListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListCell", for: indexPath) as! BeerListCell
                
                
        let beer = beerList[indexPath.row]
        cell.configure(with: beer)
        return cell
        
                
                
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBeer = beerList[indexPath.row]
        let detailViewContorller = BeerDetailViewController()
        
        detailViewContorller.beer = selectedBeer
        self.show(detailViewContorller,sender: nil)
    }
}

//Data Fetching
private extension BeerListViewController {
    func fetchBeer(of page: Int)  {
        
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?=page\(page)") else { return }
        
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) {[weak self] data,response,error in
            guard error == nil,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let beers = try? JSONDecoder().decode([Beer].self, from: data) else {
                print("ERROR: URLSession data task \(error?.localizedDescription ?? "")")
                return
                  }
            
            switch response.statusCode {
            case (200...299)://성공
                self.beerList += beers
                self.currentPage += 1
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case (400...499): //클라이언트 에러
                print("""
                    ERROR: Client ERROR\(response.statusCode)
                    Response: \(response)
                """)
            case(500...599): //서버 에러
                print("""
                    ERROR: Serever ERROR\(response.statusCode)
                    Response: \(response)
                """)
            default:
                print("""
                    ERROR:\(response.statusCode)
                    Response: \(response)
                """)
            }
                    
          }
        dataTask.resume()
    }
    
}
