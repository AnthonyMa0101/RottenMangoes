//
//  DetailViewController.h
//  Rotten Mangoes
//
//  Created by Anthony Ma on 2016-07-19.
//  Copyright © 2016 Anthony Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface DetailViewController : UIViewController

@property (nonatomic, weak) Movie *movieItem;

@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;

@property (weak, nonatomic) IBOutlet UILabel *reviewText;


@end
