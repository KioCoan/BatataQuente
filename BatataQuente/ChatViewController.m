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
    
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(decrementaTempo) userInfo:nil repeats:YES];
    
    
    
    //self.myPersonagem.image = self.myImage;
    
    [self.appDelegate.mcManager.session myPeerID ];
    self.minhaBatata = [[Batata alloc] init];
    
    [self.imgBatata setImage:self.minhaBatata.imagemBatata];
    
    swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(ativarAnimacaoEnviar)];
    
    swipe.direction = UISwipeGestureRecognizerDirectionRight;

    [self.imgBatata addGestureRecognizer:swipe];
    
    self.audioPlayer = [[Audio alloc] init];
    
    self.lblMeuNome.text = [self.controladorDeJogadores retornaNomeDeJogaddor:0];
    
    
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self adicionarMinhaImagem];
    
    myName = [self.controladorDeJogadores retornaNomeDeJogaddor:0];
    //[self enviaMinhaImagem];
    self.current = 20;
    [self.controladorDeJogadores adicionaNoJogador:myName aImagem:self.myImage];
    [self actionPronto:self];
    
    [self.imgBatata setHidden:!self.batata];
    [self.imgBatata setUserInteractionEnabled:self.batata];
    if (self.batata) {
        [[self audioPlayer]playBatata];
    }
    envieiImagemPraTodos  = NO;
    envieiMensagemToPronto = NO;
    
    
    if(self.deviceIsIpad){
        CGRect frame = self.view.frame;
        frame.size.height = 632;
        imagensTela = [[ImagensTelaPartida alloc] initWithFrame:frame isIpad:YES];
        
    }else{
        CGRect frame = self.view.frame;
        frame.size.height = 318;
        imagensTela = [[ImagensTelaPartida alloc] initWithFrame:frame isIpad:NO];
    }
    
    [[self view] addSubview:imagensTela];
   
    [self.view bringSubviewToFront:self.btnRestart];
    [self.view bringSubviewToFront:self.btnVoltar];
    //[self.view sendSubviewToBack:imagensTela];
    
}


-(void)adicionarMinhaImagem{
    if ([self.myImage rangeOfString:@".png"].location == NSNotFound) {
        CGRect frame = self.minhaImagem.frame;
        frame.size.height -= 2;
        FBProfilePictureView *foto = [[FBProfilePictureView alloc] initWithFrame:frame];
        [foto setProfileID:self.myImage];
        foto.layer.borderWidth = 1.0f;
        foto.layer.cornerRadius = CGRectGetWidth(foto.bounds) / 2.0f;
        
        [[self minhaImagem] setHidden:YES];
        
        [[self view] addSubview:foto];
        return;
    }
    
    [self.minhaImagem setImage:[UIImage imageNamed:self.myImage]];
    
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self btnEnviar:nil];
    return YES;
}

-(BOOL)deviceIsIpad{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        NSLog(@"iPad");
        return  YES;
    }else{
        return NO;
    }
}

-(void)ativarAnimacaoEnviar{
    
    if (todosProntos) {
     
    
    [self.imgBatata setUserInteractionEnabled:NO];

        
    CABasicAnimation *animacao = [[self minhaBatata] animacaoEnviarWithPosition:self.imgBatata.center andDevice:[self deviceIsIpad]];
    
    [[[self imgBatata] layer] addAnimation:animacao forKey:nil];
    
    [self btnEnviar:nil];
    }
}

-(void)ativarAnimacaoReceber{
    
    
    [self.imgBatata setUserInteractionEnabled:YES];
    CGRect frame = self.imgBatata.frame;
    
    [self.imgBatata setFrame:CGRectMake(-518, frame.origin.y, frame.size.width, frame.size.height)];
    
    
    
    CABasicAnimation *animacao = [[self minhaBatata] animacaoEnviarWithPosition:self.imgBatata.center andDevice:[self deviceIsIpad]];
    
    
    
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
        NSLog(@"%@",playerRandom);
        
    } while ([playerRandom isEqualToString:myName] || saiuDoJogo);
    
    
    return playerRandom;
    
}

