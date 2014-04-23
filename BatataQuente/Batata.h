//
//  Batata.h
//  BatataQuente
//
//  Created by Felipe Costa Nascimento on 21/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Batata : NSObject

@property UIImage *imagemBatata;


-(CABasicAnimation*)animacaoEnviarWithPosition:(CGPoint)posicao andDevice:(BOOL)isIpad;
@end
