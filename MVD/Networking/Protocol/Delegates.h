//
//  MCProtocol.h
//  MobileBanking
//
//  Created by Sergey Sasin on 15.04.13.
//  Copyright (c) 2013 BPC. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol PersonsDelegate <NSObject>
- (void) personsComplete:(NSArray *)persons;
@end
@protocol RanksDelegate <NSObject>
- (void) ranksComplete:(NSDictionary *)ranks;
@end
@protocol PostsDelegate <NSObject>
- (void) postsComplete:(NSDictionary *) posts;
@end
@protocol ResourcesExchangeDelegate <NSObject>
- (void) getImageComplete:(int)result image:(UIImage*)image imgId:(NSString*)imageId reqId:(id)requestId;
@end


