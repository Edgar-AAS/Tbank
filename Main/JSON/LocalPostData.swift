import Foundation
import Data

class LocalPostData: HttpPostClient {
    public let fileName: String
    
    public init(fileName: String) {
        self.fileName = fileName
    }
    
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> (Void)) {
        guard let data = data else { return }
        
        do {
            let fileURL = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(fileName)
                
            if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
                print("JSON data appended to file: \(fileURL)")
            }
        } catch {
            print("error")
        }
    }
}
