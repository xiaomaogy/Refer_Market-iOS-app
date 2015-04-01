//
//  LoginUIViewController.m
//  testproject
//
//  Created by yuan gao on 3/13/15.
//  Copyright (c) 2015 yuan gao. All rights reserved.
//

#import "LoginUIViewController.h"


@implementation LoginUIViewController



-(void)viewDidLoad{
    [super viewDidLoad];
    FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"public_profile",@"email",@"user_friends"]];
    loginView.delegate=self;
    
    loginView.center = CGPointMake(self.view.center.x, self.view.center.y*1.75);
    
    [self.view addSubview:loginView];
    
    self.SeeSavedRefer.hidden=YES;
    
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
    NSLog(@"the fetched user is:%@",user);
    
    self.profilePic.profileID=user.objectID;
    self.username.text=user.name;
}

-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
    NSLog(@"login method notification received");
    self.status.text=@"You're logged in as:";
    self.SeeSavedRefer.hidden=NO;
}

-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
    NSLog(@"logout method notification received");
    self.status.text=@"You're not logged in:";
    self.profilePic.profileID=nil;
    self.username.text=@"anonymous";
    self.SeeSavedRefer.hidden=YES;

}




- (IBAction)SeeSavedReferClicked:(id)sender {
    
    
}
@end
