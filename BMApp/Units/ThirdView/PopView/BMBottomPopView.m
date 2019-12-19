//
//  BMBottomPopView.m
//  Tourism
//
//  Created by Mac on 2019/1/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMBottomPopView.h"

#import "PGDatePickManager.h"
#import "BMWeekTableViewCell.h"
@interface BMBottomPopView()<PGDatePickerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imgNameArray;
@property (nonatomic, copy) void (^blockTapAction)(NSInteger index);
@property (nonatomic, copy) void (^selectDateTapAction)(NSString * date);

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSMutableArray *buttonArray;


@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat fontS;
@property (nonatomic, assign) BOOL showCornerRadius;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) PGDatePicker *datePicker;
@property (nonatomic, strong) UIDatePicker *sysDatePicker;
@property (nonatomic, strong) NSDateComponents *dateComponents;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *selectWeekArr;
@end

static NSString * const BMWeekTableViewCellID = @"BMWeekTableViewCellID";

@implementation BMBottomPopView

+(void)showMoreWithTitle:(NSArray *)titleArray
            imgNameArray:(NSArray *)imgNameArray itemHeight:(CGFloat )itemHeight fontS:(CGFloat)fontS showCornerRadius:(BOOL)showCornerRadius
          blockTapAction:( void(^)(NSInteger index) )blockTapAction{
    //    if (titleArray.count != imgNameArray.count || !titleArray.count) {
    //        return;
    //    }
    if (!titleArray.count) {
        return;
    }
    BMBottomPopView *modeView = [[BMBottomPopView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, Z_SCREENH_HEIGHT - SafeAreaBottomHeight)];
    modeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    modeView.alpha = 0;
    modeView.titleArray = titleArray;
    modeView.imgNameArray = imgNameArray;
    modeView.itemHeight = itemHeight;
    modeView.fontS = fontS;
    modeView.showCornerRadius = showCornerRadius;
    modeView.blockTapAction = blockTapAction;
    [[UIApplication sharedApplication].keyWindow addSubview:modeView];
    
    // 创建内容
    
    
    [modeView bulidContentView];
    
    [modeView show];
    [modeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:modeView action:@selector(dismiss)]];
}

- (void)bulidContentView{
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, Z_SCREENH_HEIGHT, Z_SCREEN_WIDTH, self.itemHeight * self.titleArray.count)];
    CGFloat CornerRadius = 0;
    if (self.showCornerRadius) {
        
        CornerRadius = 36 * AutoSizeScaleX;
    }
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CornerRadius, CornerRadius)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.contentView.layer addSublayer:shapeLayer];
    [self addSubview:self.contentView];
    
    [self bulidContent];
    //[self bulidCancle];
}

- (void)bulidContent{
    
    self.buttonArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.titleArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:self.fontS];
        button.frame = CGRectMake(0, self.itemHeight * i, Z_SCREEN_WIDTH, self.itemHeight - 1);
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor getUsualColorWithString:@"#121212"] forState:UIControlStateNormal];
        //        [button setImage:[UIImage imageNamed:self.imgNameArray[i]] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(15 * AutoSizeScaleX, CGRectGetMaxY(button.frame), Z_SCREEN_WIDTH - 2 * 15 * AutoSizeScaleX, 1)];
        line.backgroundColor = [UIColor getUsualColorWithString:@"#F3F3F3"];
        [self.contentView addSubview:line];
        
        // button标题/图片的偏移量
        //        button.titleEdgeInsets = UIEdgeInsetsMake(button.imageView.bounds.size.height + kw(10), -button.imageView.bounds.size.width, 0,0);
        //        button.imageEdgeInsets = UIEdgeInsetsMake(kw(5), button.titleLabel.bounds.size.width/2, button.titleLabel.bounds.size.height + kw(5), -button.titleLabel.bounds.size.width/2);
        [self.buttonArray addObject:button];
        button.alpha = 0;
        button.transform = CGAffineTransformMakeTranslation(0, self.contentView.bounds.size.height);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showButton];
    });
}

