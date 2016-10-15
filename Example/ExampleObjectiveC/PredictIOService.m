//
//  PredictIOService.m
//  ExampleObjectiveC
//
//  Created by ParkTAG on 8/23/16.
//  Copyright (c) 2016 predict.io by ParkTAG GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PredictIOService.h"
#import "AppDelegate.h"
#import "EventViaNotification.h"
#import "EventViaDelegate.h"

#define API_KEY      @"YOUR-API-KEY"

@interface PredictIOService ()<PredictIODelegate>

@end

@implementation PredictIOService

- (id)init {
    self = [super init];
    if (self) {
        PredictIO *predictIO = [PredictIO sharedInstance];
        predictIO.delegate = self;
        predictIO.apiKey = API_KEY;
        [self registerForPredictIONotifications];
    }
    return self;
}

- (void)registerForPredictIONotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(departingViaNotification:)
                                                 name:PIODepartingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(departedViaNotification:)
                                                 name:PIODepartedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(departureCanceledViaNotification:)
                                                 name:PIODepartureCanceledNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(transportationModeViaNotification:)
                                                 name:PIOTransportationModeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(arrivalSuspectedViaNotification:)
                                                 name:PIOArrivalSuspectedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(arrivedViaNotification:)
                                                 name:PIOArrivedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(searchingInPerimeterViaNotification:)
                                                 name:PIOSearchingParkingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(searchingInPerimeterViaNotification:)
                                                 name:PIOSearchingParkingNotification object:nil];
}

- (void)resume {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL predictIOEnabled = [defaults boolForKey:@"PredictIOEnabled"];
    if (predictIOEnabled) {
        [[PredictIO sharedInstance] startWithCompletionHandler:^(NSError *error) {
            if (error) {
                [NSOperationQueue.mainQueue addOperationWithBlock:^{
                    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
                    NSString *errorTitle = error.userInfo[@"NSLocalizedFailureReason"];
                    NSString *errorDescription = error.userInfo[@"NSLocalizedDescription"];
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:errorTitle
                                                                                             message:errorDescription
                                                                                      preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *alertActionOK = [UIAlertAction
                                                    actionWithTitle:@"OK"
                                                    style:UIAlertActionStyleDefault
                                                    handler:nil];
                    [alertController addAction:alertActionOK];
                    [rootViewController presentViewController:alertController animated:YES completion:nil];
                    NSLog(@"<predict.io> API Key: %@ %@", errorTitle, errorDescription);
                    [defaults setBool:NO forKey:@"PredictIOEnabled"];
                    [defaults synchronize];
                }];
            } else {
                NSLog(@"Started predict.io...");
            }
        }];
    }
}

- (void)startWithCompletionHandler:(void(^)(NSError *error))handler {
    [[PredictIO sharedInstance] startWithCompletionHandler: handler];
    // set to run PredictIO on every app launch
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"PredictIOEnabled"];
    [defaults synchronize];
}

- (void)stop {
    [[PredictIO sharedInstance] stop];
    NSLog(@"stopped predict.io...");
    // unset to run PredictIO on next app launch
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:@"PredictIOEnabled"];
    [defaults synchronize];
}

#pragma mark - PredictIO Delegate methods

- (void)departing:(PIOTripSegment *)tripSegment {
    [self insertEventViaDelegate:Departing location:tripSegment.departureLocation mode:tripSegment.transportationMode];
    NSLog(@"Delegate - departing");
}

- (void)departed:(PIOTripSegment *)tripSegment {
    [self insertEventViaDelegate:Departed location:tripSegment.departureLocation mode:tripSegment.transportationMode];
    NSLog(@"Delegate - departed");
}

- (void)departureCanceled:(PIOTripSegment *)tripSegment {
    [self insertEventViaDelegate:DepartureCanceled location:tripSegment.departureLocation mode:tripSegment.transportationMode];
    NSLog(@"Delegate - departureCanceled");
}

- (void)transportationMode:(PIOTripSegment *)tripSegment {
    [self insertEventViaDelegate:TransportMode location:tripSegment.departureLocation mode:tripSegment.transportationMode];
    NSLog(@"Delegate - transportationMode: %d", tripSegment.transportationMode);
}

