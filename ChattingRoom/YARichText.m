//
//  YARichText.m
//  ChattingRoom
//
//  Created by wind on 5/5/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import "YARichText.h"
#import <CoreText/CoreText.h>
#import "YARegularExpression.h"
#import "NSArray+YAExtension.h"
#import "NSString+YAExtension.h"



#define NSLog(...) {}                       // If debug add "//" behind


#define AttributedImageNameKey      @"ImageName"

// 空格
#define PlaceHolder     @" "

// 正则表达式匹配
#define EmotionItemPattern          @"\\[[\\u4e00-\\u9fa5\\w]{1,2}\\]"

// 内容字体
#define kContentFontSize            20

// 内容宽度
#define kContentTextWidth           200

// 表情宽度 Equal to font size
#define kContentEmojWidth       kContentFontSize 

// 表情高度 Equal to font size
#define kContentEmojHeight      kContentFontSize

// 表情绘制Padding top 调整
#define kContentEmojPaddingTop      5


@implementation YARichText {
    NSDictionary  *emojDict;
    NSMutableAttributedString  *attributedString;
    CTTypesetterRef typesetter;
    
}
@synthesize text = _text,textFontSize,textWidth;



- (id)init {
    if (self = [super init]) {
        
        // 表情图片
        NSArray *objs = [NSArray arrayWithObjects:@"f_1.png",@"f_2.png",@"f_3.png",
                         @"f_4.png",@"f_5.png",@"f_6.png",
                         @"f_7.png", @"f_8.png",@"f_9.png",
                         @"f_10.png",@"f_11.png",@"f_12.png",
                         @"f_13.png",@"f_14.png",@"f_15.png",
                         @"f_16.png",@"f_17.png",@"f_18.png",
                         @"f_19.png",@"f_20.png",@"f_21.png",@"f_22.png",
                         @"f_23.png",@"f_24.png",@"f_25.png",
                         @"f_26.png", @"f_27.png",@"f_28.png",
                         @"f_29.png",@"f_30.png",@"f_31.png",
                         @"f_32.png",@"f_33.png",@"f_34.png",
                         @"f_35.png",@"f_36.png",@"f_37.png",
                         @"f_38.png",@"f_39.png",@"f_40.png",nil];
        // 表情标签
        NSArray *keys = [NSArray arrayWithObjects:@"[傻笑]",@"[惊愕]",@"[生气]",
                         @"[狡诈]",@"[受伤]",@"[闭嘴]",
                         @"[愤怒]", @"[开心]",@"[龇牙]",
                         @"[吐舌]",@"[酷]",@"[暴怒]",
                         @"[撇嘴]",@"[地雷]",@"[思考]",
                         @"[大笑]",@"[哭]",@"[ET]",
                         @"[色色]",@"[伤心]",@"[中枪]",@"[玫瑰]",
                         @"[枪]",@"[火]",@"[咖啡]",
                         @"[亲亲]", @"[太阳]",@"[蛋糕]",
                         @"[刀]",@"[屎]",@"[勾引]",
                         @"[拳头]",@"[赞]",@"[弱]",
                         @"[抱拳]",@"[握手]",@"[OK]",
                         @"[胜利]",@"[心碎]",@"[心]",nil];

        
        emojDict = [[NSDictionary alloc]initWithObjects:objs forKeys:keys];
        textFontSize = kContentFontSize;
        textWidth = kContentTextWidth;
        _text = @"";
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)setText:(NSString *)text {
  
     _text = text;
    [self buildAttributes];
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
    
}

- (void)buildAttributes {
   
   
    // Set CTRunDelegateCallbacks for emotions
    
    // ... 查找表情的index位置
    NSMutableArray *__emojsIndex = [[NSMutableArray alloc]init];
    [__emojsIndex addObjectsFromArray:[YARegularExpression itemIndexesWithPattern:EmotionItemPattern inString:_text]];
    
    // ... 查找表情对应的字符串
    NSMutableArray *__emojsKey = [[NSMutableArray alloc]init];
    [__emojsKey addObjectsFromArray:[YARegularExpression itemStringsWithPattern:EmotionItemPattern inString:_text]];
    
  
    // ... 过滤不存在的表情
    NSMutableIndexSet *nonExistIds = [[NSMutableIndexSet alloc]init];
    
    NSInteger i = 0;
    for (NSString *__emoj in __emojsKey) {
        if ([emojDict objectForKey:__emoj] == NULL) {
            [nonExistIds addIndex:i];
        }
        i++;
    }
    
    [__emojsIndex removeObjectsAtIndexes:nonExistIds];
    [__emojsKey removeObjectsAtIndexes:nonExistIds];
    
    
    // ... 替换表情字符串为空格

    _text = [_text replaceCharactersAtIndexes:__emojsIndex withString:PlaceHolder];
    
    NSLog(@"[Format content] %@",_text);
    
    // ... 新的表情的占位符的range数组
    NSArray *newRange = [__emojsIndex offsetRangesInArrayBy:PlaceHolder.length];
    
    
    // ... 根据range数组添加attribute

    CTFontRef font = CTFontCreateUIFontForLanguage(kCTFontSystemFontType,textFontSize,0);

	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                (__bridge_transfer id)font, (id)kCTFontAttributeName,nil];
    
    attributedString = [[NSMutableAttributedString alloc] initWithString:_text attributes:attributes];
    
    
    for(NSInteger i = 0; i < [newRange count]; i++)
    {
        NSRange range = [[newRange objectAtIndex:i] rangeValue];
        NSString *emotionName = [__emojsKey objectAtIndex:i];
      
        [attributedString addAttribute:AttributedImageNameKey value:[emojDict objectForKey:emotionName] range:range];
        [attributedString addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge_transfer id)newEmotionRunDelegate() range:range];
        
    }
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)layoutSubviews {
    
    CGSize size = [self sizeOfRichText];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, textWidth,size.height)];
}