- (void)showButton{
    
    for (int i = 0; i < self.buttonArray.count; i++) {
        
        UIButton *button = self.buttonArray[i];
        
        [UIView animateWithDuration:0.7 delay:i*0.05 - i/4*0.2 usingSpringWithDamping:0.7 initialSpringVelocity:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            button.alpha = 1;
            button.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}

// 取消按钮
- (void)bulidCancle{
    
    //    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    cancleButton.frame = CGRectMake(0, self.contentView.bounds.size.height - kw(50), self.contentView.bounds.size.width, kw(50));
    //    cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    //    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    //    [cancleButton setTitleColor:[UIColor getUsualColorWithString:@"#FFFFFF"] forState:UIControlStateNormal];
    //    [cancleButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    //    [cancleButton setBackgroundColor:[UIColor getUsualColorWithString:@"#336FF0"]];
    //    CALayer *layer = [CALayer layer];
    //    layer.frame = CGRectMake(0, 0, cancleButton.bounds.size.width, 1);
    //    layer.backgroundColor = [UIColor getUsualColorWithString:@"#336FF0"].CGColor;
    //    [cancleButton.layer addSublayer:layer];
    //
    //    [self.contentView addSubview:cancleButton];
}

- (void)addLineWithFrame:(CGRect)frame color:(UIColor *)color{
    
    CALayer *layer = [CALayer layer];
    layer.frame = frame;
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
}

- (void)show{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.alpha = 1;
        self.contentView.transform = CGAffineTransformMakeTranslation(0, -self.contentView.bounds.size.height - SafeAreaBottomHeight);
    }];
}

- (void)dismiss{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.alpha = 0;
        self.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)tapAction:(UIButton *)button{
    
    [self dismiss];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.blockTapAction) {
            self.blockTapAction(button.tag);
        }
    });
}

#pragma mark *****************************日期选择器

+ (void)showDataSelectorWithDate:(NSString *)date Type:(NSString *)type BlockTapAction:( void(^)(NSString * date) )blockTapAction{
    
    BMBottomPopView *modeView = [[BMBottomPopView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, Z_SCREENH_HEIGHT - SafeAreaBottomHeight)];
    modeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    modeView.alpha = 0;
    modeView.date = date;
    modeView.type = type;
    modeView.selectDateTapAction = blockTapAction;
    
    [[UIApplication sharedApplication].keyWindow addSubview:modeView];
    
    // 创建内容
    [modeView bulidDatePickerContentView];
    [modeView show];
    
    [modeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:modeView action:@selector(dismiss)]];
}

- (void)bulidDatePickerContentView{
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, Z_SCREENH_HEIGHT, Z_SCREEN_WIDTH, 240 * AutoSizeScaleY)];
    CGFloat CornerRadius = 36 * AutoSizeScaleX;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(0, 0)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.contentView.layer addSublayer:shapeLayer];
    [self addSubview:self.contentView];
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor getUsualColorWithString:@"#A19F9F"] forState:UIControlStateNormal];
    cancelBtn.tag = 1;
    [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cancelBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(90 * AutoSizeScaleX, 62 * AutoSizeScaleY));
    }];
    
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor getUsualColorWithString:@"#3F3E3E"] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(functionClick:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 2;
    [self.contentView addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.right.mas_equalTo(self.contentView);
        make.size.mas_equalTo(cancelBtn);
    }];
    
    UIView * line = [[UIView alloc] init];
    line.backgroundColor = [UIColor getUsualColorWithString:@"#FBFBFB"];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(confirmBtn.mas_bottom);
        make.height.mas_equalTo(6 * AutoSizeScaleY);
        
    }];
    
    PGDatePicker *datePicker = [[PGDatePicker alloc] init];
    datePicker.language = @"zh-Hans";
    // 设置显示最大时间（此处为当前时间）
    if ([self.type isEqualToString:@"出发日期"]) {
        int days = 7;    // n天后的天数
        NSDate *appointDate;    // 指定日期声明
        NSTimeInterval oneDay = 24 * 60 * 60;  // 一天一共有多少秒
        appointDate = [[NSDate date] initWithTimeIntervalSinceNow: oneDay * days];
        [datePicker setMinimumDate:appointDate];
        [datePicker setDate:appointDate];
        
    }else if ([self.type isEqualToString:@"出生日期"]){
        
        [datePicker setMaximumDate:[NSDate date]];
    }
    //设置时间格式
    if (self.date.length != 0) {
        
        [datePicker setDate:[NSDate dateWithTimeIntervalSince1970:[self.date longLongValue]/1000]];
    }
    
    datePicker.datePickerMode = PGDatePickerModeTime;
    datePicker.delegate = self;
    datePicker.selectedDate = ^(NSDateComponents *dateComponents) {
        
        MyLog(@"%@",dateComponents);
    };
    self.datePicker = datePicker;
    [self.contentView addSubview:self.datePicker];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(line.mas_bottom).offset(10 * AutoSizeScaleY);
        make.left.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(- 10 * AutoSizeScaleY);
    }];
    
}

