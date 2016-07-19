//
//  Movie.h
//  Rotten Mangoes
//
//  Created by Anthony Ma on 2016-07-18.
//  Copyright © 2016 Anthony Ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *movieImage;

@property (nonatomic) int year;
@property (nonatomic) int runtime;


@end
