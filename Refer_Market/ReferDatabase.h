//This is a class used to load the refer information from the local refer_list.sqlite3 database

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Refer.h"

@interface ReferDatabase : NSObject{
    sqlite3 *_database;
}

+(ReferDatabase*)database;
-(NSArray*)ReferInfos;



@end