- (void)functionClick:(UIButton *)button{
    
    [self dismiss];
    [self.datePicker tapSelectedHandler];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    dateFormatter.dateFormat=@"yyyy-MM-dd";//指定转date得日期格式化形式
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.selectDateTapAction) {
            
            NSCalendar * calendar = [NSCalendar currentCalendar];
            NSDate * date = [calendar dateFromComponents:self.dateComponents];
            self.selectDateTapAction([dateFormatter stringFromDate:date]);
        }
    });
}
#pragma  mark PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    
    self.dateComponents = dateComponents;
    MyLog(@"%@",dateComponents.date);
}
+ (void)showPeriodDateWithTitle:(NSString *)title BlockTapAction:( void(^)(NSString * date) )blockTapAction{
    
    BMBottomPopView *modeView = [[BMBottomPopView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, Z_SCREENH_HEIGHT - SafeAreaBottomHeight)];
    modeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    modeView.alpha = 0;
    modeView.type = title;
    modeView.selectDateTapAction = blockTapAction;
    [[UIApplication sharedApplication].keyWindow addSubview:modeView];
    // 创建内容
    [modeView bulidDateView];
    [modeView show];
    
    //    [modeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:modeView action:@selector(dismiss)]];
}
- (void)bulidDateView{
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, Z_SCREENH_HEIGHT, Z_SCREEN_WIDTH, 240 * AutoSizeScaleY)];
    CGFloat CornerRadius = 36 * AutoSizeScaleX;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(0, 0)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.contentView.layer addSublayer:shapeLayer];
    [self addSubview:self.contentView];
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor getUsualColorWithString:@"#333333"] forState:UIControlStateNormal];
    cancelBtn.tag = 1;
    [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cancelBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(90 * AutoSizeScaleX, 44 * AutoSizeScaleY));
    }];
    
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [confirmBtn setTitle:@"完成" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor getUsualColorWithString:@"#333333"] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 2;
    [self.contentView addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.right.mas_equalTo(self.contentView);
        make.size.mas_equalTo(cancelBtn);
    }];
    
    UILabel * titleLb = [[UILabel alloc] init];
    titleLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
    titleLb.font = [UIFont systemFontOfSize:15.f];
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.text = self.type;
    [self.contentView addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.height.equalTo(confirmBtn);
        make.centerX.equalTo(self.contentView);
    }];
    
    UIView * line = [[UIView alloc] init];
    line.backgroundColor = [UIColor getUsualColorWithString:@"#E0E0E0"];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(confirmBtn.mas_bottom);
        make.height.mas_equalTo(1);
        
    }];
    
    UIDatePicker * sysDatePicker = [[UIDatePicker alloc] init];