-(IBAction)btnEnviar:(id)sender{
    
    if (todosProntos) {
        
        self.lblMensagens.text = @"";
        proximoEmbatatado = YES;
        NSLog(@"Proximo embatatado %hhd",proximoEmbatatado);
        NSString *playerRandom  = [self retornaPlayerRandom];
        
        
        
        self.eliminado = playerRandom;
        
        [self selecionaIndiceParaEliminar];
        
        [[self audioPlayer]stopSounds];
        
        
        NSArray *meuArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:5],[NSNumber numberWithDouble:self.current],@"imagem",playerRandom, nil];
        
        
        
        NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:meuArray];
        NSArray *allPeers = self.appDelegate.mcManager.session.connectedPeers;
        NSError *error;
        
        [self.appDelegate.mcManager.session sendData:dataToSend
                                             toPeers:allPeers
                                            withMode:MCSessionSendDataReliable
                                               error:&error];
        self.batata = NO;
        
        if (error) {
           // NSLog(@"%@", [error localizedDescription]);
        }
        
    }
    
    
}



-(void)selecionaIndiceParaEliminar{
    for (int i = 0; i<[self.controladorDeJogadores retornaNumeroDeJogadores]; i++) {
        if ([self.eliminado isEqualToString:[self.controladorDeJogadores retornaNomeDeJogaddor:i]] ) {
            indiceEliminado = i;
        }
    }
}

-(void)didReceiveDataWithNotification:(NSNotification *)notification{
    
  NSString *jogador = [[[notification userInfo]objectForKey:@"peerID"]displayName];
    int tipo = [[[notification userInfo]objectForKey:@"tipo"]integerValue];
    
    //[[NSOperationQueue mainQueue] addOperationWithBlock:^{
    switch (tipo) {
        case 1: //Méodo que gerencia as chamadas de pronto
            
            //NSLog(@"Passou %d",tipo);
            [self adicionaJogadorPronto:jogador];
            
            
            //Quando todos estiverem prontos envio minha imagem (Somente uma vez)
           // NSLog(@"PAssou 1 %hhd , %hhd", todosProntos, envieiMensagemToPronto);
            if (todosProntos && !envieiImagemPraTodos) {
                [self enviaMinhaImagem];
                envieiImagemPraTodos = YES;
                //NSLog(@"Enviei");
            }
            
            
            break;
        case 2: // altera pra jogador nao pronto
            //NSLog(@"Passou %d",tipo);
            [self.controladorDeJogadores jogadorComNome:jogador estaPronto:NO];
            [self adicionaImagensNaTela:jogador imagem:[[notification userInfo] objectForKey:@"imagem"] perdeu:YES];
            
            //verifica se é o fim do jogo
            if ([self.tempoDecorrido.text isEqual:@"Ganhou!"]) {
                if ([self fimJogo]) {
                    [self enviaMensagemVencedor];
                    //self.btnRestart.enabled = YES;
                    [self.btnRestart setTitle:@"Restart" forState:UIControlStateNormal];
                }

            }
            break;
            
        case 3://seta imagem de jogador
          
            //NSLog(@"Passou %d",tipo);
            [self.controladorDeJogadores adicionaNoJogador:jogador aImagem:[[notification userInfo]objectForKey:@"imagem"]];
            //[self adicionaImagensNaTela:jogador imagem:[[notification userInfo]objectForKey:@"imagem"]];
            [self adicionaImagensNaTela:jogador imagem:[[notification userInfo] objectForKey:@"imagem"] perdeu:NO];
           
               break;
            
        case 4: //Vencedor
            
            //NSLog(@"Passou %d", tipo);
            
            
            self.btnRestart.enabled = YES;
            [self.btnRestart setTitle:@"Restart" forState:UIControlStateNormal];
            
            
            break;
            
        default: //Mensagem normal de passagem de batatas
            NSLog(@"Passou %d",tipo);
            [self passaBatata:notification];
            break;
    }
   // }];

}
-(void)adicionaJogadorPronto:(NSString*)jogador{
    //VERIFICA SE FALTA ALGUM JOGADOR CLICAR EM INICIAR
   
    [self.controladorDeJogadores jogadorComNome:jogador estaPronto:YES];
    todosProntos = [self.controladorDeJogadores todosProntos];

    if(todosProntos && !envieiMensagemToPronto){
        //REENVIA O STATUS DE PRONTO PARA TODOS, ASSIM, TODOS FICAM ATUALIZADOS MESMO QUEM ENTRAR POR ÚLTIMO
        [self enviaMensagemDoMeuStatusDe:YES];
        envieiMensagemToPronto = YES;
    }
    
    
    
    //SE TODOS ESTIVEREM PRONTOS, É CHAMADO UM MÉTODO QUE MOSTRA UMA MENSAGEM PARA QUEM ESTIVER COM A BATATA INICIAL, E PARA QUEM NÃO ESTIVER, APENAS LIMPA A TELA
    if(todosProntos){
        [self mostrarDicaInicial];
    }
}

