import Foundation

class RecordedAudio {
    var filePathURL: NSURL!
    var title: String!
    
    init(filePathURL: NSURL, title: String) {
        self.filePathURL = filePathURL
        self.title = title
        print(filePathURL)
        print(title)
    }
    
    
}