- (CGSize)sizeOfRichText {

    CFIndex start = 0;
    NSInteger length = [attributedString length];
    CGFloat height = 5; // Add inset
    
    if (typesetter == nil) {
        typesetter =  CTTypesetterCreateWithAttributedString((__bridge CFAttributedStringRef)
                                                             (attributedString));
    }
    
    while (start < length)
    {
        CFIndex count = CTTypesetterSuggestClusterBreak(typesetter, start, textWidth);
        start += count;
        height += kContentFontSize;
    }

    CFRelease(typesetter);
    typesetter = nil;
    
    return CGSizeMake(textWidth, height);
}

CTRunDelegateRef newEmotionRunDelegate()
{
   
    // Here must assign a new address
    NSString *emotionRunName = [NSString stringWithFormat:@"com.Yunva.yaya.emotionRunName []"];
 
    CTRunDelegateCallbacks imageCallbacks;
    imageCallbacks.version = kCTRunDelegateVersion1;
    imageCallbacks.dealloc = RunDelegateDeallocCallback;
    imageCallbacks.getAscent = RunDelegateGetAscentCallback;
    imageCallbacks.getDescent = RunDelegateGetDescentCallback;
    imageCallbacks.getWidth = RunDelegateGetWidthCallback;
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&imageCallbacks,
                                                       (void *)(emotionRunName));
    
    return runDelegate;
}

void RunDelegateDeallocCallback( void* refCon ){
    
}

CGFloat RunDelegateGetAscentCallback( void *refCon ){
    NSLog(@"[Get Ascent]%d",kContentEmojHeight);
    return kContentEmojHeight;
}

CGFloat RunDelegateGetDescentCallback(void *refCon){
    return 0;
}

CGFloat RunDelegateGetWidthCallback(void *refCon){
    NSLog(@"[Get Width]%d",kContentEmojWidth);
    return kContentEmojWidth ;
}


static inline CGPoint Emoji_Origin_For_Line(CTLineRef line, CGPoint lineOrigin, CTRunRef run) {
    CGFloat x = lineOrigin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL) ;
    CGFloat y = lineOrigin.y - kContentEmojPaddingTop;
    return CGPointMake(x, y);
}


void Draw_Emoji_For_Line(CGContextRef context, CTLineRef line, id owner, CGPoint lineOrigin) {
    CFArrayRef runs = CTLineGetGlyphRuns(line);
    NSUInteger count = CFArrayGetCount(runs);
    
    for(NSInteger i = 0; i < count; i++)
    {
        CTRunRef aRun = CFArrayGetValueAtIndex(runs, i);
        CFDictionaryRef attributes = CTRunGetAttributes(aRun);
        NSString *emojiName = (NSString *)CFDictionaryGetValue(attributes,AttributedImageNameKey);
            if (emojiName) {
                UIImage *image = [UIImage imageNamed:emojiName];
                if (image) {
                    CGRect imageDrawRect;
                    imageDrawRect.size = CGSizeMake(kContentEmojWidth, kContentEmojHeight);
                    imageDrawRect.origin = Emoji_Origin_For_Line(line, lineOrigin, aRun);
                    CGContextDrawImage(context, imageDrawRect, image.CGImage);
                }
            }
    }
}


- (void)drawRect:(CGRect)rect {
   
    if (typesetter == nil) {
        typesetter =  CTTypesetterCreateWithAttributedString((__bridge CFAttributedStringRef)
                                                         (attributedString));
    }
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSaveGState(context);

    
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    
    CGFloat y = self.bounds.size.height - kContentEmojHeight;
    CFIndex start = 0;
    NSInteger length = [attributedString length];
    

    while (start < length)
    {
        CFIndex count = CTTypesetterSuggestClusterBreak(typesetter, start, textWidth);
        CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(start, count));
        CGContextSetTextPosition(context, 0, y);
        
        CTLineDraw(line, context);
        Draw_Emoji_For_Line(context, line, self, CGPointMake(0, y));
        
        start += count;
        y  -=  kContentFontSize;
        
        CFRelease(line);
    }
    
    CGContextRestoreGState(context);
    
    CFRelease(typesetter);
    typesetter = nil;
}


@end
