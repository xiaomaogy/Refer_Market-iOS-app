//
//  LoginUIViewController.h
//  testproject
//
//  Created by yuan gao on 3/13/15.
//  Copyright (c) 2015 yuan gao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>


@interface LoginUIViewController : UIViewController<FBLoginViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIButton *SeeSavedRefer;

@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet FBProfilePictureView *profilePic;
- (IBAction)SeeSavedReferClicked:(id)sender;


@end
