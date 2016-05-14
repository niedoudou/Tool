//
//  UIImage+Resize.m


#import "UIImage+Resize.h"

@implementation UIImage (Resize)

#pragma mark 默认从图片中心点开始拉伸图片
+ (UIImage *)resizedImage:(NSString *)imgName
{
    return [self resizedImage:imgName xPos:0.5f yPos:0.5f];
}

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos
{
    UIImage *image = [UIImage imageNamed:imgName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * xPos topCapHeight:image.size.height * yPos];
}

@end
