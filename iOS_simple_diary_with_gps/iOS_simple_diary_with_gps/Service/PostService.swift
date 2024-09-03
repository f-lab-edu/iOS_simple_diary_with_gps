//
//  PostService.swift
//  iOS_simple_diary_with_gps
//
//  Created by 김보라 on 7/30/24.
//

import Foundation
import Combine
import CoreLocation

enum PostEvent {
    case postUpdate
}

protocol PostService {
    
    var onPostEvent : AnyPublisher<PostEvent, Never> { get }
    var posts : [Post] { get }
    
    func loadPost(date : Date?, page : Int) // Date, page 파라미터 추가, //유저가 선택하는 정보
    func addPost(contents: String, completion: @escaping (Error?) -> Void) // contents
    func removePost(postId : String, completion: @escaping (Error?) -> Void) // postId
    func reportPost(postId: String, completion: @escaping (Error?) -> Void) // postId
}

class PostServiceImp : PostService {
    
    
    var onPostEvent: AnyPublisher<PostEvent, Never> {
        subject.eraseToAnyPublisher()
    }
    
    var posts: [Post] = []
    private var currentPage : Int = 0
    let userId : String = "mockdata" // 모듈화시키기
    var gpsService = GPSServiceImp()
    var cityService = NaverMapsCityService()
    
    let repository : PostRepository = FirebasePostRepository()
    let subject : PassthroughSubject<PostEvent, Never> = PassthroughSubject<PostEvent, Never>() //CurrentValueSubject 마지막으로 보낸 값을 들고 있음, PassthroughSubject
    //데이터를 리스트로 다 보낼 필요가 있는가!
    
    func loadPost(date : Date? = Date(), page : Int) {
        
        repository.loadPosts(){ [weak self] posts, error in
            if error == nil {
                self?.posts = posts
                self?.subject.send(.postUpdate)
            }
        }
        
        // date, gps, page

    }
    
    func addPost(contents: String, completion: @escaping (Error?) -> Void) {
        
        let currentDate = Date()
        self.gpsService.requestLocationPermission()
        
        let location = self.gpsService.currentLocation()
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        
        self.cityService.currentCity(lat: lat, lon: lon) { cityName, error in
            
            let cityName = cityName ?? "성남"
            
            let newPost = Post(city: cityName, contents: contents, createdDate: currentDate, location: Post.Coordinate.init(long: lon, lat: lat))
            
            
            self.repository.addPost(post: newPost) { [weak self] error in
                if error == nil, let `self` = self {
                    self.loadPost(page: self.currentPage)
                }
                completion(error)
                
            }
        }
    }
    
    func removePost(postId: String, completion: @escaping (Error?) -> Void) {
        repository.removePost(postId: postId) { [weak self]  error in
            if error == nil, let `self` = self {
                self.loadPost(page: self.currentPage)
            }
            completion(error)
        }
    }
    
    func reportPost(postId: String, completion: @escaping (Error?) -> Void) {
        repository.reportPost(postId: postId) { error in
            completion(error)
        }
    }
    
    
}
