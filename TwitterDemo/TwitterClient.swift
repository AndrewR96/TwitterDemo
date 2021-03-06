//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Andrew Rivera on 2/27/16.
//  Copyright © 2016 Andrew Rivera. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "LRdogj0dilxrmMxhqe7Zsv0SO", consumerSecret: "iXgsnkl1eEGANngqm3DLamwcqfL5jMinA5HceJcGYnyP50xiCo")

    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    
    func homeTimeLine(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: {(task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            
            },  failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
        
        
    }
    
    func handleOpenUrl(url: NSURL){
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: {(accessToken: BDBOAuth1Credential!) -> Void in
            
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
            })
        }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    
    
    }
    
    func login(success: () -> (),failure: (NSError) -> ()){
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            let url  = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
    
    
    NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()){
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask,response: AnyObject?) -> Void in
            print("account: \(response)")
            let userDictionary = response as! NSDictionary
            // print("user: \(user)")
            
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            /*print("name: \(user.name)")
            print("screenname: \(user.screenname)")
            print("profile url: \(user.profileUrl)")
            print("despription: \(user.tagline)")*/
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
        
    }
    
    func Retweet(num: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/statuses/retweet/\(num).json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            completion(error: nil)
            print ("Retweet the tweet")
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                completion(error: error)
            }
        )
    }
    
    func Favorite(num: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/favorites/create.json?id=\(num)", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            completion(error: nil)
            print ("The tweet is favoirted")
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                completion(error: error)
            }
    )}
}
