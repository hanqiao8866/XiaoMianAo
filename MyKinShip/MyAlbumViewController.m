//
//  MyAlbumViewController.m
//  MyKinShip
//
//  Created by 谢涛 on 15/2/12.
//  Copyright (c) 2015年 谢涛. All rights reserved.
//

#import "MyAlbumViewController.h"
#import "AlbumCollectionViewCell.h"

@interface MyAlbumViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIImageView* gotImage;
@property (nonatomic, strong) UICollectionView* tableView;
@property (nonatomic, strong) NSMutableArray *albumImages;
@end

@implementation MyAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureNavgationItemTitle:@"我的相册"];
    [self configureBarButtonItemStyle:XTBackButtonItemStyle action:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    
    [self initCollectionView];
    
    [self configureRightBarButtonWithTitle:nil withBackgroundImage:[UIImage imageNamed:@"addbtnimage"] action:^{
        DLog(@"添加按钮点击事件");
        //调用相册
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    _albumImages = [[NSMutableArray alloc]initWithCapacity:0];
    printf("_albumImages.count = %lu" , (unsigned long)[_albumImages count]);
    
    _gotImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 110)];
}

-(void)initCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    [flowLayout setItemSize:CGSizeMake(90,90)]; //设置每个cell显示数据的宽和高必须
    //[flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal]; //水平滑动
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical]; //控制滑动分页用
//    flowLayout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 0);
    
    //创建一屏的视图大小
    _tableView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height - 64) collectionViewLayout:flowLayout];
    //对Cell注册(必须否则程序会挂掉)
    [_tableView registerClass:[AlbumCollectionViewCell class] forCellWithReuseIdentifier:@"albumCell"];
    
    [_tableView setBackgroundColor:[UIColor whiteColor]];
    [_tableView setUserInteractionEnabled:YES];
    
    [_tableView setDelegate:self]; //代理－视图
    [_tableView setDataSource:self]; //代理－数据
    
    [self.view addSubview:_tableView];
}

//相册代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)aImage editingInfo:(NSDictionary *)editingInfo
{
    
    [_albumImages addObject:aImage];
    
    
    printf("selectet image");
    self.gotImage.image = aImage;

    [picker dismissViewControllerAnimated:YES completion: ^{
        [_tableView reloadData];
    } ];
}


#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_albumImages count];
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"albumCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    
    UIImage* image = [_albumImages objectAtIndex: indexPath.row];
    
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 110)];
    imageView.image = image;
    [cell.contentView addSubview:imageView];
//    if ([_albumImages count] > 0 ) {
//        printf("_albumImages.count = %lu" , (unsigned long)[_albumImages count]);
//
//        if (image != nil) {
//            
//            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 110)];
//            imageView.image = image;
//            [cell.contentView addSubview:imageView];
//        }
//    }
//    if (self.gotImage.image != nil)
//    {
    

//    }

    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(110, 110);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0,0,0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 2;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    return 0;
}

#pragma mark --UICollectionViewDelegate

//UICollectionView 某个cell被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"indexPath = %ld", (long)indexPath.row);
//    cell.backgroundColor = [UIColor whiteColor];

}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


@end
