//
//  MadeFrame.m
//  TollCreateFrame
//
//  Created by Admin on 8/5/17.
//  Copyright © 2017 ListenEnglish. All rights reserved.
//

#import "MadeFrame.h"
#import "ProjectHeader.h"

@implementation MadeFrame

#pragma mark - parameter
@synthesize jsonFile = _jsonFile;
@synthesize imageFrame = _imageFrame;
@synthesize sizeFrame = _sizeFrame;
@synthesize topHeight = _topHeight;
@synthesize botHeight = _botHeight;
@synthesize typeFrame = _typeFrame;
@synthesize arrRectcorner = _arrRectcorner;
@synthesize arrRectTop = _arrRectTop;
@synthesize arrRectLeft = _arrRectLeft;
@synthesize arrRectRight = _arrRectRight;
@synthesize arrRectBot = _arrRectBot;
@synthesize arrCenter = _arrCenter;

#pragma mark - func contructer
- (instancetype) init{
    self = [super init];
    if(self){
        NSLog(@"create object");
    }
    return self;
}

- (void)dealloc
{
    BLogInfo(@"");
}

- (instancetype) initWithMadeFrame:(NSString *)json size:(CGSize)size {
    self = [super init];
    self.jsonFile = json;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:json ofType:@"png"];
    self.imageFrame = [UIImage imageWithContentsOfFile:path];
    
    self.sizeFrame = size;
    self.arrRectcorner = [NSMutableArray new];
    self.arrRectTop = [NSMutableArray new];
    self.arrRectLeft = [NSMutableArray new];
    self.arrRectRight = [NSMutableArray new];
    self.arrRectBot = [NSMutableArray new];
    self.arrCenter = [NSMutableArray new];
    self.readJson;
    return self;
}

#pragma mark - make frame
-(UIImage*)frame{
    if((_sizeFrame.height / _sizeFrame.width) >= 0.8 && (_sizeFrame.height / _sizeFrame.width) <= 1.2){
        return _imageFrame;
    }
    
    switch (_typeFrame) {
        case 1:
            return self.imageFrame;
            break;
        case 2:
            return [self frame2];
            break;
        case 3:
            return [self frame3];
            break;
        case 4:
            return [self frame4];
            break;
        case 8:
            return [self frame8];
            break;
            
        default:
            return _imageFrame;
            break;
    }
}


