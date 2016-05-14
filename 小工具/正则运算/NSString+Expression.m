//
//  NSString+Expression.m



#import "NSString+Expression.h"
/*
 URL:((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)
 ##:(#[\u4e00-\u9fa5A-Z0-9a-z(é|ë|ê|è|à|â|ä|á|ù|ü|û|ú|ì|ï|î|í)._-]+#)
 @:(@([\u4e00-\u9fa5A-Z0-9a-z(é|ë|ê|è|à|â|ä|á|ù|ü|û|ú|ì|ï|î|í)._-]+))
 手机号：\\d{3}-\\d{8}|\\d{3}-\\d{7}|\\d{4}-\\d{8}|\\d{4}-\\d{7}|1+[358]+\\d{9}|\\d{8}|\\d{7}
 */
// 检查URL/@/##/手机号
static NSString *const kPattern = @"(@([\u4e00-\u9fa5A-Z0-9a-z(é|ë|ê|è|à|â|ä|á|ù|ü|û|ú|ì|ï|î|í)._-]+))|(#[\u4e00-\u9fa5A-Z0-9a-z(é|ë|ê|è|à|â|ä|á|ù|ü|û|ú|ì|ï|î|í)._-]+#)|((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|\\d{3}-\\d{8}|\\d{3}-\\d{7}|\\d{4}-\\d{8}|\\d{4}-\\d{7}|1+[358]+\\d{9}|\\d{8}|\\d{7}";

@implementation NSString (Expression)

// 正则表达式
+ (NSArray *)regularExpressionWithString:(NSString *)string
{
    // 初始化一个数组
    NSMutableArray *array = [NSMutableArray array];
    // 根据匹配条件,创建了一个正则表达式(@、#、url和手机号码)
    /*
     NSRegularExpressionCaseInsensitive             = 1 << 0, //不区分字母大小写的模式
     NSRegularExpressionAllowCommentsAndWhitespace  = 1 << 1, //忽略掉正则表达式中的空格和#号之后的字符
     NSRegularExpressionIgnoreMetacharacters        = 1 << 2, //将正则表达式整体作为字符串处理
     NSRegularExpressionDotMatchesLineSeparators    = 1 << 3, //允许.匹配任何字符，包括换行符
     NSRegularExpressionAnchorsMatchLines           = 1 << 4, //允许^和$符号匹配行的开头和结尾
     NSRegularExpressionUseUnixLineSeparators       = 1 << 5, //设置\n为唯一的行分隔符，否则所有的都有效。
     NSRegularExpressionUseUnicodeWordBoundaries    = 1 << 6 //使用Unicode TR#29标准作为词的边界，否则所有传统正则表达式的词边界都有效
     */
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:kPattern options:NSRegularExpressionCaseInsensitive error:nil];
    // block遍历
    /*
     NSMatchingReportProgress         = 1 << 0, //找到最长的匹配字符串后调用block回调
     NSMatchingReportCompletion       = 1 << 1, //找到任何一个匹配串后都回调一次block
     NSMatchingAnchored               = 1 << 2, //从匹配范围的开始出进行极限匹配
     NSMatchingWithTransparentBounds  = 1 << 3, //允许匹配的范围超出设置的范围
     NSMatchingWithoutAnchoringBounds = 1 << 4  //禁止^和$自动匹配行还是和结束
     */
    [regex enumerateMatchesInString:string options:NSMatchingReportProgress | NSMatchingReportCompletion range:NSMakeRange(0, string.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        // 把NSRange转化为NSValue
        NSValue *value = [NSValue valueWithRange:result.range];
        [array addObject:value];
    }];
    return array;
}

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *)telNumber
{
    NSString *pattern = @"\\d{3}-\\d{8}|\\d{3}-\\d{7}|\\d{4}-\\d{8}|\\d{4}-\\d{7}|1+[358]+\\d{9}|\\d{8}|\\d{7}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}

#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *)password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

#pragma 正则匹配邮箱
+ (BOOL)checkEmail:(NSString *)email
{
    NSString *pattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:email];
    return isMatch;
}

#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIdCard:(NSString *)idCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

#pragma 正则匹配URL
+ (BOOL)checkURL:(NSString *)url
{
    NSString *pattern = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
}


@end
