//
//  PostDetailViewModel.swift
//  iOS_simple_diary_with_gps
//
//  Created by 김보라 on 8/17/24.
//

import Foundation
import Combine

class PostDetailViewModel {
    
    enum Event {
        case postUpdated
        case postReported(Error?)
    }
    
    private var service : PostService
    private var cancellable : Set<AnyCancellable> = []
    private var subject : PassthroughSubject<Event, Never> = PassthroughSubject<Event, Never>()
    var onEvent : AnyPublisher<Event, Never> {
        subject.receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
    
    var post : Post
    
    
    init(service: PostService, post: Post) {
        self.service = service
        self.post = post
        self.service.onPostEvent.sink { event in
            switch event {
            case .postUpdate :
                self.subject.send(.postUpdated)
            }
            
        }.store(in: &cancellable)
    }
    
    
}
