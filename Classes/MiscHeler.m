//
//  MiscHeler.m
//  LazyImages
//
//  Created by Macbook on 05.10.10.
//  Copyright 2010 CleverUA. All rights reserved.
//

#import "MiscHeler.h"


@implementation MiscHeler

+ (void) alert:(NSString *)text
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Lazy Images" message: text delegate: nil cancelButtonTitle: @"Ok" otherButtonTitles: nil];
	[alert show];
	[alert release];	
}

@end
