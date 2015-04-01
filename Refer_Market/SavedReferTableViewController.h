//
//  SavedReferTableViewController.h
//  testproject
//
//  Created by yuan gao on 3/15/15.
//  Copyright (c) 2015 yuan gao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Refer.h"
#import "ReferTableViewCell.h"
#import <sqlite3.h>
#import "SavedReferDatabase.h"
#import "ReferDetailTableViewController.h"

@interface SavedReferTableViewController : UITableViewController

@property (strong,nonatomic) NSMutableArray *referArray;

@end