- (void)arrivalSuspected:(PIOTripSegment *)tripSegment {
    [self insertEventViaDelegate:ArrivalSuspected location:tripSegment.arrivalLocation mode:tripSegment.transportationMode];
    NSLog(@"Delegate - arrivalSuspected");
}

- (void)arrived:(PIOTripSegment *)tripSegment {
    [self insertEventViaDelegate:Arrived location:tripSegment.arrivalLocation mode:tripSegment.transportationMode];
    NSLog(@"Delegate - arrived");
}

- (void)searchingInPerimeter:(CLLocation *)searchingLocation {
    [self insertEventViaDelegate:Searching location:searchingLocation mode:TransportationModeUndetermined];
    NSLog(@"Delegate - searchingInPerimeter");
}

- (void)didUpdateLocation:(CLLocation *)location {
    // NSLog(@"Delegate - didUpdateLocation");
}

#pragma - mark notifications

- (void)departingViaNotification:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    PIOTripSegment *tripSegment = userInfo[@"tripSegment"];
    [self insertEventViaNotification:Departing location:tripSegment.departureLocation mode:tripSegment.transportationMode];
    NSLog(@"Notification - departing");
}

- (void)departedViaNotification:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    PIOTripSegment *tripSegment = userInfo[@"tripSegment"];
    [self insertEventViaNotification:Departed location:tripSegment.departureLocation mode:tripSegment.transportationMode];
    NSLog(@"Notification - departed");
}

- (void)departureCanceledViaNotification:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    PIOTripSegment *tripSegment = userInfo[@"tripSegment"];
    [self insertEventViaNotification:DepartureCanceled location:tripSegment.departureLocation mode:tripSegment.transportationMode];
    NSLog(@"Notification - departedCanceled");
}

- (void)transportationModeViaNotification:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    PIOTripSegment *tripSegment = userInfo[@"tripSegment"];
    [self insertEventViaNotification:TransportMode location:nil mode:tripSegment.transportationMode];
    NSLog(@"Notification - transportationMode: %d", tripSegment.transportationMode);
}

- (void)arrivalSuspectedViaNotification:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    PIOTripSegment *tripSegment = userInfo[@"tripSegment"];
    [self insertEventViaNotification:ArrivalSuspected location:tripSegment.arrivalLocation mode:tripSegment.transportationMode];
    NSLog(@"Notification - arrived suspected");
}

- (void)arrivedViaNotification:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    PIOTripSegment *tripSegment = userInfo[@"tripSegment"];
    [self insertEventViaNotification:Arrived location:tripSegment.arrivalLocation mode:tripSegment.transportationMode];
    NSLog(@"Notification - arrived");
}

- (void)searchingInPerimeterViaNotification:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    CLLocation *location = userInfo[@"location"];
    [self insertEventViaNotification:Departing location:location mode:TransportationModeUndetermined];
    NSLog(@"Notification - searchingInPerimeter");
}

#pragma - mark core data

- (void)insertEventViaDelegate:(PredictIOEventType)type location:(CLLocation *)location mode:(TransportationMode)transportationMode {
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    EventViaDelegate *event = [NSEntityDescription insertNewObjectForEntityForName:@"EventViaDelegate" inManagedObjectContext:context];
    event.longitude = @(location.coordinate.longitude);
    event.latitude = @(location.coordinate.latitude);
    event.accuracy = @(location.horizontalAccuracy);
    event.timeStamp = [NSDate new];
    event.type = @(type);
    event.mode = @(transportationMode);

    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void)insertEventViaNotification:(PredictIOEventType)type location:(CLLocation *)location mode:(TransportationMode)transportationMode {
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    EventViaNotification *event = [NSEntityDescription insertNewObjectForEntityForName:@"EventViaNotification" inManagedObjectContext:context];
    event.longitude = @(location.coordinate.longitude);
    event.latitude = @(location.coordinate.latitude);
    event.accuracy = @(location.horizontalAccuracy);
    event.timeStamp = [NSDate new];
    event.type = @(type);
    event.mode = @(transportationMode);

    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

@end
