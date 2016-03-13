//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Andrew Rivera on 3/12/16.
//  Copyright © 2016 Andrew Rivera. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profilephotoView: UIImageView!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likesButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetLabel: UILabel!
    
    var id: String = ""
    
    var tweet: Tweet!
        {
        didSet{
            nameLabel.text = tweet.name
            usernameLabel.text = tweet.username
            tweetLabel.text = tweet.tweet
            likesLabel.text = tweet.likes
            retweetLabel.text = tweet.retweet
            profilephotoView.setImageWithURL(tweet.profilephotoURL!)
            
            
           /* nameLabel.text = business.name
            thumbImageView.setImageWithURL(business.imageURL!)
            categoriesLabel.text = business.categories
            addressLabel.text = business.address
            reviewsCountLabel.text = "\(business.reviewCount!) Reviews"
            ratingImageView.setImageWithURL(business.ratingImageURL!)
            distanceLabel.text = business.distance
            */
            
            
            
            id = tweet.num
            
            dateLabel.text = tweetTime(tweet.timestamp!.timeIntervalSinceNow)
        }
    }
    
    @IBAction func onLike(sender: AnyObject) {
        TwitterClient.sharedInstance.Fav(Int(id)!, params: nil, completion: {(error) -> () in
            self.likesButton.setImage(UIImage(named: "like"), forState: UIControlState.Normal)
            self.likesLabel.text = String(self.tweet.favCount + 1)
        })    }
    
    
    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.RT(Int(id)!, params: nil, completion: {(error) -> () in
            self.retweetButton.setImage(UIImage(named: "retweet"), forState: UIControlState.Normal)
            self.retweetLabel.text = String(self.tweet.retweetCount + 1)
        })
    
    }
    
    func tweetTime(time: NSTimeInterval) -> String
    {
        var timegiven = -Int(time)
        var timecalc: Int = 0
        
        print("timegiven: \(timegiven)")
        
        if timegiven == 0
        {
            return "Now"
        }
        else if timegiven <= 60
        {
            return "\(timegiven)s"
        }
        else if (timegiven/60 <= 60)
        {
            timecalc = timegiven/60
            return "\(timecalc)m"
        }
        else if (timegiven/3600 <= 24)
        {
            timecalc = timegiven/3600
            return "\(timecalc)h"
        }
        else if (timegiven/(3600*24) <= 365)
        {
            timecalc = timegiven/(3600*24)
            return "\(timecalc)d"
        }
        else
        {
            timecalc = timegiven/(3600*24*365)
            return "\(timecalc)y"
        }
        
        return "\(timecalc)"
        
    }
    
    
override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
