//
//  CollectionViewController.m
//  Rotten Mangoes
//
//  Created by Anthony Ma on 2016-07-18.
//  Copyright © 2016 Anthony Ma. All rights reserved.
//

#import "CollectionViewController.h"
#import "DetailViewController.h"
#import "CollectionViewCell.h"
#import "Movie.h"

@interface CollectionViewController ()

@property NSMutableArray *movies;

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=c9zzxwtuc3q2tftqata3k59w"];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        NSLog(@"Request Done");
        
        if (!error) {
            
            NSError *jsonError;
            
            NSDictionary *movieListings = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            if (!jsonError) {
                
                NSLog(@"Data: %@", data);
                
                NSLog(@"JSON: %@", movieListings);
                
                NSMutableArray *movies = [NSMutableArray array];
                
                for (NSDictionary *movieLabels in movieListings[@"movies"]) {
                    if ([movieLabels isKindOfClass:[NSDictionary class]]) {
                        Movie *movie = [[Movie alloc] init];
                        NSString *imageString = movieLabels[@"posters"][@"thumbnail"];
                        NSURL *urlImage = [NSURL URLWithString:imageString];
                        NSData *imageData = [NSData dataWithContentsOfURL:urlImage];
                        movie.title = movieLabels[@"title"];
                        movie.movieImage = [UIImage imageWithData:imageData];
                        movie.year = [movieLabels[@"year"] intValue];
                        movie.runtime = [movieLabels[@"runtime"] intValue];
                        [movies addObject:movie];
                    }
                    else {
                        NSLog(@"NO");
                    }
                }
                
            
                self.movies = movies;
            
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.title = [NSString stringWithFormat:@"In Theatres Movies"];
                [self.collectionView reloadData];
            });
            
        }
        }
        
        
        else {
            NSLog(@"Request error: %@", error.localizedDescription);
        }
        
    }];
    
    [dataTask resume];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        DetailViewController *detailView = (DetailViewController *)[segue destinationViewController];
        Movie *movie = self.movies[indexPath.item];
        detailView.movieItem = movie;
    }
    
    // Pass the selected object to the new view controller.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"customCell" forIndexPath:indexPath];
    
    Movie *movie = self.movies[indexPath.item];
    
    cell.movieImage.image = movie.movieImage;
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
