//
//  CounterComponentView.h
//  MVD
//
//  Created by Denis Kurochkin on 13.02.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CounterComponentView : UIView

@property (nonatomic, strong, readonly) UILabel *mainLabel;

//TEMPORARY!
@property (nonatomic, assign) NSUInteger iterations;
@property (nonatomic, assign) NSUInteger number;

- (void) animateComponent;


@end
