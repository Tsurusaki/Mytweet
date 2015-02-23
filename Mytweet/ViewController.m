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

-(IBAction)refrashBotton{
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
                 
                 
                 NSURL *reqestAPI = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/hpme_timeline.json"];
                 
                 NSMutableDictionary *pramaters = [[NSMutableDictionary alloc]init];
                 [pramaters setObject:@"100" forKey:@"count"];
                 [pramaters setObject:@"1" forKey:@"include_entities"];
                 
                 SLRequest *posts = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                       requestMethod:SLRequestMethodGET
                                                                URL:reqestAPI
                                                         parameters:pramaters
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
@end
    //04-08まで終わった//
    

