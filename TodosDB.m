//
//  TodosDB.m
//  iHome
//
//  Created by  on 12-7-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "Todos.h"
#import "TodosDB.h"

@implementation TodosDB
@synthesize db;
-(id)init
{
    self = [super init];
    if(self){
        NSString *dbFile = [[NSBundle mainBundle] pathForResource:@"todos" ofType:@"sqlite3"];
        if (sqlite3_open([dbFile UTF8String], &db) != SQLITE_OK) {
            NSLog(@"failed to open db.");
        }
    }
    return self;
}

-(int)getTodosCount
{
    NSString *sql = @"SELECT COUNT(*) FROM todos";
    sqlite3_stmt *pStmt;
    
    sqlite3_prepare_v2(db, [sql UTF8String], -1, &pStmt, nil);
    if (SQLITE_ROW == sqlite3_step(pStmt)) {
        return sqlite3_column_int(pStmt, 0);
    }
    
    return 0;
}

-(NSMutableArray *)getAllTodos
{
    sqlite3_stmt *pStmt;
    NSMutableArray *todosArray = [[NSMutableArray alloc] init];
    NSString *sql = @"SELECT * FROM todos;";
    sqlite3_prepare_v2(db, [sql UTF8String], -1, &pStmt, nil);
    while (SQLITE_ROW == sqlite3_step(pStmt)) {
        int uniqueId = sqlite3_column_int(pStmt, 0);
        NSString *title = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(pStmt, 1)];
        NSString *content = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(pStmt, 2)];
        NSDateFormatter *formate = [[NSDateFormatter alloc] init];
        [formate setDateFormat:@"yyyy-MM-dd"];
        NSDate *enddate= [formate dateFromString:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(pStmt, 3)]];
        Todos *todos = [[Todos alloc] initWithUniqueId:uniqueId title:title content:content enddate:enddate];
        [todosArray addObject:todos];
        /*
        [formate release];
        [title release];
        [content release];
        [todos release];
         */
    }
    sqlite3_finalize(pStmt);
    return todosArray;
}

-(void)removeTodos:(Todos *)todos
{
    if(nil != todos){
        char *szError = 0;
        NSString *sql = [[NSString alloc] initWithFormat:@"delete from todos where key = %d;", todos.uniqueId];
        int nResult = sqlite3_exec(db, [sql UTF8String], 0, 0, &szError);
        if (nResult != SQLITE_OK) {
            NSLog(@"delete failed.");
        }
        sql = nil;
    }
}

-(void)addTodos:(Todos *)todos
{
    if (nil != todos) {
        char *szError = 0;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *sql = [[NSString alloc]
                         initWithFormat:@"INSERT INTO todos (title, content, enddate) VALUES ('%@', '%@', '%@');", 
                         todos.title,
                         todos.content,
                         [dateFormatter stringFromDate:todos.enddate]];
        
        int nResult = sqlite3_exec(db, [sql UTF8String], 0, 0, &szError);
        if (nResult != SQLITE_OK) {
            NSLog(@"add failed");
        }
        sql = nil;
    }

}

@end
