//
//  ImagensTelaPartida.h
//  BatataQuente
//
//  Created by Felipe Costa Nascimento on 25/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControladorDePosicoes.h"

@interface ImagensTelaPartida : UIView
{
    NSMutableArray *arrayFotos;
    
    NSMutableArray *arrayIcones;
    
    ControladorDePosicoes *controladorPosicoes;
}


- (id)initWithFrame:(CGRect)frame isIpad:(BOOL)device;
-(void)setImagemFoto:(int)index imagem:(UIImage*)img;

@end
