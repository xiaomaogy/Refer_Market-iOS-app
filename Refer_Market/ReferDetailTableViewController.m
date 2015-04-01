//
//  ReferDetailTableViewController.m
//  testproject
//
//  Created by yuan gao on 3/8/15.
//  Copyright (c) 2015 yuan gao. All rights reserved.
//

#import "ReferDetailTableViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface ReferDetailTableViewController ()

@end

@implementation ReferDetailTableViewController

//This is method is activated when the "Get Referred Button" is clicked
- (IBAction)getReferredButton:(id)sender {
    NSLog(@"referred button being clicked");
    
    NSURL *referlink=[NSURL URLWithString:self.refer.referLink];
    
    if([[UIApplication sharedApplication] canOpenURL:referlink]){
        [[UIApplication sharedApplication] openURL:referlink];
    }
    
    
}

-(void)configureTableView{
    //configure the table view
    
    
    UIImage *referImage=[UIImage imageWithData:self.refer.referImage];
    self.referImageView.image=referImage;
    self.referImageView.contentMode=UIViewContentModeScaleToFill;
    
    self.companyName.text=self.refer.companyName;
    self.referReward.text=self.refer.referReward;
    self.otherInfoText.text=self.refer.otherInfo;
    if(self.referImageView.image==nil){
        self.savedTheReferButton.hidden=YES;
        self.referImageView.image=[UIImage imageNamed:@"collection"];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTableView];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (IBAction)SaveTheRefer:(id)sender {
    NSLog(@"save the refer button clicked");
    
    if (FBSession.activeSession.state == FBSessionStateOpen){
        int errorCode=[[SavedReferDatabase database] insertData:self.refer];
        if(errorCode==5){
            NSLog(@"about to fire an alert view");
            UIAlertView *alreadySavedAlert=[[UIAlertView alloc] initWithTitle:@"Save Failed" message:@"This refer has already been saved." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alreadySavedAlert show];
        }
    }else{
        UIAlertView *notLoggedInAlert=[[UIAlertView alloc] initWithTitle:@"Not Logged In" message:@"You need to login to save a refer. " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [notLoggedInAlert show];
    }
    
    
}

//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 1;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
