//
//  PostWriteViewModel.swift
//  iOS_simple_diary_with_gps
//
//  Created by 김보라 on 9/4/24.
//

import Foundation
import Combine

class PostWriteViewModel {
   
    enum Event {
        case postUpdated
        case postAdded(Error?)
    }
    
    private var service : PostService
    private var cancellable : Set<AnyCancellable> = []
    private var subject : PassthroughSubject<Event, Never> = PassthroughSubject<Event, Never>()
    
    var onEvent : AnyPublisher<Event, Never> {
        subject.receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
    
    var post : Post?
    
    init(service: PostService, post: Post?) {
        self.post = post
        self.service = service
        self.service.onPostEvent.sink { event in
            switch event {
            case .postUpdate :
                self.subject.send(.postUpdated)
            }
            
        }.store(in: &cancellable)
    }
    
    
    func addPost(contents : String) {
        service.addPost(contents: contents) { [weak self] error in
            self?.subject.send(.postAdded(error))
        }
    }
    
    
}
