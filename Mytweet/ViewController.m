//
//  ViewController.m
//  Mytweet
//
//  Created by 鶴崎かんな on 2015/02/23.
//  Copyright (c) 2015年 LifeisTech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(IBAction)tweetButton
{
    SLComposeViewController *twitterPostViewController = [SLComposeViewController
                                                          composeViewControllerForServiceType:SLServiceTypeTwitter];
    [self presentViewController:twitterPostViewController animated:YES completion:nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self twitterTimeline];
    
}

-(IBAction)refrashButton{
    [self twitterTimeline];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)twitterTimeline{
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType =[account
accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [account requestAccessToAccountsWithType:accountType
                                     options:nil
                                  completion:^(BOOL granted, NSError *error) 
     {
         if(granted == YES) {
             NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
             if([arrayOfAccounts count] > 0) {
                 ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                 
                 
                 NSURL *reqestAPI = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"];
                 
                 NSMutableDictionary *paramaters = [[NSMutableDictionary alloc]init];
                 [paramaters setObject:@"100" forKey:@"count"];
                 [paramaters setObject:@"1" forKey:@"include_entities"];
                 
                 SLRequest *posts = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                       requestMethod:SLRequestMethodGET
                                                                 URL:reqestAPI
                                                          parameters:paramaters
                                     ];
                                     
                                     posts.account = twitterAccount;
                                     
                                     [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                 
                 [posts performRequestWithHandler:
                  ^(NSData *response, NSHTTPURLResponse *urlResponse, NSError *error)
                  {
                      array = [NSJSONSerialization JSONObjectWithData:response
                                                              options:NSJSONReadingMutableLeaves
                                                                error:&error];
                      if (array.count != 0) {
                          dispatch_async(dispatch_get_main_queue(),^{
                              [timelineTableView reloadData];
                          });
                      }
                  }];
                 [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                 
                 
             }
         } else {
             NSLog(@"%@", [error localizedDescription]);
             
         }
     }];
    
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableview{
    return 1;
    }
    
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{retern [arry count];
    }
    
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath;(NSIndexPath *)indexPath:(NSIndexPath *)indexPath{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
        UITextView *TweetTextView = (UITextView *)[cell viewWithTag:3];
        UILabel *userLabel = (UILabel *)[cell viewWithTag:1];
        UILabel *userIDLabel = (UILabel *)[cell viewWithTag:2];
        UIImageView *UserImageView = (UIImageView *)cell viewWithTag:4];
        NSDictionary *tweet = array[indexPath.row];
        NSDictionary *userInfo = tweet[@"user"];
        
        tweetTaxtView.text = [NSString stringWithFormat:@"%@",tweet[@"text"]];
        userLabel.text = [NSString stringWithFormat:@"%@",userInfo[@"name"]];
        userIDLabel.text = [NSString stringWithFormat:@"@%@",userInfo[@"screen_name"]];
        
        NSString *UserImagePath = userInfo[@"profile_image_url"];
        NSURL *UserImaegPathUrl = [[NSURL alloc] initWithString:userImagePath];
        NSData *userImagePathData = [[NSData alloc] initWithContentsOfURL:userImagePathUrl];
        userImageView.image = [[[UIImage alloc]] initWithData:userImagePathData];
        return cell;
    {
@end
    
    

