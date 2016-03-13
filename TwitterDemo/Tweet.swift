//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Andrew Rivera on 2/27/16.
//  Copyright © 2016 Andrew Rivera. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favortiesCount: Int = 0
    var user: User?
    var num: String
    var timeString: String?
    
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favortiesCount = (dictionary["favorites_count"] as? Int) ?? 0
        num = String(dictionary["id"]!)
        user = User(dictionary: dictionary ["user"] as! NSDictionary)
        timeString = dictionary["created_at"] as? String
        
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString{
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
        }
    }
        class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
            var tweets = [Tweet]()
            
            for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
                tweets.append(tweet)
        }
    
    return tweets

}

}

