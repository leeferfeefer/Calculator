//
//  operations.m
//  Calculator
//
//  Created by Lee Fincher on 2/7/16.
//  Copyright © 2016 Dan Fincher. All rights reserved.
//

#import "operations.h"

@implementation operations




#pragma mark - Addition

-(double)add:(double)number1 to:(double)number2{
    return number1 + number2;
}


#pragma mark - Subtraction

-(double)subtract:(double)number1 from:(double)number2{
    return number1 - number2;
}


#pragma mark - Multiplication

-(double)multiply:(double)number1 by:(double)number2{
    return number1 * number2;
}


#pragma mark - Division

-(double)divide:(double)number1 by:(double)number2{
    return number1/number2;
}







@end
