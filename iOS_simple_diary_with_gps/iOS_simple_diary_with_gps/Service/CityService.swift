//
//  CityService.swift
//  iOS_simple_diary_with_gps
//
//  Created by 김보라 on 9/3/24.
//

import Foundation

import MapKit

protocol CityService {
    func currentCity(lat : Double, lon : Double, completion: @escaping (String?, Error?) -> Void)
}

//https://api.ncloud-docs.com/docs/ai-naver-mapsreversegeocoding-gc


struct NaverMapsCityService : CityService {
    
    struct NaverMapReverseGeocoderResponse : Codable {
        
        var results : [Result]
        
        struct Result : Codable {
            var region : Region
            
            struct Region : Codable {
                
                struct Area1 : Codable {
                    var name : String
                }
                
                var area1 : Area1
            }
        }
        
    }


    func currentCity(lat : Double, lon : Double, completion: @escaping (String?, (any Error)?) -> Void) {
        
        let urlString = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc"
        
        var url = URL(string: urlString)!
        let coords = URLQueryItem(name: "coords", value: "\(lat),\(lon)")
        let geoRequest = URLQueryItem(name: "request", value: "coordsToaddr")
        url.append(queryItems: [geoRequest, coords])

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("bw01df2dz4", forHTTPHeaderField: "X-NCP-APIGW-API-KEY-ID")
        request.addValue("V9N4urPYhb99mNkD805LykueRyiTNCvCi8Be5WQa", forHTTPHeaderField: "X-NCP-APIGW-API-KEY")

        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                completion(nil, error)
                return
            }
            
            guard let data = data else
            {
                print("Error: data is nil")
                completion(nil, error)
                return
            }
            
            guard let output = try? JSONDecoder().decode(NaverMapReverseGeocoderResponse.self, from: data) else {
                 print("Error: JSON Data Parsing failed")
                completion(nil, error)
                 return
             }
              
            completion(output.results.first!.region.area1.name, nil)
            
        }.resume()
        
        //region.area1.name
    }
}

