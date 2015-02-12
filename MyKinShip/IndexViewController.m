//
//  IndexViewController.m
//  MyKinShip
//
//  Created by 谢涛 on 15/2/11.
//  Copyright (c) 2015年 谢涛. All rights reserved.
//

#import "IndexViewController.h" // 父母位置
#import "LocalWeatherViewController.h" // 当地天气
#import "ParentsBirthdayViewController.h" // 父母生日
#import "NoticeEatMedicineViewController.h" // 吃药提醒
#import "ChatViewController.h" // 聊贴心话
#import "MyAlbumViewController.h" // 我的相册
#import "MyVideoViewController.h" // 我的视频
#import "MyVoiceViewController.h" // 我的语音
#import "MySettingViewController.h" // 我的设置

@interface IndexViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    UIButton *backBtn; // 返回按钮
    
    BMKMapView *mapView; // 地图视图
    BMKLocationService *_locService; // 地图定位功能
    BMKGeoCodeSearch* _geocodesearch; // 地理编码转换
    
    UIView *showGeoView; // 显示地理坐标反编码后的地址视图
    UILabel *geolabel; // 显示反地理编码的地址
}

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self configureNavgationItemTitle:@"首页"];
    
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0 , 0, 30, 35);
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.hidden = YES;
    [backBtn setImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
    UIBarButtonItem *navBackBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = navBackBtn;
    
    mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHight)];
    [self.view addSubview:mapView]; // 添加百度地图
    [self.view addSubview:self.mainBackView]; // 添加选择视图
    
    //设置定位精确度，默认：kCLLocationAccuracyBest
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:100.f];
    
    // 初始化BMKLocationService
    _locService = [[BMKLocationService alloc] init];
    
    // 初始化BMKLocationService初始化反地理编码
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
   
    showGeoView = [[UIView alloc] initWithFrame:CGRectMake(10, MainScreenHight - 150, MainScreenWidth - 2*10, 45)];
    showGeoView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    showGeoView.layer.cornerRadius = 6.0f;
    showGeoView.layer.masksToBounds = YES;
    showGeoView.hidden = YES;
    [self.view addSubview:showGeoView];
    
    geolabel = [[UILabel alloc] initWithFrame:CGRectMake(4, 2, showGeoView.frame.size.width - 8, showGeoView.frame.size.height - 4)];
//    geolabel.text = @"北京市丰台区卢沟桥路晓月苑小区2里5号楼";
    geolabel.textColor = [UIColor whiteColor];
    geolabel.textAlignment = NSTextAlignmentCenter;
    geolabel.font = [UIFont systemFontOfSize:15.0f];
    [showGeoView addSubview:geolabel];
    
}

//根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    NSString *AnnotationViewID = @"annotationViewID";
    //根据指定标识查找一个可被复用的标注View，一般在delegate中使用，用此函数来代替新申请一个View
    BMKAnnotationView *annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
    
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    annotationView.canShowCallout = TRUE;
    return annotationView;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [mapView viewWillAppear];
    mapView.delegate = self;
    _locService.delegate = self;
    _geocodesearch.delegate = self;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [mapView viewWillDisappear];
    mapView.delegate = nil;
     _locService.delegate = nil;
    _geocodesearch.delegate = nil;
}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    DLog(@"start locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    DLog(@"location error");
}

#pragma mark -
#pragma mark BMKLocationServiceDelegate代理方法的实现
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
//    DLog(@"heading is %@",userLocation.heading);
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    DLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [mapView updateLocationData:userLocation];
    
    // 获取定位到的经纬度
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    DLog(@"pt lat %f,long %f",pt.latitude,pt.longitude);
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag) {
        DLog(@"反geo检索发送成功");
    } else {
        DLog(@"反geo检索发送失败");
    }

}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:mapView.annotations];
    [mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:mapView.overlays];
    [mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = @"父母位置";
        [mapView addAnnotation:item];
        mapView.centerCoordinate = result.location;
        
        showGeoView.hidden = NO;
        geolabel.text = [NSString stringWithFormat:@"%@",result.address];
    }
}


/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */


// 返回按钮点击事件
- (void)backBtnClick:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        self.mainBackView.frame = CGRectMake(0, 0, MainScreenWidth, 300);
        mapView.zoomLevel = 12;
    } completion:^(BOOL finished) {
        backBtn.hidden = YES;
        [self configureNavgationItemTitle:@"首页"];
        [_locService stopUserLocationService];
        mapView.showsUserLocation = NO;
        
        showGeoView.hidden = YES;
        // 同时删除地图上的大头针
        NSArray* array = [NSArray arrayWithArray:mapView.annotations];
        [mapView removeAnnotations:array];
        array = [NSArray arrayWithArray:mapView.overlays];
        [mapView removeOverlays:array];
    }];
}



- (IBAction)tapMainIconGesture:(UITapGestureRecognizer *)sender {
    DLog(@"%ld",(long)sender.view.tag);
    
    switch (sender.view.tag) {
        case 1:
        {
            DLog(@"父母位置点击");
            [UIView animateWithDuration:0.5 animations:^{
                self.mainBackView.frame = CGRectMake(0, -400, MainScreenWidth, 300);
                mapView.zoomLevel = 13;
                
            } completion:^(BOOL finished) {
                backBtn.hidden = NO;
                [self configureNavgationItemTitle:@"父母位置"];
                //启动LocationService
                [_locService startUserLocationService];
                mapView.showsUserLocation = NO;//先关闭显示的定位图层
                mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
                mapView.showsUserLocation = YES;//显示定位图层
                
                
            }];
        }
            break;
        case 2:
        {
            DLog(@"当地天气点击");
            LocalWeatherViewController *localWeather = [[LocalWeatherViewController alloc] init];
            [self pushNewViewController:localWeather];
        }
            break;
        case 3:
        {
            DLog(@"父母生日点击");
            ParentsBirthdayViewController *parentBirthday = [[ParentsBirthdayViewController alloc] init];
            [self pushNewViewController:parentBirthday];
        }
            break;
        case 4:
        {
            DLog(@"吃药提醒点击");
            NoticeEatMedicineViewController *noticeEat = [[NoticeEatMedicineViewController alloc] init];
            [self pushNewViewController:noticeEat];
        }
            break;
        case 5:
        {
            DLog(@"聊贴心话点击");
            ChatViewController *chatVC = [[ChatViewController alloc] init];
            [self pushNewViewController:chatVC];
            break;
        }
        case 6:
        {
            DLog(@"我的相册点击");
            MyAlbumViewController *album = [[MyAlbumViewController alloc] init];
            [self pushNewViewController:album];
        }
            break;
        case 7:
        {
            DLog(@"我的视频点击");
            MyVideoViewController *video = [[MyVideoViewController alloc] init];
            [self pushNewViewController:video];
        }
            break;
        case 8:
        {
            DLog(@"我的语音点击");
            MyVoiceViewController *voice = [[MyVoiceViewController alloc] init];
            [self pushNewViewController:voice];
        }
            break;
        case 9:
        {
            DLog(@"我的设置点击");
            MySettingViewController *setting = [[MySettingViewController alloc] init];
            [self pushNewViewController:setting];
        }
            break;
            
        default:
            break;
    }
    
    
}



@end
