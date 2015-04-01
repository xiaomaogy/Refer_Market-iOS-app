//
//  SavedSavedReferDatabase.h
//  testproject
//
//  Created by yuan gao on 3/15/15.
//  Copyright (c) 2015 yuan gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Refer.h"

@interface SavedReferDatabase : NSObject{
    sqlite3 *_database;
}

+(SavedReferDatabase*)database;
-(NSArray*)ReferInfos;
-(void)deleteData:(int)uniqueId;
-(int)insertData:(Refer*)refer;


@end