#pragma mark - read data from json
- (NSDictionary *)JSONFromFile{
    NSString *path = [[NSBundle mainBundle] pathForResource:_jsonFile ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

-(ObjectRectCustomer*)ObjectRec:(NSString*)arrItem rai:(CGFloat)rai{
    ObjectRectCustomer *temp = [[ObjectRectCustomer alloc] initWithRectString:arrItem raito:rai];
    return temp;
}

- (void)readJson{
    // get json
    NSDictionary *dict = [self JSONFromFile];
    CGFloat rai = [self checkSize];
    self.typeFrame = dict.count;
    
    if((_sizeFrame.height / _sizeFrame.width) >= 0.8 && (_sizeFrame.height / _sizeFrame.width) <= 1.2){
    }else{
        switch (_typeFrame) {
            case 8:{
                //arr top left
                NSString *topleft = [dict objectForKey:@"1"];
                [_arrRectcorner addObject:[self ObjectRec:topleft rai:rai]];
                
                // arr top right
                NSString *topRight	 = [dict objectForKey:@"2"];
                [_arrRectcorner addObject:[self ObjectRec:topRight rai:rai]];
                
                // arr bot left
                NSString *botLeft = [dict objectForKey:@"3"];
                [_arrRectcorner addObject:[self ObjectRec:botLeft rai:rai]];
                
                // arr bot right
                NSString *botRight = [dict objectForKey:@"4"];
                [_arrRectcorner addObject:[self ObjectRec:botRight rai:rai]];
                
                // arr top
                NSArray *arraytop = [dict objectForKey:@"12"];
                for (NSString *obj_top in arraytop) {
                    [_arrRectTop addObject:[self ObjectRec:obj_top rai:rai]];
                }
                
                // arr left
                NSArray *arrayleft = [dict objectForKey:@"13"];
                for (NSString *obj_left in arrayleft) {
                    [_arrRectLeft addObject:[self ObjectRec:obj_left rai:rai]];
                }
                
                // arr right
                NSArray *arrayRight = [dict objectForKey:@"24"];
                for (NSString *obj_right in arrayRight) {
                    [_arrRectRight addObject:[self ObjectRec:obj_right rai:rai]];
                }
                
                // arr bot
                NSArray *arrayBot = [dict objectForKey:@"34"];
                for (NSString *obj_bot in arrayBot) {
                    [_arrRectBot addObject:[self ObjectRec:obj_bot rai:rai]];
                }
                break;
            }
            case 2:{
                //arr top
                NSString *topleft = [dict objectForKey:@"1"];
                [_arrRectcorner addObject:[self ObjectRec:topleft rai:rai]];
                
                // arr bot
                NSString *botRight = [dict objectForKey:@"2"];
                [_arrRectcorner addObject:[self ObjectRec:botRight rai:rai]];
                break;
            }
            case 3:{
                //arr top
                NSString *top = [dict objectForKey:@"1"];
                [_arrRectcorner addObject:[self ObjectRec:top rai:rai]];
                
                // arr bot
                NSString *bot = [dict objectForKey:@"2"];
                [_arrRectcorner addObject:[self ObjectRec:bot rai:rai]];
                
                // arr center
                NSString *center = [dict objectForKey:@"3"];
                [_arrCenter addObject:[self ObjectRec:center rai:rai]];
                break;
            }
            case 4:{
                //arr top left
                NSString *topleft = [dict objectForKey:@"1"];
                [_arrRectcorner addObject:[self ObjectRec:topleft rai:rai]];
                
                // arr top right
                NSString *topRight	 = [dict objectForKey:@"2"];
                [_arrRectcorner addObject:[self ObjectRec:topRight rai:rai]];
                
                // arr bot left
                NSString *botLeft = [dict objectForKey:@"3"];
                [_arrRectcorner addObject:[self ObjectRec:botLeft rai:rai]];
                
                // arr bot right
                NSString *botRight = [dict objectForKey:@"4"];
                [_arrRectcorner addObject:[self ObjectRec:botRight rai:rai]];
                
                break;
            }
        }
        
        self.imageFrame = [self imageResizeScale:self.imageFrame ratio:rai];
    }
}

// check size of frame
-(CGFloat)checkSize{
    if(_sizeFrame.width < _sizeFrame.height){
        return _sizeFrame.width / [_imageFrame size].width;
    }else{
        return _sizeFrame.height / [_imageFrame size].height;
    }
}

#pragma mark - cắt khung ảnh
// 4 góc
- (UIImage*)imageByCroppingCorner:(frameBorder)index{
    CGImageRef imageRef;
    ObjectRectCustomer *obj;
    UIImage *img;
    switch (index) {
        case LeftTop:
            obj = (ObjectRectCustomer*)[_arrRectcorner objectAtIndex:0];
            imageRef = CGImageCreateWithImageInRect([_imageFrame CGImage], obj.convertToRect);
            img = [UIImage imageWithCGImage:imageRef];
            CGImageRelease(imageRef);
            return img;
            break;
        case RightTop:
            obj = (ObjectRectCustomer*)[_arrRectcorner objectAtIndex:1];
            imageRef = CGImageCreateWithImageInRect([_imageFrame CGImage], obj.convertToRect);
            img = [UIImage imageWithCGImage:imageRef];
            CGImageRelease(imageRef);
            return img;
            break;
        case LeftBot:
            obj = (ObjectRectCustomer*)[_arrRectcorner objectAtIndex:2];
            imageRef = CGImageCreateWithImageInRect([_imageFrame CGImage], obj.convertToRect);
            img = [UIImage imageWithCGImage:imageRef];
            CGImageRelease(imageRef);
            return img;
            break;
        case RightBot:
            obj = (ObjectRectCustomer*)[_arrRectcorner objectAtIndex:3];
            imageRef = CGImageCreateWithImageInRect([_imageFrame CGImage], obj.convertToRect);
            img = [UIImage imageWithCGImage:imageRef];
            CGImageRelease(imageRef);
            return img;
            break;
    }
    return nil;
}
// cắt frame theo toạ độ
- (UIImage*)imageByCropping:(ObjectRectCustomer*)objRect{
    CGImageRef imageRef = CGImageCreateWithImageInRect([_imageFrame CGImage], objRect.convertToRect);
    UIImage *img = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return img;
}
// cắt 1 ảnh theo toạ độ
-(UIImage*)imageByCropping:(UIImage*)images objRect:(ObjectRectCustomer*)objRect{
    CGImageRef imageRef = CGImageCreateWithImageInRect([images CGImage], objRect.convertToRect);
    UIImage *img = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return img;
}

#pragma mark - xử lý co dãn ảnh
// fix size ảnh
- (UIImage *)imageResizeScale:(UIImage *)image ratio:(CGFloat)newRatio{
    CGSize size = CGSizeMake([image size].width * newRatio, [image size].height * newRatio);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - Xử lý chính

-(UIImage*)frame2{
    
    CGSize size = _sizeFrame;
    
    UIImage *imgTop = [self imageByCroppingCorner:0];
    UIImage *imgBot = [self imageByCroppingCorner:1];
    
    ObjectRectCustomer *objTop = (ObjectRectCustomer*)[_arrRectcorner objectAtIndex:0];
    ObjectRectCustomer *objBot = (ObjectRectCustomer*)[_arrRectcorner objectAtIndex:1];
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
    if([objTop.x doubleValue] == 0.0 && [objTop.y doubleValue] == 0.0 && [objBot.x doubleValue] == 0.0){
        return [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",_jsonFile]];
    }else if([objTop.x doubleValue] == 0.0 && [objTop.y doubleValue] == 0.0 && [objBot.y doubleValue] == 0.0){
        // top = left
        // bot = right
        if(size.height > imgTop.size.height){
            
            int cout = size.height / imgTop.size.height;
            CGFloat du = ((size.height / imgTop.size.height) - cout)*imgTop.size.height;
            CGFloat y = 0.0;
            
            for (int i = 0; i < cout ; i++)
            {
                [imgTop drawInRect:CGRectMake(0,y,imgTop.size.width, imgTop.size.height)];
                [imgBot drawInRect:CGRectMake(size.width - imgBot.size.width,y,imgBot.size.width, imgBot.size.height)];
                y = y + imgTop.size.height;
            }
            
            ObjectRectCustomer *obj = [[ObjectRectCustomer alloc] initWithObjectRect:@"0" Y:@"0" Width:[NSString stringWithFormat:@"%f", imgTop.size.width] Heght:[NSString stringWithFormat:@"%f", du]];
            CGImageRef imageRef = CGImageCreateWithImageInRect([_imageFrame CGImage], obj.convertToRect);
            UIImage *imgLeft = [UIImage imageWithCGImage:imageRef];
            CGImageRelease(imageRef);
            
            ObjectRectCustomer *obj2 = [[ObjectRectCustomer alloc] initWithObjectRect:objBot.x Y:@"0" Width:objBot.width Heght:[NSString stringWithFormat:@"%f", du]];
            CGImageRef imageRef2 = CGImageCreateWithImageInRect([_imageFrame CGImage], obj2.convertToRect);
            UIImage *imgRight = [UIImage imageWithCGImage:imageRef2];
            CGImageRelease(imageRef2);
            
            [imgLeft drawInRect:CGRectMake(0,y,imgTop.size.width, du)];
            [imgRight drawInRect:CGRectMake(size.width - imgBot.size.width,y,imgBot.size.width, du)];
            
        }else{
            [imgTop drawInRect:CGRectMake(0,0,imgTop.size.width, imgTop.size.height)];
            [imgBot drawInRect:CGRectMake(size.width - imgBot.size.width,size.height - imgBot.size.height,imgBot.size.width, imgBot.size.height)];
        }
    }else if([objTop.x doubleValue] == 0.0 && [objTop.y doubleValue] == 0.0){
        [imgTop drawInRect:CGRectMake(0,0,imgTop.size.width, imgTop.size.height)];
        [imgBot drawInRect:CGRectMake(size.width - imgBot.size.width,size.height - imgBot.size.height,imgBot.size.width, imgBot.size.height)];
    }else if([objTop.y doubleValue] == 0.0 && [objBot.x doubleValue] == 0.0){
        [imgTop drawInRect:CGRectMake(size.width - imgTop.size.width,0,imgTop.size.width, imgTop.size.height)];
        [imgBot drawInRect:CGRectMake(0,size.height - imgBot.size.height,imgBot.size.width, imgBot.size.height)];
    }
    
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return finalImage;
}

-(UIImage*)frame3{
    
    CGSize size = _sizeFrame;
    
    ObjectRectCustomer *objCenter = (ObjectRectCustomer*)[_arrCenter objectAtIndex:0];
    
    UIImage *imgTop = [self imageByCroppingCorner:0];
    UIImage *imgBot = [self imageByCroppingCorner:1];
    UIImage *imgCenter = [self imageByCropping:objCenter];
    
    CGFloat heightDu = _sizeFrame.height - imgBot.size.height - imgTop.size.height;

    UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
    [imgTop drawInRect:CGRectMake(0,0,size.width, imgTop.size.height)];
    [imgBot drawInRect:CGRectMake(0,size.height - imgBot.size.height,size.width, imgBot.size.height)];
    
    if(heightDu > [objCenter.heght floatValue]){
        
        int cout = heightDu / [objCenter.heght floatValue];
        CGFloat du = ((heightDu / [objCenter.heght floatValue]) - cout)*imgCenter.size.height;
        
        CGFloat y = imgTop.size.height;
        for (int i = 0; i < cout ; i++)
        {
            [imgCenter drawInRect:CGRectMake(0,y,size.width, imgCenter.size.height)];
            y = y + imgCenter.size.height;
        }
        
        ObjectRectCustomer *obj = [[ObjectRectCustomer alloc] initWithObjectRect:@"0" Y:@"0" Width:objCenter.width Heght:[NSString stringWithFormat:@"%f", du]];
        CGImageRef imgCen = CGImageCreateWithImageInRect([imgCenter CGImage], obj.convertToRect);
        UIImage *imgCent = [UIImage imageWithCGImage:imgCen];
        CGImageRelease(imgCen);
        
        [imgCent drawInRect:CGRectMake(0,y,size.width, du)];
    }else if(heightDu == [objCenter.heght floatValue]){
        
        [imgCenter drawInRect:CGRectMake(0,imgTop.size.height,size.width, imgCenter.size.height)];
        
    }else{
        
        ObjectRectCustomer *obj = [[ObjectRectCustomer alloc] initWithObjectRect:@"0" Y:@"0" Width:objCenter.width Heght:[NSString stringWithFormat:@"%f", heightDu]];
        CGImageRef imageRef = CGImageCreateWithImageInRect([imgCenter CGImage], obj.convertToRect);
        UIImage *imgCen = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        
        [imgCen drawInRect:CGRectMake(0,imgTop.size.height,size.width, heightDu)];
    }
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return finalImage;
}

-(UIImage*)frame4{
    
    CGSize size = _sizeFrame;
    UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
    
    // cắt ra 4 ảnh ở 4 góc theo vị trí trong file json
    
    UIImage *imgTopLeft = [self imageByCroppingCorner:0];
    UIImage *imgTopRight = [self imageByCroppingCorner:1];
    UIImage *imgBotLeft = [self imageByCroppingCorner:2];
    UIImage *imgBotRight = [self imageByCroppingCorner:3];
    
    // ghép vào khung mới
    
    [imgTopLeft drawInRect:CGRectMake(0,0,imgTopLeft.size.width, imgTopLeft.size.height)];
    [imgTopRight drawInRect:CGRectMake(size.width - imgTopRight.size.width,0,imgTopRight.size.width, imgTopRight.size.height)];
    [imgBotLeft drawInRect:CGRectMake(0,size.height - imgBotLeft.size.height,imgBotLeft.size.width, imgBotLeft.size.height)];
    [imgBotRight drawInRect:CGRectMake(size.width - imgBotRight.size.width,size.height - imgBotRight.size.height,imgBotRight.size.width, imgBotRight.size.height)];
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return finalImage;
}

-(UIImage*)frame8{
    
    // lấy toạ độ
    
    ObjectRectCustomer *objCenterTop = (ObjectRectCustomer *) [_arrRectTop objectAtIndex:0];
    ObjectRectCustomer *objCenterBot = (ObjectRectCustomer *) [_arrRectBot objectAtIndex:0];
    ObjectRectCustomer *objCenterLeft = (ObjectRectCustomer *) [_arrRectLeft objectAtIndex:0];
    ObjectRectCustomer *objCenterRight = (ObjectRectCustomer *) [_arrRectRight objectAtIndex:0];
    
    // cắt các frame theo từng toạ độ
    
    UIImage *imgTL = [self imageByCroppingCorner:LeftTop];
    UIImage *imgTR = [self imageByCroppingCorner:RightTop];
    UIImage *imgBL = [self imageByCroppingCorner:LeftBot];
    UIImage *imgBR = [self imageByCroppingCorner:RightBot];
    
    UIImage *imgCT = [self imageByCropping:objCenterTop];
    UIImage *imgCB = [self imageByCropping:objCenterBot];
    
    UIImage *imgCL = [self imageByCropping:objCenterLeft];
    UIImage *imgCR = [self imageByCropping:objCenterRight];
    
    
    UIGraphicsBeginImageContextWithOptions(_sizeFrame, NO, 1.0);
    
    // ghep 4 goc
    
    [imgTL drawInRect:CGRectMake(0,0,imgTL.size.width, imgTL.size.height)];
    [imgTR drawInRect:CGRectMake(_sizeFrame.width - imgTR.size.width,0,imgTR.size.width, imgTL.size.height)];
    [imgBL drawInRect:CGRectMake(0,_sizeFrame.height - imgBL.size.height,imgBL.size.width, imgBL.size.height)];
    [imgBR drawInRect:CGRectMake(_sizeFrame.width - imgBR.size.width,_sizeFrame.height - imgBR.size.height,imgBR.size.width, imgBR.size.height)];
    
    CGFloat widthDuTop = _sizeFrame.width - imgTL.size.width - imgTR.size.width;
    CGFloat widthDuBot = _sizeFrame.width - imgBL.size.width - imgBR.size.width;
    CGFloat heightDuCenter = _sizeFrame.height - imgTL.size.height - imgBL.size.height;
    
    CGFloat heightBot = _sizeFrame.height - imgBL.size.height;
    CGFloat heightCenter = imgTL.size.height;
    
    // noi top
    
    if(widthDuTop > [objCenterTop.width floatValue]){
        
        // độ dài ở giữa lơn hơn độ dài ảnh giữa frame
        
        // tính số lần ảnh cần lặp
        int cout = widthDuTop / [objCenterTop.width floatValue];
        
        // tính số dư sau số lần ảnh lặp
        CGFloat du = ((widthDuTop / [objCenterTop.width floatValue]) - cout)*[objCenterTop.width floatValue];
        
        // toạ độ vị trí giữa ban đầu
        CGFloat x = imgTL.size.width;
        
        for (int i = 0; i < cout ; i++)
        {
            // ghép các ảnh cắt nguyên theo toạ độ
            [imgCT drawInRect:CGRectMake(x,0,imgCT.size.width, imgCT.size.height)];
            x = x + imgCT.size.width;
        }
        
        // cắt ảnh theo phần còn dư (width hoặc height)
        ObjectRectCustomer *objCenterTopDu = [[ObjectRectCustomer alloc] initWithObjectRect:@"0" Y:@"0" Width:[NSString stringWithFormat:@"%f", du] Heght:objCenterTop.heght];
        CGImageRef imgCenterTop = CGImageCreateWithImageInRect([imgCT CGImage], objCenterTopDu.convertToRect);
        UIImage *imgCenTop = [UIImage imageWithCGImage:imgCenterTop];
        CGImageRelease(imgCenterTop);
        
        // ghép vào ảnh cuối cùng
        [imgCenTop drawInRect:CGRectMake(x,0,du, imgCenTop.size.height)];
    }
    else if(widthDuTop == [objCenterTop.width floatValue]){
        // trường hợp đặc biệt chỉ cần ghép vào
        [imgCT drawInRect:CGRectMake(imgTL.size.width,0,imgCT.size.width, imgCT.size.height)];
    }
    else{
        
        // trường hợp phần dư bé hơn ảnh (width hoặc height)
        // cắt phần dư ảnh
        ObjectRectCustomer *obj = [[ObjectRectCustomer alloc] initWithObjectRect:@"0" Y:@"0" Width:[NSString stringWithFormat:@"%f", widthDuTop] Heght:objCenterTop.heght];
        CGImageRef imageRef = CGImageCreateWithImageInRect([imgCT CGImage], obj.convertToRect);
        UIImage *imgCen = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        
        // ghép ảnh
        [imgCen drawInRect:CGRectMake(imgTL.size.width,0,widthDuTop, imgTL.size.height)];
    }
    
    // làm tương tự như trường hợp trên
    // noi bot
    
    if(widthDuBot > [objCenterBot.width floatValue]){
        
        int cout = widthDuBot / [objCenterBot.width floatValue];
        CGFloat du = ((widthDuBot / [objCenterBot.width floatValue]) - cout)*[objCenterBot.width floatValue];
        
        CGFloat x = imgBL.size.width;
        
        for (int i = 0; i < cout ; i++)
        {
            [imgCB drawInRect:CGRectMake(x,heightBot,imgCB.size.width, imgCB.size.height)];
            x = x + imgCB.size.width;
        }
        
        ObjectRectCustomer *objCenterBotDu = [[ObjectRectCustomer alloc] initWithObjectRect:@"0" Y:@"0" Width:[NSString stringWithFormat:@"%f", du] Heght:objCenterBot.heght];
        CGImageRef imgCenterBot = CGImageCreateWithImageInRect([imgCB CGImage], objCenterBotDu.convertToRect);
        UIImage *imgCenBot = [UIImage imageWithCGImage:imgCenterBot];
        CGImageRelease(imgCenterBot);
        [imgCenBot drawInRect:CGRectMake(x,heightBot,du, imgCenBot.size.height)];
    }
    else if(widthDuBot == [objCenterBot.width floatValue]){
        [imgCB drawInRect:CGRectMake(imgBL.size.width,heightBot,imgCB.size.width, imgCB.size.height)];
    }
    else{
        
        ObjectRectCustomer *obj = [[ObjectRectCustomer alloc] initWithObjectRect:@"0" Y:@"0" Width:[NSString stringWithFormat:@"%f", widthDuBot] Heght:objCenterBot.heght];
        CGImageRef imageRef = CGImageCreateWithImageInRect([imgCB CGImage], obj.convertToRect);
        UIImage *imgCen = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        
        [imgCen drawInRect:CGRectMake(imgBL.size.width,heightBot,widthDuBot, imgBL.size.height)];
    }
    
    // noi giua
    
    if(heightDuCenter > [objCenterLeft.heght floatValue]){
        
        int cout = heightDuCenter / [objCenterLeft.heght floatValue];
        CGFloat du = ((heightDuCenter / [objCenterLeft.heght floatValue]) - cout)*[objCenterLeft.heght floatValue];
        
        CGFloat xl = 0;
        CGFloat xr = _sizeFrame.width - imgCR.size.width;
        CGFloat y = imgTL.size.height;

        // x - y
        // 0 - y
        
        for (int i = 0; i < cout ; i++)
        {
            [imgCL drawInRect:CGRectMake(xl,y,imgCL.size.width, imgCL.size.height)];
            [imgCR drawInRect:CGRectMake(xr,y,imgCR.size.width, imgCR.size.height)];
            
            y = y + imgCL.size.height;
        }
        
        ObjectRectCustomer *objCenterLeftDu = [[ObjectRectCustomer alloc] initWithObjectRect:@"0" Y:@"0" Width:objCenterLeft.width Heght:[NSString stringWithFormat:@"%f", du]];
        CGImageRef imgCenterLeft = CGImageCreateWithImageInRect([imgCL CGImage], objCenterLeftDu.convertToRect);
        UIImage *imgCenLeft = [UIImage imageWithCGImage:imgCenterLeft];
        CGImageRelease(imgCenterLeft);
        
        ObjectRectCustomer *objCenterRightDu = [[ObjectRectCustomer alloc] initWithObjectRect:@"0" Y:@"0" Width:objCenterRight.width Heght:[NSString stringWithFormat:@"%f", du]];
        CGImageRef imgCenterRight = CGImageCreateWithImageInRect([imgCR CGImage], objCenterRightDu.convertToRect);
        UIImage *imgCenRight = [UIImage imageWithCGImage:imgCenterRight];
        CGImageRelease(imgCenterRight);
        
        [imgCenLeft drawInRect:CGRectMake(xl,y,imgCenLeft.size.width, du)];
        [imgCenRight drawInRect:CGRectMake(xr,y,imgCenRight.size.width, du)];
        
    }
    else if(heightDuCenter == [objCenterBot.heght floatValue]){
        
        [imgCL drawInRect:CGRectMake(0,heightCenter,imgCL.size.width, imgCL.size.height)];
        [imgCR drawInRect:CGRectMake(_sizeFrame.width - imgCR.size.width,heightCenter,imgCR.size.width, imgCR.size.height)];
        
    }
    else{
        
        ObjectRectCustomer *obj = [[ObjectRectCustomer alloc] initWithObjectRect:@"0" Y:@"0" Width:objCenterLeft.width Heght:[NSString stringWithFormat:@"%f", heightDuCenter]];
        CGImageRef imageRef = CGImageCreateWithImageInRect([imgCL CGImage], obj.convertToRect);
        UIImage *imgCen = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        
        ObjectRectCustomer *objRight = [[ObjectRectCustomer alloc] initWithObjectRect:@"0" Y:@"0" Width:objCenterRight.width Heght:[NSString stringWithFormat:@"%f", heightDuCenter]];
        CGImageRef imageRefRight = CGImageCreateWithImageInRect([imgCR CGImage], objRight.convertToRect);
        UIImage *imgCenRight = [UIImage imageWithCGImage:imageRefRight];
        CGImageRelease(imageRefRight);
        
        [imgCen drawInRect:CGRectMake(0,heightCenter,imgCen.size.width, heightDuCenter)];
        [imgCenRight drawInRect:CGRectMake(_sizeFrame.width - imgCR.size.width,heightCenter,imgCenRight.size.width, heightDuCenter)];
    }

    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
}
@end
