//
//  Network.swift
//  HealthKit-Practice
//
//  Created by SHIN YOON AH on 2021/12/05.
//

import Foundation
import HealthKit

class Network {
    
    // MARK: - Sending Data
    
    class func push(addedSamples: [HKObject]? = nil, deletedSamples: [HKDeletedObject]? = nil) {
        if let samples = addedSamples, !samples.isEmpty {
            pushAddedSamples(samples)
        }
        
        if let deletedSamples = deletedSamples, !deletedSamples.isEmpty {
            pushDeletedSamples(deletedSamples)
        }
    }
    
    class func pushAddedSamples(_ objects: [HKObject]) {
        var statusDictionary: [String: Int] = [:]
        
        objects.forEach { object in
            guard let sample = object as? HKSample else {
                print("We don't support pushing non-sample objects at this time!")
                return
            }
            
            let identifier = sample.sampleType.identifier
            
            if let value = statusDictionary[identifier] {
                statusDictionary[identifier] = value + 1
            } else {
                statusDictionary[identifier] = 1
            }
        }
        
        print("Pushing \(objects.count) new samples to server!")
        print("Samples:", statusDictionary)
    }
    
    class func pushDeletedSamples(_ samples: [HKDeletedObject]) {
        print("Pushing \(samples.count) deleted samples to server!")
        print("Samples:", samples)
    }
    
    // MARK: - Receiving Data
    
    class func pull(completion: @escaping (ServerResponse) -> Void) {
        print("Pulling data from the server!")
        print("Loading mock server response.")
        let response = loadMockServerResponse()
        
        completion(response)
    }
    
    private class func loadMockServerResponse() -> ServerResponse {
        let pathName = "MockServerResponse"
        
        guard
            let file = Bundle.main.url(forResource: pathName, withExtension: "json"),
            let data = try? Data(contentsOf: file)
        else {
            fatalError("Could not load file \(pathName).json!")
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let serverResponse = try decoder.decode(ServerResponse.self, from: data)
            return serverResponse
        } catch {
            fatalError("Could not decode ServerResponse!")
        }
    }
}
