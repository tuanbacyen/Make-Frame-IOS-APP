//
//  MadeFrame.h
//  TollCreateFrame
//
//  Created by Admin on 8/5/17.
//  Copyright © 2017 ListenEnglish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ObjectRectCustomer.h"

@interface MadeFrame : NSObject

typedef enum {
    LeftTop,
    RightTop,
    LeftBot,
    RightBot
} frameBorder;

// parameter
@property (nonatomic, strong) NSString *jsonFile;
@property (nonatomic, strong) UIImage *imageFrame;
@property (nonatomic, assign) CGSize sizeFrame;
@property (nonatomic, strong) NSMutableArray *arrRectcorner;
@property (nonatomic, strong) NSMutableArray *arrRectTop;
@property (nonatomic, strong) NSMutableArray *arrRectLeft;
@property (nonatomic, strong) NSMutableArray *arrRectRight;
@property (nonatomic, strong) NSMutableArray *arrRectBot;
@property (nonatomic, strong) NSMutableArray *arrCenter;
@property (nonatomic, assign) CGFloat topHeight;
@property (nonatomic, assign) CGFloat botHeight;
@property (nonatomic, assign) NSInteger typeFrame;

// method
- (instancetype) initWithMadeFrame:(NSString *)json size:(CGSize)size;
-(UIImage*)frame;
-(NSDictionary*)JSONFromFile;
-(ObjectRectCustomer*)ObjectRec:(NSString*)arrItem rai:(CGFloat)rai;
-(void)readJson;
-(UIImage*)imageByCroppingCorner :(frameBorder)index;
/** Yes là ngan, No là Dọc */
-(UIImage*) mergeImageTop;
-(UIImage*) imageByCropping:(ObjectRectCustomer*)objRect;
-(UIImage*) imageByCropping:(UIImage*)images objRect:(ObjectRectCustomer*)objRect;
-(UIImage*) mergeImageBot;
-(UIImage*) mergeHorizontal:(UIImage*)p1 p2:(UIImage*)p2;
-(UIImage*) mergeHorizontalX:(UIImage*)img Width:(CGFloat)Width;
-(UIImage*) mergeImageVerticalX:(UIImage*)img Height:(CGFloat)Height;
-(UIImage*) mergeImageVertical:(UIImage *)p1 p2:(UIImage *)p2;
-(UIImage*) mergeMidBT:(CGFloat)wh flagBT:(BOOL)flagBT;
-(UIImage*) mergeImageCenter;
-(UIImage*) frame2;
-(UIImage*) frame3;
-(UIImage*) frame4;
-(UIImage*) frame8;
-(UIImage*) rotateWithImage:(UIImage*)frameImg orientation:(UIImageOrientation)orientation;
@end
