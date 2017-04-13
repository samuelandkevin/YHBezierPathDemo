//
//  DetailVC.m
//  UIBezierPathDemo
//
//  Created by YHIOS002 on 17/4/13.
//  Copyright © 2017年 samuelandkevin. All rights reserved.
//

#import "DetailVC.h"

#define RGB16(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]
#define kGrayColor  RGBCOLOR(196, 197, 198)
#define kBlueColor  RGB16(0x0e92dd)          //蓝色主调

@interface DetailVC ()

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    switch (self.row) {
        case 0:
            [self drawBubble];
            break;
        case 1:
            [self drawLoadingCircle];
            break;
        case 2:
            [self drawCurvedLine];
            break;
        case 3:
            [self drawDottedLine];
            break;
        case 4:
            [self drawFiveAnimation];
            break;
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//画一个气泡框
- (void)drawBubble{
    //气泡框
    CGFloat x = 20;
    CGFloat y = 64;
    CGFloat w = self.view.frame.size.width/2+50;
    CGFloat h = 40;
    //先画矩形带圆角
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x, y, w, h)
                                                     byRoundingCorners:UIRectCornerAllCorners
                                                           cornerRadii:CGSizeMake(5, 5)];
    
    //后画箭头
    [bezierPath moveToPoint:CGPointMake(x, y+(h/2)-5)];
    [bezierPath addLineToPoint:CGPointMake(x-5, y+(h/2))];
    [bezierPath addLineToPoint:CGPointMake(x, y+(h/2)+5)];
    
    //闭合
    CAShapeLayer *shaperLayer = [CAShapeLayer new];
    shaperLayer.fillColor = kBlueColor.CGColor;
    [self.view.layer addSublayer:shaperLayer];
    
    shaperLayer.path = bezierPath.CGPath;
}

//画一个Loading圈
- (void)drawLoadingCircle{
    
    CGFloat lineWidth  =  10;
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = lineWidth;
    path.lineCapStyle  = kCGLineCapRound;
    CGPoint center = CGPointMake(0, 0);
    CGFloat radius = 25;
    CGFloat startAngle = 0; //iOS坐标轴和QuardZ坐标轴相反
    CGFloat endAngle   = M_PI/2;
    [path addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.position = CGPointMake(50, 50);
    layer.path = path.CGPath;
    layer.fillColor   = [UIColor clearColor].CGColor;
    layer.strokeColor = kBlueColor.CGColor;
    [self.view.layer addSublayer:layer];
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation.fromValue = @(0);
    basicAnimation.toValue   = @(M_PI*2);
    basicAnimation.duration  = 1;
    basicAnimation.repeatCount = LONG_MAX;
    [layer addAnimation:basicAnimation forKey:@"loadingAnimation"];
    
    [layer performSelector:@selector(removeAllAnimations) withObject:nil afterDelay:4];
}


//画一条弧线
- (void)drawCurvedLine
{
    CGPoint startPoint   = CGPointMake(20, 100);
    CGPoint endPoint     = CGPointMake(120,100);
    CGPoint controlPoint = CGPointMake(70, 0); //控制点 50 = （120-20/2 + 20
    
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 5.0;
    aPath.lineCapStyle  = kCGLineCapRound; //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
    [aPath moveToPoint:startPoint];
    [aPath addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = aPath.CGPath;
    [self.view.layer addSublayer:layer];
}



//画一条虚线
- (void)drawDottedLine
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.view.bounds];
    [shapeLayer setPosition:self.view.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0f] CGColor]];
    
    // 3.0f设置虚线的宽度
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
      [NSNumber numberWithInt:1],nil]];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 89);
    CGPathAddLineToPoint(path, NULL, 320,89);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    // 可以把self改成任何你想要的UIView, 下图演示就是放到UITableViewCell中的
    [[self.view layer] addSublayer:shapeLayer];
}



//画一个五边形
- (void)drawFiveAnimation
{
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    //开始点 从上左下右的点
    [aPath moveToPoint:CGPointMake(100,100)];
    //划线点
    [aPath addLineToPoint:CGPointMake(60, 140)];
    [aPath addLineToPoint:CGPointMake(60, 240)];
    [aPath addLineToPoint:CGPointMake(160, 240)];
    [aPath addLineToPoint:CGPointMake(160, 140)];
    [aPath closePath];
    
    //设置定点是个5*5的小圆形（自己加的）
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100-5/2.0, 10, 5, 5)];
    [aPath appendPath:path];
    
    CAShapeLayer *shapelayer = [CAShapeLayer layer];
    //设置边框颜色
    shapelayer.strokeColor = [[UIColor redColor] CGColor];
    //设置填充颜色 如果只要边 可以把里面设置成[UIColor ClearColor]
    shapelayer.fillColor = [[UIColor blueColor] CGColor];
    //就是这句话在关联彼此（UIBezierPath和CAShapeLayer）：
    shapelayer.path = aPath.CGPath;
    [self.view.layer addSublayer:shapelayer];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
