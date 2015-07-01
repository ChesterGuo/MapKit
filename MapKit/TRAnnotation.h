//
//  TRAnnotation.h
//  MapKit
//
//  Created by tarena on 15/6/19.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;
@interface TRAnnotation : NSObject<MKAnnotation>
@property (nonatomic)CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;


@end
