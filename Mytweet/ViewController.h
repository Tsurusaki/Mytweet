//
//  ViewController.h
//  Mytweet
//
//  Created by 鶴崎かんな on 2015/02/23.
//  Copyright (c) 2015年 LifeisTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *array;
    IBOutlet UITableView *timelineTableView;
}
-(void)twitterTimeline;

-(IBAction)tweetButton;
-(IBAction)refreshBotton;




@end

