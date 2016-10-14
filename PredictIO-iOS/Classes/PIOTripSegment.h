//
//  PIOTripSegment.h
//  PredictIOSDK
//
//  Created by Abdul Haseeb on 8/8/16.
//  Copyright (c) 2016 predict.io by ParkTAG GmbH. All rights reserved.
//  Version 3.0.2

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/*
 * PredictIOStatus
 * Discussion: Represents the current predict.io state.
 */
typedef NS_ENUM(int, PredictIOStatus) {
    // predict.io is in a working/active state
    PredictIOStatusActive = 0,
    
    // predict.io not in a working state as the location services are disabled
    PredictIOStatusLocationServicesDisabled,
    
    // predict.io has not been authorized by user to use location services at any time (kCLAuthorizationStatusAuthorizedAlways)
    PredictIOStatusInsufficientPermission,
    
    // predict.io has not been started. It is in inactive state.
    PredictIOStatusInActive
};

/*
 * TransportationMode
 * Discussion: Represents the vehicle transportation mode, determined by the predict.io
 */
typedef NS_ENUM(int, TransportationMode) {
    // current transportation mode is Undetermined
    TransportationModeUndetermined = 0,
    
    // current transportation mode is Car
    TransportationModeCar,
    
    // current transportation mode is other than Car
    TransportationModeNonCar
};

/*
 * LogLevel
 * Discussion: Represents the current predict.io logger state.
 */
typedef NS_ENUM(int, LogLevel)  {
    LogLevelNone = 0, LogLevelDebug
};

@interface PIOTripSegment : NSObject

/** @brief Trip Segment UUID */
@property (strong, readonly) NSString *UUID;

/** @brief Location from where the user departed */
@property (strong, readonly) CLLocation *departureLocation;

/** @brief Start time of trip */
@property (strong, readonly) NSDate *departureTime;

/** @brief Location where the user arrived and ended the trip */
@property (strong, readonly) CLLocation *arrivalLocation;

/** @brief Stop time of trip */
@property (strong, readonly) NSDate *arrivalTime;

/** @brief Predicted mode of transport */
@property (assign, readonly) TransportationMode transportationMode;

- (id)initWithUUID:(NSString *)UUID
 departureLocation:(CLLocation *)departureLocation
   arrivalLocation:(CLLocation *)arrivalLocation
     departureTime:(NSDate *)departureTime
       arrivalTime:(NSDate *)arrivalTime
transportationMode:(TransportationMode)transportationMode;

@end
