//
//  encoder.m
//  appTest
//
//  Created by yanli on 2017/7/3.
//  Copyright © 2017年 YY inc. All rights reserved.
//

#import "encoder.h"

@implementation encoder

- (id)init {
    
    self.name = @"DW video codec base interface.";
    self.standard = DWVideoStandardNone;
    self.index = DWCodecIndexNone;
    
    return self;
}

+ (NSString *)listEncoders
{
    NSMutableString* encoderNames = [[NSMutableString alloc] init];
    CFArrayRef encoders;
    VTCopyVideoEncoderList(NULL, &encoders);
    CFIndex size = CFArrayGetCount(encoders);
    NSLog(@"%ld encoders", size);
    for(CFIndex i = 0; i< size; i++){
        CFDictionaryRef encoder = CFArrayGetValueAtIndex(encoders, i);
        CFStringRef name = CFDictionaryGetValue(encoder, kVTVideoEncoderList_CodecName);
        NSString *encoderDesc = [[NSString alloc] initWithFormat:@"%ld - %@\n", i, name];
        [encoderNames appendString:encoderDesc];
    }
    CFRelease(encoders);
    return encoderNames;
}

-(BOOL)reset:(DWEncodeParam *)params {
    return YES;
}

-(BOOL)encode:(CMSampleBufferRef)buffer {
    // nil, just placehold
    return YES;
}

-(BOOL)flush {
    return YES;
}

-(BOOL)destory {
    return YES;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"%@ - %@ - %@", @(self.standard), @(self.index), self.name];
}

-(void)setPacketBufferDelegate:(id<EncoderDataDelegate>)packetBufferDelegate
{
    self.delegate = packetBufferDelegate;
}

@end
