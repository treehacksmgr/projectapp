//
//  MapAnnotation.h
//  app3
//
//  Created by Ginger Dudley on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface MapAnnotation : NSObject<MKAnnotation>
@property (nonatomic, copy) NSString *title;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;

- (id)initWithTitle:(NSString *)title andCoordinate:
(CLLocationCoordinate2D)coordinate2d;
-(MKAnnotationView *) annotationView;

@end

