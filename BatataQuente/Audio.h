//
//  Audio.h
//  BatataQuente
//
//  Created by Rafael Aparecido de Freitas on 21/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface Audio : NSObject

{
 AVAudioPlayer *playerBatata;
 AVAudioPlayer *playerQuente;
 AVAudioPlayer *playerQueimou;
}


-(void)playBatata;
-(void)playQuente;
-(void)playQueimou;
-(void )stopSounds;

@end
