//
//  NSString+Expression.h



#import <Foundation/Foundation.h>

@interface NSString (Expression)

#pragma 正则找出@/##/URL/手机号
+ (NSArray *)regularExpressionWithString:(NSString *)string;

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *)telNumber;

#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *)password;

#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIdCard:(NSString *)idCard;

#pragma 正则匹配邮箱
+ (BOOL)checkEmail:(NSString *)email;

#pragma 正则匹配URL
+ (BOOL)checkURL:(NSString *)url;

@end
