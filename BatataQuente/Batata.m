//
//  Batata.m
//  BatataQuente
//
//  Created by Felipe Costa Nascimento on 21/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import "Batata.h"

@implementation Batata

-(id)init{
    self = [super init];
    
    if(self){
        self.imagemBatata = [UIImage imageNamed:@"imagemBatata.png"];
    }
    
    return self;
}


-(CABasicAnimation*)animacaoEnviar:(CGPoint)posicao{
    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position.x"];
    move.fromValue = [NSValue valueWithCGPoint:posicao];
    
    posicao.x += 600;
    
    
    move.toValue = [NSValue valueWithCGPoint:posicao];
    move.duration = 1;
    move.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.56 :0.18 :0.25 :1.00];
    move.removedOnCompletion = NO;
    move.fillMode = kCAFillModeForwards;
    
    return move;
}


@end
