#import <Foundation/Foundation.h>


@interface WPUserLoginModel : NSObject
@property(nonatomic, retain) NSNumber *userId;
@property(nonatomic, retain) NSString *mobile;
@property(nonatomic, retain) NSString *realName;
@property(nonatomic, retain) NSString *avatar;
@property(nonatomic, retain) NSString *refreshToken;
@property(nonatomic, retain) NSString *accessToken;
@property(nonatomic, retain) NSNumber *expiresIn;
@property(nonatomic, retain) NSNumber *refreshTokenExpiresIn;
@property(nonatomic, retain) NSString *nickName;
@end