-(void)mostrarDicaInicial{
    
    //[[NSOperationQueue mainQueue] addOperationWithBlock:^{
    //dispatch_async(dispatch_get_main_queue(), ^{
        if(self.batata){
            
            self.lblMensagens.text = @"Arraste sobre a batata para iniciar.";
            
        }else{
            self.lblMensagens.text = @"";
        }
    //});
    
}


-(void)passaBatata:(NSNotification *)notification{
//    if ([self.controladorDeJogadores jogadorEstaPronto:myName]) {
//        return;
//    }
    proximoEmbatatado = NO;
    NSLog(@"proximo embatatado: %hhd",proximoEmbatatado);
    self.eliminado = [[notification userInfo]objectForKey:@"embatatado"];
    
    
    
    [self selecionaIndiceParaEliminar];
    
    
    //[[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.current = [[[notification userInfo] objectForKey:@"tempo"] intValue];
        
        self.iniciaTempo = YES;
        
        if ([[[notification userInfo] objectForKey:@"embatatado"]isEqualToString: myName]) {
            
            self.batata = YES;
            [self.imgBatata setHidden:!self.batata];
            [self ativarAnimacaoReceber];
            [[self audioPlayer]playQuente];
            
            
        }else{
            self.batata = NO;
            [self.imgBatata setHidden:!self.batata];
            
        }
        
        
   // }];
    

}

- (BOOL)fimJogo{
    
    if ([self.controladorDeJogadores retornaNumeroDeJogadoresProntos] <= 1) {
        return YES;
    }
    
    return NO;
}

