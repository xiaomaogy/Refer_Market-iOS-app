//
//  ReferDatabase.m
//  testproject
//
//  Created by yuan gao on 3/4/15.
//  Copyright (c) 2015 yuan gao. All rights reserved.
//

#import "ReferDatabase.h"

@implementation ReferDatabase
static ReferDatabase *_database;

+(ReferDatabase*)database{
    if(_database==nil){
        _database = [[ReferDatabase alloc]init];
        
    }
    
    return _database;
}

- (id)init {
    
    if ((self = [super init])) {
        NSString *sqLiteDb = [[NSBundle mainBundle] pathForResource:@"refer_list"
                                                             ofType:@"sqlite3"];
        NSLog(@"Now reading refer's database, path is %@",sqLiteDb);
        
        if (sqlite3_open([sqLiteDb UTF8String], &_database) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
        }
    }
    return self;
}

- (void)dealloc {
    sqlite3_close(_database);
}



//This method loads the local sqlite database into the NSArray* Referinfos
-(NSArray*)ReferInfos{
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    NSString *query = @"SELECT uniqueId, companyName, referReward, otherInfo, referLink, referImage FROM refer_list ORDER BY uniqueId ASC";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil)
        == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int uniqueId = sqlite3_column_int(statement, 0);
            char *companyNameChars = (char *) sqlite3_column_text(statement, 1);
            char *referRewardChars = (char *) sqlite3_column_text(statement, 2);
            char *otherInfoChars = (char *) sqlite3_column_text(statement, 3);
            char *referLinkChars = (char *) sqlite3_column_text(statement, 4);
            NSString *companyName = [[NSString alloc] initWithUTF8String:companyNameChars];
            NSString *referReward = [[NSString alloc] initWithUTF8String:referRewardChars];
            NSString *otherInfo = [[NSString alloc] initWithUTF8String:otherInfoChars];
            NSString *referLink = [[NSString alloc] initWithUTF8String:referLinkChars];
            NSUInteger blobLength = sqlite3_column_bytes(statement, 5);
            NSData *imageData=[[NSData alloc] initWithBytes:sqlite3_column_blob(statement, 5) length:blobLength];
            
            Refer *info=[Refer initWithUniqueId:uniqueId companyName:companyName reward:referReward otherInfo:otherInfo referLink:referLink referImage:imageData];
            
            [retval addObject:info];
        }
        sqlite3_finalize(statement);
    }
    return retval;
}


@end
