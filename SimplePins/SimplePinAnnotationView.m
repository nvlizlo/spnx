//
//  SimplePinAnnotationView.m
//  SimplePins
//
//  Created by Nazariy Vlizlo on 12/14/15.
//  Copyright © 2015 Nazariy Vlizlo. All rights reserved.
//

#import "SimplePinAnnotationView.h"
#import "SimplePinAnnotation.h"
#import "Defines.h"
#import "MapViewController.h"

@implementation SimplePinAnnotationView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        self.pinColor = MKPinAnnotationColorRed;
        self.enabled = YES;
        self.canShowCallout = YES;
        self.animatesDrop = YES;
        self.draggable = YES;
        UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [detailButton addTarget:self action:@selector(detailButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.rightCalloutAccessoryView = detailButton;
    }
    return self;
}

- (void)detailButtonPressed:(UIButton *)sender {
    SimplePinAnnotation *annotation = self.annotation;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Choose name" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Delete"style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] postNotificationName:REMOVE_ANNOTATION object:nil userInfo:@{@"annotation" : self.annotation}];
    }];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        annotation.title = alertController.textFields.firstObject.text;
        annotation.subtitle = alertController.textFields.lastObject.text;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       textField.placeholder = @"Enter a name";
        textField.text = annotation.title;
        textField.textAlignment = NSTextAlignmentCenter;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Enter a description";
        textField.text = annotation.subtitle;
        textField.textAlignment = NSTextAlignmentCenter;
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code

}

@end
