//
//  BTNetWorking.m
//  touwho_iPad
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "BTNetWorking.h"




@implementation BTNetWorking

+ (void)getDataWithPara:(NSDictionary *)para success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    [mgr GET:SERVER_API_URL parameters:para success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        success(operation,responseObject);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        failure(operation,error);
    }];
}

+ (id)getUserInfoWithKey:(NSString *)key{
    NSDictionary *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    id value = [user objectForKey:key];
    return value;
}

+ (void)analyzeResponseObject:(id)responseObject andCompletionBlock:(completion)block{
    NSArray *value = [responseObject objectForKey:@"value"];
    NSDictionary *result = [value firstObject];
    NSArray *jsonArr = [result objectForKey:@"jsonArr"];
    NSString *resCode = [result objectForKey:@"resCode"];
    
    block(jsonArr,resCode);
}

+ (CGFloat)calcutateHeightForTextviewWithFont:(UIFont *)font andContent:(NSString *)content andWidth:(CGFloat)width{

    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attribute = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:style};
    NSStringDrawingOptions opts = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGSize textSize = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:opts attributes:attribute context:nil].size;
    return textSize.height + font.lineHeight;
}

+ (BOOL)isUserAlreadyLoginWithAlertView:(UIView *)view{
    if (USER_ID) {
        return  YES;
    }
    else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请登录后再试";
        [hud hide:YES afterDelay:1];
        return NO;
    }
}



+ (void)setupCoreDataAndSaveConversation:(AVIMConversation *)conversation{
    
    //1.  从应用程序包中加载模型文件
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    //2. 传入模型对象，初始化NSPersistentStoreCoordinator
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    //3. 构建SQLite数据库文件的路径
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[filePath stringByAppendingPathComponent:@"conversation.data"]];
    //4.  添加持久化存储库，这里使用SQLite作为存储库
    NSError *error = nil;
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (store == nil) { // 直接抛异常
        [NSException raise:@"添加数据库错误" format:@"%@", [error localizedDescription]];
    }
    //5 初始化上下文，设置persistentStoreCoordinator属性
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    context.persistentStoreCoordinator = psc;
    
    //6.从数据库中查询数据
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Conversation"];
    request.predicate = [NSPredicate predicateWithFormat:@"conversationId CONTAINS %@",conversation.conversationId];
    NSArray *objs = [context executeFetchRequest:request error:nil];
    
    //数据库中没有这个conversationId
    if (objs.count == 0) {
        
        //7. 存入对象
        NSManagedObject *talk = [NSEntityDescription insertNewObjectForEntityForName:@"Conversation" inManagedObjectContext:context];
        [talk setValue:conversation.conversationId forKey:@"conversationId"];
        [talk setValue:conversation.name forKey:@"name"];
        [talk setValue:conversation.lastMessageAt forKey:@"lastMessageAt"];
        [talk setValue:conversation.members forKey:@"members"];
        
        BOOL success = [context save:nil];
        if (success) {
            NSLog(@"成功保存");
        }
        
    }
    //数据库有这个对话就更新它
    else{
        [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSManagedObject *temp = obj;
            [temp setValue:conversation.name forKey:@"name"];
            [temp setValue:conversation.lastMessageAt forKey:@"lastMessageAt"];
            [temp setValue:conversation.members forKey:@"members"];
            
            
        }];
        
        BOOL success = [context save:nil];
        if (success) {
            NSLog(@"更新成功");
        }
    }

    
}
    

+ (NSArray *)withDrawAllConversationFromDatabase{
    
    //1.  从应用程序包中加载模型文件
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    //2. 传入模型对象，初始化NSPersistentStoreCoordinator
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    //3. 构建SQLite数据库文件的路径
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[filePath stringByAppendingPathComponent:@"conversation.data"]];
    //4.  添加持久化存储库，这里使用SQLite作为存储库
    NSError *error = nil;
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (store == nil) { // 直接抛异常
        [NSException raise:@"添加数据库错误" format:@"%@", [error localizedDescription]];
    }
    //5 初始化上下文，设置persistentStoreCoordinator属性
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    context.persistentStoreCoordinator = psc;

    //6.从数据库中查询数据
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Conversation"];

    NSArray *results = [context executeFetchRequest:request error:nil];
    
    return results;
}

+ (void)pullUserInfoFromServerWith:(NSString *)user_id andBlock:(void (^)(ModelForUser *))block{
    NSDictionary *para = @{@"method":@"getMyInfo",@"user_id":user_id};
    [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //json --> model
        NSDictionary *dicModel = [[responseObject objectForKey:@"value"] firstObject];
        
        ModelForUser *model = [ModelForUser objectWithKeyValues:dicModel];
        
        block(model);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
}
+ (void)isQualifiedWithUserID:(NSString *)user_id withResults:(void (^)(BOOL, BOOL))Block{
    NSDictionary *para = @{@"method":@"getMyStatus",@"user_id":user_id};
    [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *isFirstInvestor = [[[responseObject objectForKey:@"value"] firstObject] objectForKey:@"mIsFirstInvestor"];
        NSString *isInvestor = [[[responseObject objectForKey:@"value"] firstObject] objectForKey:@"mIsInvestor"];
        
        BOOL islingtou;
        BOOL isGentou;
        
        if ([isFirstInvestor isEqualToString:@"0"]) {
            islingtou = NO;
        }
        else{
            islingtou = YES;
        }
        
        if ([isInvestor isEqualToString:@"0"]) {
            isGentou = NO;
        }
        else{
            isGentou = YES;
        }
        
        Block(islingtou,isGentou);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

+ (void)sendUserInfoToServerWith:(NSDictionary *)dic andBlock:(void (^)(BOOL))block{
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithObject:@"method" forKey:@"setMyInfo"];
    //添加其他参数
    [para addEntriesFromDictionary:dic];
    [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        block(YES);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(NO);
    }];
}

@end
