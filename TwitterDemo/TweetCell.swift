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
            
            nameLabel.text = tweet.user!.name! as String
            usernameLabel.text = "@\(tweet.user!.screenname!)"
            tweetLabel.text = tweet.text as! String
            likesLabel.text = "\(tweet.favortiesCount)"
            retweetLabel.text = "\(tweet.retweetCount)"
            profilephotoView.setImageWithURL((tweet.user!.profileUrl)!)
           
            /* nameLabel.text = business.name
            thumbImageView.setImageWithURL(business.imageURL!)
            categoriesLabel.text = business.categories
            addressLabel.text = business.address
            reviewsCountLabel.text = "\(business.reviewCount!) Reviews"
            ratingImageView.setImageWithURL(business.ratingImageURL!)
            distanceLabel.text = business.distance
            */
            
            
            
            id = tweet.num
            
           // created.text = tweetTime(tweet.timestamp!.timeIntervalSinceNow)
        }
    }
    
 @IBAction func onLike(sender: AnyObject) {
        TwitterClient.sharedInstance.Favorite(Int(id)!, params: nil, completion: {(error) -> () in
            self.likesButton.setImage(UIImage(named: "like"), forState: UIControlState.Normal)
            self.likesLabel.text = String(self.tweet.favortiesCount + 1)
        })    }
    
    
  @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.Retweet(Int(id)!, params: nil, completion: {(error) -> () in
            self.retweetButton.setImage(UIImage(named: "retweet"), forState: UIControlState.Normal)
            self.retweetLabel.text = String(self.tweet.retweetCount + 1)
        })
    
    }
    
func tweetTime(time: NSTimeInterval) -> String
    {
        var given_time = -Int(time)
        var timeCalc: Int = 0
        
        print("given_time: \(given_time)")
        
        if given_time == 0
        {
            return "Now"
        }
        else if given_time <= 60
        {
            return "\(given_time)s"
        }
        else if (given_time/60 <= 60)
        {
            timeCalc = given_time/60
            return "\(timeCalc)m"
        }
        else if (given_time/3600 <= 24)
        {
            timeCalc = given_time/3600
            return "\(timeCalc)h"
        }
        else if (given_time/(3600*24) <= 365)
        {
            timeCalc = given_time/(3600*24)
            return "\(timeCalc)d"
        }
        else
        {
            timeCalc = given_time/(3600*24*365)
            return "\(timeCalc)y"
        }
        
        return "\(timeCalc)"
        
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
