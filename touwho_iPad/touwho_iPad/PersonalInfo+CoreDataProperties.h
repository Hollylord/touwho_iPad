//
//  PersonalInfo+CoreDataProperties.h
//  touwho_iPad
//
//  Created by apple on 15/11/30.
//  Copyright © 2015年 touhu.com. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PersonalInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonalInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *sex;
@property (nullable, nonatomic, retain) NSString *nickName;
@property (nullable, nonatomic, retain) NSString *phoneNumber;
@property (nullable, nonatomic, retain) NSString *identiCoder;
@property (nullable, nonatomic, retain) NSString *trueName;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *atIndustry;
@property (nullable, nonatomic, retain) NSString *age;
@property (nullable, nonatomic, retain) NSString *interstIndustry;
@property (nullable, nonatomic, retain) NSString *risk;
@property (nullable, nonatomic, retain) NSData *nameCard;

@end

NS_ASSUME_NONNULL_END
