//
//  BMChooseGroupPopView.m
//  BMApp
//
//  Created by Mac on 2019/11/4.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMChooseGroupPopView.h"

@interface BMChooseGroupPopView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UIView * contentView;
@property(nonatomic ,strong)UILabel * tipLb;
@property(nonatomic ,strong)UILabel * contentLb;
@property (nonatomic, copy) void (^blockTapAction)(BMClusterModel * cluModel);
@property(nonatomic ,strong)UIButton * leftBtn;
@property(nonatomic ,strong)UIButton * rightBtn;
@property(nonatomic ,strong)UITableView * tableView;


@property(nonatomic ,copy)NSString * title;
@property(nonatomic ,strong)NSMutableArray * sourceArr;
@end

@implementation BMChooseGroupPopView


+ (void)showWithGroupArr:(NSMutableArray *)arr blockTapAction:(void(^)(BMClusterModel * cluModel))blockTapAction{
    BMChooseGroupPopView *modeView = [[BMChooseGroupPopView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, Z_SCREENH_HEIGHT)];
    modeView.blockTapAction = blockTapAction;
    modeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    modeView.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:modeView];
    // 创建内容
    modeView.sourceArr = arr;
    [modeView bulidContentView];
    [modeView show];
//    [modeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:modeView action:@selector(dismiss)]];
    
}

- (void)bulidContentView{
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(38 * AutoSizeScaleX, Z_SCREENH_HEIGHT, Z_SCREEN_WIDTH - 76 * AutoSizeScaleX, 200 * AutoSizeScaleY)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    ZViewBorderRadius(self.contentView, 6, 0, [UIColor whiteColor]);
    self.contentView.clipsToBounds = YES;
    [self addSubview:self.contentView];
    [self bulidContent];
}

-(void)bulidContent{
    
    self.tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[BMChooseGroupTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BMChooseGroupTableViewCell class])];
    [self.contentView addSubview:self.tableView];
    
}
#pragma mark ******tableViewDelegate&Datasource******

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50 * AutoSizeScaleY;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.sourceArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    BMChooseGroupTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BMChooseGroupTableViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BMChooseGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([BMChooseGroupTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.sourceArr[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BMClusterModel * clu = self.sourceArr[indexPath.row];
    if (self.blockTapAction) {
        
        self.blockTapAction(clu);
    }
    [self dismiss];
}

- (void)show{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.alpha = 1;
        self.contentView.transform = CGAffineTransformMakeTranslation(0,- Z_SCREENH_HEIGHT + Z_SCREENH_HEIGHT / 2 - 70 * AutoSizeScaleY);
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

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end


@interface BMChooseGroupTableViewCell()

@property(nonatomic ,strong)UIImageView *imgView;
@property(nonatomic ,strong)UILabel *titleLb;
@property(nonatomic ,strong)UIImageView *arrowImgView;

@end

@implementation BMChooseGroupTableViewCell

- (void)setModel:(BMClusterModel *)model{
    
    _model = model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.picUrl]] placeholderImage:nil];
    self.titleLb.text = model.name;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.arrowImgView];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(15 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(20 * AutoSizeScaleX, 20 * AutoSizeScaleX));
        }];
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.imgView.mas_right).offset(12 * AutoSizeScaleX);
            make.height.equalTo(self.contentView);
        }];
        [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(- 15 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(7 * AutoSizeScaleX, 13 * AutoSizeScaleX));
        }];
        
    }
    return self;
}
#pragma mark ======  lazy  ======
- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        ZViewBorderRadius(_imgView, 10 * AutoSizeScaleX, 0, [UIColor whiteColor]);
    }
    return _imgView;
}
- (UIImageView *)arrowImgView{
    
    if (!_arrowImgView) {
        
        _arrowImgView = [[UIImageView alloc] init];
        [_arrowImgView setImage:[UIImage imageNamed:@"my_icon_sanjiao1"]];
        _arrowImgView.contentMode = UIViewContentModeScaleAspectFill;
        _arrowImgView.clipsToBounds = YES;
        
    }
    return _arrowImgView;
}
- (UILabel *)titleLb{
    
    if (!_titleLb) {
        
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = [UIColor getUsualColorWithString:@"#000000"];
        _titleLb.font = [UIFont systemFontOfSize:15.f];
        _titleLb.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLb;
}

@end
