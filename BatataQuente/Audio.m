//
//  Audio.m
//  BatataQuente
//
//  Created by Rafael Aparecido de Freitas on 21/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import "Audio.h"

@implementation Audio

-(void)playQueimou{
    
    [self stopSounds];
    
    NSString *url = [[NSString alloc]initWithFormat:@"Queimou.wav" ];
    
    if (![playerQueimou isPlaying]) {
        [self QueimouPlayFile:url];
        [playerQueimou setNumberOfLoops:0];
        [playerQueimou setVolume:1.0];
    }
    
}

-(void)QueimouPlayUrl:(NSURL *) url{
    
    if (!playerQueimou) {
        
        
        
        NSError *error;
        
        playerQueimou = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        
        
        
        if (!error) {
            
            [playerQueimou play];
            
        }else{
            NSLog(@"Erro: %@",[error localizedDescription]);
        }
    }else{
        [playerQueimou play];
        [playerQueimou setNumberOfLoops:0];
    }
    
}


-(void)QueimouPlayFile:(NSString *) arquivo{
    
    
    if (!playerQueimou) {
        NSString *path = [[[NSBundle mainBundle]resourcePath]stringByAppendingString:@"/"];
        
        path = [path stringByAppendingString:arquivo];
        
        NSURL *url = [NSURL fileURLWithPath:path];
        [self QueimouPlayUrl:url];
    }else{
        [playerQueimou play];
        [playerQueimou setNumberOfLoops:0];
    }
    
}





-(void)playBatata{
    [self stopSounds];
    
    NSString *url = [[NSString alloc]initWithFormat:@"Batata.wav" ];
    if (![playerBatata isPlaying]) {
        [self BatataPlayFile:url];
        [playerBatata setNumberOfLoops:0];
        [playerBatata setVolume:1.0];
    }
    
}

-(void)BatataPlayUrl:(NSURL *) url{
    
    if (!playerBatata) {
       
        
        NSError *error;
        
        playerBatata = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        
        
        
        if (!error) {
            [playerBatata play];
            
        }else{
            NSLog(@"Erro: %@",[error localizedDescription]);
        }
    }else{
        [playerBatata play];
        [playerBatata setNumberOfLoops:0];
    }
    
}


-(void)BatataPlayFile:(NSString *) arquivo{
    
    
    if (!playerBatata) {
        NSString *path = [[[NSBundle mainBundle]resourcePath]stringByAppendingString:@"/"];
        
        path = [path stringByAppendingString:arquivo];
        
        NSURL *url = [NSURL fileURLWithPath:path];
        [self BatataPlayUrl:url];
    }else{
        [playerBatata play];
        [playerBatata setNumberOfLoops:0];
    }
    
}




-(void)playQuente{
    
    [self stopSounds];
    NSString *url = [[NSString alloc]initWithFormat:@"Quente.wav" ];
    if (![playerQuente isPlaying]) {
        [self quentePlayFile:url];
        [playerQuente setNumberOfLoops:-1];
        [playerQuente setVolume:1.0];
    }
    
}

-(void)quentePlayUrl:(NSURL *) url{
    
    if (!playerQuente) {
        
        
        NSError *error;
        
        playerQuente = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        
        
        
        if (!error) {
            
            [playerQuente play];
            
        }else{
            NSLog(@"Erro: %@",[error localizedDescription]);
        }
    }else{
        [playerQuente play];
        [playerQuente setNumberOfLoops:-1];
    }
    
}


-(void)quentePlayFile:(NSString *) arquivo{
    
    
    if (!playerQuente) {
        NSString *path = [[[NSBundle mainBundle]resourcePath]stringByAppendingString:@"/"];
        
        path = [path stringByAppendingString:arquivo];
        
        NSURL *url = [NSURL fileURLWithPath:path];
        [self quentePlayUrl:url];
    }else{
        [playerQuente play];
        [playerQuente setNumberOfLoops:-1];
    }
    
}



-(void )stopSounds{
    [ playerQueimou stop];
    [playerQuente stop];
    [playerBatata stop];
}





@end