-(void)decrementaTempo{
   
    
    if(!self.iniciaTempo){
        return;
    }else if(self.current <= 0){
        
        
        [self.btnRestart setEnabled:YES];
        [[self audioPlayer]stopSounds];
        
//        [self.controladorDeJogadores removeJogador: indiceEliminado];
        
        
        if (self.batata ) {
            [self.meuIcone setImage:[UIImage imageNamed:@"imagemEliminado.png"]];
            [[self tempoDecorrido] setText:@"Perdeu!!"];
            [[self audioPlayer]playQueimou];
            //[self enviaMensagemPerdi:YES];
//            fuiEliminado = YES;
            [self.btnRestart setEnabled:NO];
            [self.controladorDeJogadores jogadorComNome:myName estaPronto:NO];
            [self enviaMensagemDoMeuStatusDe:NO];
            
        }else{
            
            [[self tempoDecorrido] setText:@"Ganhou!"];
            
            
            
           /* if ([self.controladorDeJogadores retornaNumeroDeJogadores]==1) {
                [self.btnRestart setEnabled:YES];
                
            }*/
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


-(void)continuar{
    //NSLog(@"numero jogadores %d",[self.controladorDeJogadores retornaNumeroDeJogadores]);
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
    
    if ([self.btnRestart.titleLabel.text isEqual:@"Restart"]) {
        [self.btnRestart setTitle:@"Continue" forState:UIControlStateNormal];
    }else{
        [self continuar];
    }
    
    
    [self.btnRestart setEnabled:NO];
}


- (IBAction)actionPronto:(id)sender {

    [self.controladorDeJogadores jogadorComNome:myName estaPronto:YES];

    
    [self enviaMensagemDoMeuStatusDe:YES];
    
    
    [self.btnRestart setEnabled:NO];
    if ([self.controladorDeJogadores todosProntos]) {
        todosProntos = [self.controladorDeJogadores todosProntos];
        [self mostrarDicaInicial];
    }
    
    [self enviaMinhaImagem];
    
    NSLog(@"OK!");
}


-(void)enviaMensagemDoMeuStatusDe:(BOOL)pronto{
    NSArray *meuArray;
    if (pronto) {
         meuArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithDouble:self.current], @"imagem", myName, nil];
    }else{
         meuArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithDouble:self.current], @"imagem", myName, nil];
    }
    NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:meuArray];
    NSArray *allPeers = self.appDelegate.mcManager.session.connectedPeers;
    NSError *error;
    
    [self.appDelegate.mcManager.session sendData:dataToSend
                                         toPeers:allPeers
                                        withMode:MCSessionSendDataReliable
                                           error:&error];

    
}

-(void)enviaMensagemVencedor{
    NSArray *meuArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:4],[NSNumber numberWithDouble:self.current], @"imagem", myName, nil];
    
    NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:meuArray];
    NSArray *allPeers = self.appDelegate.mcManager.session.connectedPeers;
    NSError *error;
    
    [self.appDelegate.mcManager.session sendData:dataToSend
                                         toPeers:allPeers
                                        withMode:MCSessionSendDataReliable
                                           error:&error];
}

-(void)respondoMensagemDePronto:(NSNotification *)notification{
    NSArray *meuArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:3],[NSNumber numberWithDouble:self.current], self.myImage,myName, nil];
    
    NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:meuArray];
    //NSArray *allPeers = self.appDelegate.mcManager.session.connectedPeers;
    NSArray *peer = [[notification userInfo]objectForKey:@"peerID"];
    NSError *error;
    
    [self.appDelegate.mcManager.session sendData:dataToSend
                                         toPeers:peer
                                        withMode:MCSessionSendDataReliable
                                           error:&error];
    
    
}

-(void)enviaMinhaImagem{
    //dispatch_async(dispatch_get_main_queue(), ^{
    
    NSArray *meuArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:3],[NSNumber numberWithDouble:self.current], self.myImage ,myName, nil];
    
    
    
    NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:meuArray];
    NSArray *allPeers = self.appDelegate.mcManager.session.connectedPeers;
    NSError *error;
    
    [self.appDelegate.mcManager.session sendData:dataToSend
                                         toPeers:allPeers
                                        withMode:MCSessionSendDataReliable
                                           error:&error];
    //});
}



-(void)adicionaImagensNaTela:(NSString*)nome imagem:(NSString*)imagem perdeu:(BOOL)perdeu{
    //[[NSOperationQueue mainQueue] addOperationWithBlock:^{
    //dispatch_async(dispatch_get_main_queue(), ^{
    int index = [self.controladorDeJogadores retornaIndiceJogador:nome];
        
    if (!perdeu) {
        [imagensTela setImagemFoto:index-1 imagem:imagem];
    }else{
        [imagensTela alteraIcone:index-1 status:NO];
    }
    
    
    
    //});
    
}





@end
