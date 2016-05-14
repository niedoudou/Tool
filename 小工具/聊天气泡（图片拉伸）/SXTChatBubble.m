//
//  SXTChatBubble.m



#import "SXTChatBubble.h"
#import "UIImage+Resize.h"

static CGFloat const kLeftMargin = 20; // 文字距离图片左边间距
static CGFloat const kOtherMargin = 10; // 文字距离上、中、下间距

@interface SXTChatBubble()

@property (strong, nonatomic) UILabel *textLab; // 显示文字的lab

@end

@implementation SXTChatBubble

#pragma mark -
#pragma mark init methods
- (UILabel *)textLab
{
    if (!_textLab) {
        _textLab = [[UILabel alloc] initWithFrame:self.bounds];
        _textLab.font = [UIFont systemFontOfSize:16];
        _textLab.numberOfLines = 0;
    }
    return _textLab;
}

#pragma mark -
#pragma mark lifecycle
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置背景图片
        self.image = [UIImage resizedImage:@"qipao" xPos:0.16f yPos:0.7f];
        
        // 添加显示文字Label
        [self addSubview:self.textLab];
    }
    return self;
}


#pragma mark -
#pragma mark 设置显示文字
- (void)setText:(NSString *)text
{
    _text= text;
    // 给textLab设置文字
    _textLab.text = text;
}

#pragma mark -
#pragma mark 计算文字显示的size
- (CGSize)sizeThatFits:(CGSize)size
{
    // 计算一个合适的文字显示size
    CGSize labSize = CGSizeMake(size.width - kLeftMargin - kOtherMargin, MAXFLOAT);
    
    // 根据传入的size返回一个合适的size大小
    CGSize textSize = [_textLab sizeThatFits:labSize];
    
    // 给textLab设置frame
    _textLab.frame = CGRectMake(kLeftMargin, kOtherMargin, textSize.width, textSize.height);
    
    // 计算出当前ImageView的高度和宽度
    CGFloat imageHeight = 2*kOtherMargin + textSize.height;
    CGFloat imageWidth = kLeftMargin + kOtherMargin + textSize.width;
    
    // 返回计算好的size
    return CGSizeMake(imageWidth, imageHeight);
}

@end