//    sysDatePicker.backgroundColor = [UIColor redColor];
    sysDatePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh-Hans"];
    sysDatePicker.datePickerMode=UIDatePickerModeTime;
    self.sysDatePicker = sysDatePicker;
    [self.contentView addSubview:self.sysDatePicker];
    [self.sysDatePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(line.mas_bottom).offset(10 * AutoSizeScaleY);
        make.left.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(- 10 * AutoSizeScaleY);
    }];
    
}
- (void)confirm{
    
    [self dismiss];
    NSDate * date = self.sysDatePicker.date;
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    dateFormatter.dateFormat=@"HH:mm";//指定转date得日期格式化形式
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.selectDateTapAction) {
            
            self.selectDateTapAction([dateFormatter stringFromDate:date]);
        }
    });
}
+ (void)showWeekDateBlockTapAction:(void(^)(NSString * date) )blockTapAction{
    
    BMBottomPopView *modeView = [[BMBottomPopView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, Z_SCREENH_HEIGHT - SafeAreaBottomHeight)];
    modeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    modeView.alpha = 0;
    modeView.selectDateTapAction = blockTapAction;
    modeView.selectWeekArr = [NSMutableArray array];
    [[UIApplication sharedApplication].keyWindow addSubview:modeView];
    // 创建内容
    [modeView bulidWeekView];
    [modeView show];
    
    //    [modeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:modeView action:@selector(dismiss)]];
}

- (void)bulidWeekView{
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, Z_SCREENH_HEIGHT, Z_SCREEN_WIDTH, 324 * AutoSizeScaleY)];
    CGFloat CornerRadius = 36 * AutoSizeScaleX;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(0, 0)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.contentView.layer addSublayer:shapeLayer];
    [self addSubview:self.contentView];
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor getUsualColorWithString:@"#333333"] forState:UIControlStateNormal];
    cancelBtn.tag = 1;
    [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cancelBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(90 * AutoSizeScaleX, 44 * AutoSizeScaleY));
    }];
    
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [confirmBtn setTitle:@"完成" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor getUsualColorWithString:@"#333333"] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 2;
    [self.contentView addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.right.mas_equalTo(self.contentView);
        make.size.mas_equalTo(cancelBtn);
    }];
    
    UILabel * titleLb = [[UILabel alloc] init];
    titleLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
    titleLb.font = [UIFont systemFontOfSize:15.f];
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.text = @"选择周期";
    [self.contentView addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.height.equalTo(confirmBtn);
        make.centerX.equalTo(self.contentView);
    }];
    
    UIView * line = [[UIView alloc] init];
    line.backgroundColor = [UIColor getUsualColorWithString:@"#E0E0E0"];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(confirmBtn.mas_bottom);
        make.height.mas_equalTo(1);
        
    }];
    
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(line.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
    
}
- (void)finish{
    
    [self dismiss];
    
    NSArray *sortedArray = [self.selectWeekArr sortedArrayUsingComparator:^NSComparisonResult(NSString *p1, NSString *p2){
        //对数组进行排序（升序）
        return [p1 compare:p2];
        //对数组进行排序（降序）
        // return [p2.dateOfBirth compare:p1.dateOfBirth];
    }];
    NSString * week = [sortedArray componentsJoinedByString:@","];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.selectDateTapAction) {
            
            self.selectDateTapAction(week);
        }
    });
}

#pragma mark ******tableViewDelegate&Datasource******

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40 * AutoSizeScaleY;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * titleArr = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日",];
    BMWeekTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BMWeekTableViewCellID forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BMWeekTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BMWeekTableViewCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.title = titleArr[indexPath.row];
    cell.select = NO;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSArray * titleArr = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
    NSArray * titleArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"0"];
    BMWeekTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.select = !cell.select;
    if (cell.select) {
        
        [self.selectWeekArr addObject:titleArr[indexPath.row]];
        
    }else{
        
        [self.selectWeekArr removeObject:titleArr[indexPath.row]];
    }
}


- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[BMWeekTableViewCell class] forCellReuseIdentifier:BMWeekTableViewCellID];
    }
    return _tableView;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end



