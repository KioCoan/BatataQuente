//
//  ChatViewController.m
//  BatataQuente
//
//  Created by Felipe Costa Nascimento on 18/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import "ChatViewController.h"
#import "AppDelegate.h"

@interface ChatViewController ()

@property (nonatomic, strong)AppDelegate *appDelegate;

-(void)didReceiveDataWithNotification:(NSNotification *)notification;

@end


@implementation ChatViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveDataWithNotification:) name:@"MCDidReceiveDataNotification" object:nil];
    
    self.current = 20;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(decrementaTempo) userInfo:nil repeats:YES];
    
    
    
    
    [self.appDelegate.mcManager.session myPeerID ];
    self.minhaBatata = [[Batata alloc] init];
    
    [self.imgBatata setImage:self.minhaBatata.imagemBatata];
    
    swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(ativarAnimacaoEnviar)];
    
    swipe.direction = UISwipeGestureRecognizerDirectionRight;

    [self.imgBatata addGestureRecognizer:swipe];
    
    self.audioPlayer = [[Audio alloc] init];
    
    
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self.imgBatata setHidden:!self.batata];
    [self.imgBatata setUserInteractionEnabled:self.batata];
    if (self.batata) {
        [[self audioPlayer]playBatata];
    }
         fuiEliminado = NO;
}


-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self btnEnviar:nil];
    return YES;
}


-(void)ativarAnimacaoEnviar{
    
    [self.imgBatata setUserInteractionEnabled:NO];
    
    CABasicAnimation *animacao = [[self minhaBatata] animacaoEnviar:self.imgBatata.center];
    
    [[[self imgBatata] layer] addAnimation:animacao forKey:nil];
    
    [self btnEnviar:nil];
}

-(void)ativarAnimacaoReceber{
    
    
    [self.imgBatata setUserInteractionEnabled:YES];
    CGRect frame = self.imgBatata.frame;
    
    [self.imgBatata setFrame:CGRectMake(-518, frame.origin.y, frame.size.width, frame.size.height)];
    
    
    
    CABasicAnimation *animacao = [[self minhaBatata] animacaoEnviar:self.imgBatata.center];
    
    void (^blokAnimation)(void) = ^{
        [[[self imgBatata] layer] addAnimation:animacao forKey:nil];
        [self.imgBatata setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
 
    };
    
    blokAnimation();
    
    
}



-(NSString*)retornaPlayerRandom{
    int x;
    NSString *playerRandom ;
    BOOL saiuDoJogo;
    
    
    do {
        saiuDoJogo = YES;
        x = (arc4random() % [self.controladorDeJogadores retornaNumeroDeJogadores]);
        
        playerRandom = [self.controladorDeJogadores retornaNomeDeJogaddor:x];
        
        saiuDoJogo = [self.controladorDeJogadores saiuDoJogo:playerRandom];
        
        
    } while ([playerRandom isEqualToString:[self.controladorDeJogadores retornaNomeDeJogaddor: 0]] || saiuDoJogo);
    
    
    return playerRandom;
    
}

-(IBAction)btnEnviar:(id)sender{
    proximoEmbatatado = YES;
    NSString *playerRandom  = [self retornaPlayerRandom];
    
    
    
    eliminado = playerRandom;
    
    [self selecionaIndiceParaEliminar];
    
    [[self audioPlayer]stopSounds];
    
    
    NSArray *meuArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithDouble:self.current], playerRandom, nil];
    
    //NSLog(@"%@",eliminado);
    
    NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:meuArray];
    NSArray *allPeers = self.appDelegate.mcManager.session.connectedPeers;
    NSError *error;
    
    [self.appDelegate.mcManager.session sendData:dataToSend
                                     toPeers:allPeers
                                    withMode:MCSessionSendDataReliable
                                       error:&error];
    self.batata = NO;
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
}



-(void)selecionaIndiceParaEliminar{
    for (int i = 0; i<[self.controladorDeJogadores retornaNumeroDeJogadores]; i++) {
        if ([eliminado isEqualToString:[self.controladorDeJogadores retornaNomeDeJogaddor:i]] ) {
            indiceEliminado = i;
        }
    }
}

-(void)didReceiveDataWithNotification:(NSNotification *)notification{
    
  
    if ([[[notification userInfo]objectForKey:@"tipo"]isEqualToNumber:[NSNumber numberWithInt:1]]) {
        NSString *jogador = [[[notification userInfo]objectForKey:@"peerID"]displayName];
        [self.controladorDeJogadores estouPronto:jogador estaPronto:YES];
    }else{
        // Passa a batata
        [self passaBatata:notification];
    }

}



-(void)passaBatata:(NSNotification *)notification{
    if (fuiEliminado) {
        return;
    }
    proximoEmbatatado = NO;
    eliminado = [[notification userInfo]objectForKey:@"embatatado"];
    NSLog(@"%@",eliminado);
    
    
    [self selecionaIndiceParaEliminar];
    
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.current = [[[notification userInfo] objectForKey:@"tempo"] intValue];
        
        self.iniciaTempo = YES;
        
        if ([[[notification userInfo] objectForKey:@"embatatado"]isEqualToString: [self.controladorDeJogadores retornaNomeDeJogaddor: 0]]) {
            
            self.batata = YES;
            [self.imgBatata setHidden:!self.batata];
            [self ativarAnimacaoReceber];
            [[self audioPlayer]playQuente];
            
            
        }else{
            self.batata = NO;
            [self.imgBatata setHidden:!self.batata];
            
        }
        
        
    }];
    

}

-(void)decrementaTempo{
   
    
    if(!self.iniciaTempo){
        return;
    }else if(self.current <= 0){
        
        [[self audioPlayer]stopSounds];
        
        [self.controladorDeJogadores removeJogador: indiceEliminado];
        
        
        if (self.batata ) {
            [[self tempoDecorrido] setText:@"Perdeu!!"];
            [[self audioPlayer]playQueimou];
            fuiEliminado = YES;
            [self.btnRestart setEnabled:NO];
            
        }else{
            [[self tempoDecorrido] setText:@"Ganhou!"];
            
            if ([self.controladorDeJogadores retornaNumeroDeJogadores]==1) {
                [self.btnRestart setEnabled:NO];
            }
        }
        
        [self.imgBatata removeGestureRecognizer:swipe];
        [self.timer invalidate];
        
        
        return;
        
        
    }else if (self.current <= 1){
        [self.imgBatata removeGestureRecognizer:swipe];
        
    }
    
    self.current -=1;
    int x = self.current;
    [[self tempoDecorrido] setText:[NSString stringWithFormat: @"%d",x]];

    [self.view setNeedsDisplay];
}





- (IBAction)voltar:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)restart{
    if ([self.controladorDeJogadores retornaNumeroDeJogadores]==1) {
        return;
    }
    if (proximoEmbatatado) {
        self.batata = YES;
        [self.imgBatata setHidden:!self.batata];
        [self ativarAnimacaoReceber];
    }
    [self.imgBatata addGestureRecognizer:swipe];
    self.current = 20;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(decrementaTempo) userInfo:nil repeats:YES];
    
}


- (IBAction)actionRestart:(id)sender {
    [self restart];
}


@end
