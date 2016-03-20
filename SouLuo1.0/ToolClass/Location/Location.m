//
//  Location.m
//  SouLuo1.0
//
//  Created by ls on 15/9/13.
//  Copyright (c) 2015年 LiuShuai. All rights reserved.
//

#import "Location.h"
#import <CoreLocation/CoreLocation.h>//引入库
#import <MapKit/MapKit.h>
@interface Location()<CLLocationManagerDelegate>//定位服务委托

//定位服务管理
@property (nonatomic , strong)CLLocationManager *locationManager;
//处理地理编码和逆地理编码
//地理编码：根据给定的位置（通常是地名） 确定地理坐标(经纬度)
//逆地理编码：可以根据地理坐标（经纬度）确定位置信息（街道、门牌等）
@property (nonatomic , strong)CLGeocoder *geocoder;

@end

@implementation Location
//创建单例
+(Location *)defaultLacation{
    
   
    
    static Location *location = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [[Location alloc]init];
     
    });
    return location;
}

//定位
-(void)selectLoaction{
    
    
    self.locationManager = [[CLLocationManager alloc]init];
    /* authorizationStatus 定位服务授权状态
     kCLAuthorizationStatusNotDetermined 用户尚未做出决定是否启用定位服务
     kCLAuthorizationStatusAuthorizedAlways 应用获得授权可以一直使用定位服务，即使应用不在使用状态 */
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        
        [_locationManager requestAlwaysAuthorization];
    }
    
//    if( [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
//        
        self.locationManager.delegate = self;
        
        //设置定位精度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        //定位频率，每隔多少米定位一次
        CLLocationDistance distace = 10.0;
        self.locationManager.distanceFilter = distace;
        
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
    
  //  }
    
    
    self.geocoder = [[CLGeocoder alloc]init];
    
   
}

//_locationManager的代理 位置改变就会调用
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [_locationManager stopUpdatingLocation];
    //取出第一个位置，包含CLLocationCoordinate2D; CLLocation（包含高度，经纬度等）
    CLLocation *clLocation = [locations firstObject];
    
    //位置坐标 是个结构体可以输出经纬度
    CLLocationCoordinate2D coorDinate = clLocation.coordinate;
    
    [self getAddressByLatitude:coorDinate.latitude longitude:coorDinate.longitude];
    
    
    //调用系统地图
   // 根据clLocation确定地理坐标placemarks(包含国家，城市，街道和周边信息等不是经纬度)
//    [self.geocoder reverseGeocodeLocation:clLocation completionHandler:^(NSArray *placemarks, NSError *error) {
//       
//        CLPlacemark *placemark =[placemarks firstObject];
//        
//        MKPlacemark *mkPlacemark = [[MKPlacemark alloc]initWithPlacemark:placemark];
//        
//        NSDictionary *options = @{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard)};
//        
//        MKMapItem *mapItem = [[MKMapItem alloc]initWithPlacemark:mkPlacemark];
//        
//        [mapItem openInMapsWithLaunchOptions:options];
//        
//    }];
    
}


//根据地理坐标定位位置（城市名，街道等）
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    

    //坐落位置由地理坐标，高度等
    CLLocation *location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
       
        CLPlacemark *placemark = [placemarks firstObject];
        if ([self.delegate respondsToSelector:@selector(locationCityName:)]) {
            //代理传值 传城市名
            [self.delegate locationCityName:placemark.addressDictionary[@"City"]];
        }
 
        
    }];
   
    
}

@end
