//
//  SavedSavedReferDatabase.m
//  testproject
//
//  Created by yuan gao on 3/15/15.
//  Copyright (c) 2015 yuan gao. All rights reserved.
//
#import "SavedReferDatabase.h"

@implementation SavedReferDatabase
static SavedReferDatabase *_database;

+(SavedReferDatabase*)database{
    
    _database = [[SavedReferDatabase alloc]init];
   
    return _database;
}

- (NSString *)databasefilePath {
    NSString *applicationSupport = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES)[0];
    NSString *applicationFolder = [applicationSupport stringByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]];
    return [applicationFolder stringByAppendingPathComponent:@"savedrefer_list2.sqlite3"];
}

- (NSString*)openDB {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *destinationPath = [self databasefilePath];
    
    if (![fileManager fileExistsAtPath:destinationPath]) {
        NSError *error;
        if (![fileManager createDirectoryAtPath:[destinationPath stringByDeletingLastPathComponent] withIntermediateDirectories:TRUE attributes:nil error:&error]) {
            NSLog(@"%s: createDirectoryAtPath error: %@", __FUNCTION__, error);
        }
        
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"savedrefer_list2" ofType:@"sqlite3"];
        if (![fileManager copyItemAtPath:sourcePath toPath:destinationPath error:&error]) {
            NSLog(@"%s: copyItemAtPath error: %@", __FUNCTION__, error);
        }
    }
    return destinationPath;
}

- (id)init {
    
    if ((self = [super init])) {
        NSString *sqLiteDb=[self openDB];
        NSLog(@"Now reading saved refer's database,path is:%@",sqLiteDb);
        
        if (sqlite3_open([sqLiteDb UTF8String], &_database) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
        }
    }
    return self;
}

- (void)dealloc {
    sqlite3_close(_database);
}



-(int)execSql:(NSString*)sql{
        char *err;
        if (sqlite3_exec(_database, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
            NSString *notUniqueError=@"PRIMARY KEY must be unique";
            
            if([notUniqueError isEqualToString:[NSString stringWithUTF8String:err]]){
                NSLog(@"not unique error");
                return 5;
            }
            NSLog(@"failed to operate on savedreferdatabase");
        }else{
            NSLog(@"%@ operated",sql);
        }
    return 0;
}

-(void)deleteData:(int)uniqueId{
    NSString *sdeleteSql=[NSString stringWithFormat:@"DELETE FROM %@ WHERE %@=%d", @"refer_list", @"uniqueId", uniqueId];
    NSLog(@"%@ is the sql command",sdeleteSql);
    [self execSql:sdeleteSql];
    
}

-(int)insertData:(Refer*)refer{
    NSString *insertSql = [NSString stringWithFormat: @"INSERT INTO refer_list (uniqueId, companyName, referReward, otherInfo, referLink) VALUES (%d, '%@', '%@','%@','%@')", refer.uniqueId, refer.companyName,refer.referReward,refer.otherInfo,refer.referLink];
    int errorCode=[self execSql:insertSql];
    return errorCode;
    
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

