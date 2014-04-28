
//
//  ImagensTelaPartida.m
//  BatataQuente
//
//  Created by Felipe Costa Nascimento on 25/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import "ImagensTelaPartida.h"
#import "Reachability.h"

@implementation ImagensTelaPartida

- (id)initWithFrame:(CGRect)frame isIpad:(BOOL)ipad
{
    self = [super initWithFrame:frame];
    if (self) {
        
        controladorPosicoes = [[ControladorDePosicoes alloc] init];
        arrayFotos = [[NSMutableArray alloc] init];
        arrayIcones = [[NSMutableArray alloc] init];
        
        if (ipad) {
            [self instanciaArrayIpad];
        }else{
            [self instanciaArrayIphone];
        }
    }
    return self;
}


-(void)instanciaArrayIpad{
    for(int i=0; i<controladorPosicoes.countVetorPosicoes; i++){
        UIImageView *imgFoto = [[UIImageView alloc] initWithFrame:[controladorPosicoes retornaPosicaoIpadFoto:i]];
        UIImageView *imgIcone = [[UIImageView alloc] initWithFrame:[controladorPosicoes retornaPosicaoIpadIcone:i]];
        
        
        [arrayFotos addObject:imgFoto];
        [arrayIcones addObject:imgIcone];
    }
}


-(void)instanciaArrayIphone{
    for(int i=0; i<controladorPosicoes.countVetorPosicoes; i++){
        UIImageView *imgFoto = [[UIImageView alloc] initWithFrame:[controladorPosicoes retornaPosicaoIphoneFoto:i]];
        UIImageView *imgIcone = [[UIImageView alloc] initWithFrame:[controladorPosicoes retornaPosicaoIphoneIcone:i]];
        
        
        [arrayFotos addObject:imgFoto];
        [arrayIcones addObject:imgIcone];
    }
}



-(void)setImagemFoto:(int)index imagem:(NSString*)img{
    
    
    
    if(![self isImagemDoFace:img]){
        
        [self adicionarImagemFacebook:index :img];
    
    }else{
        UIImageView *imgViewFoto = [arrayFotos objectAtIndex:index];
        [imgViewFoto setImage:[UIImage imageNamed:img]];
        
        [arrayFotos replaceObjectAtIndex:index withObject:imgViewFoto];
    }
    
    
    
    [self addSubview:[arrayFotos objectAtIndex:index]];
    
    
   /*
    UIImageView *imgViewIcone = [arrayIcones objectAtIndex:index];
    [imgViewIcone setImage:[UIImage imageNamed:@"imagemPronto.png"]];
    
    [arrayIcones replaceObjectAtIndex:index withObject:imgViewIcone];
    
    [self addSubview:[arrayIcones objectAtIndex:index]];  */
    
    //[self alteraIcone:index status:YES];
}



-(void)adicionarImagemFacebook:(int)index :(NSString*)img{
    Reachability *networkReability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReability currentReachabilityStatus];
    
    if(networkStatus == NotReachable){
        UIImageView *imgViewFoto = [arrayFotos objectAtIndex:index];
        [imgViewFoto setImage:[UIImage imageNamed:@"foto-padrao-facebook.jpg"]];
        imgViewFoto.layer.borderWidth = 1.0f;
        imgViewFoto.layer.cornerRadius = CGRectGetWidth(imgViewFoto.bounds) / 2.0f;
        
        [arrayFotos replaceObjectAtIndex:index withObject:imgViewFoto];
        
        return;
    }
    
    CGRect frame = [[arrayFotos objectAtIndex:index] frame];
    FBProfilePictureView *foto = [[FBProfilePictureView alloc] initWithFrame:frame];
    [foto setProfileID:img];
    foto.layer.borderWidth = 1.0f;
    foto.layer.cornerRadius = CGRectGetWidth(foto.bounds) / 2.0f;
    
    [arrayFotos replaceObjectAtIndex:index withObject:foto];
}

-(void)alteraIcone:(int)index status:(BOOL)status{
    UIImageView *imgViewIcone = [arrayIcones objectAtIndex:index];
    
    if (status) {
        [imgViewIcone setImage:[UIImage imageNamed:@"imagemPronto.png"]];
    }else{
        [imgViewIcone setImage:[UIImage imageNamed:@"imagemEliminado.png"]];
    }
    
    
    
    [arrayIcones replaceObjectAtIndex:index withObject:imgViewIcone];
    
    [self addSubview:[arrayIcones objectAtIndex:index]];

}



-(BOOL)isImagemDoFace:(NSString*)img{
    if ([img rangeOfString:@".png"].location == NSNotFound) {
        return NO;
    }
    
    return YES;
}

@end
