//
//  TodosDB.h
//  iHome
//
//  Created by  on 12-7-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "/usr/include/sqlite3.h"

@class Todos;

@interface TodosDB : NSObject{
    sqlite3 *db;
}
@property(nonatomic,assign)sqlite3 *db;

-(int)getTodosCount;
-(NSMutableArray *)getAllTodos;
-(void)removeTodos:(Todos *)todos;
-(void)addTodos:(Todos *)todos;
@end
