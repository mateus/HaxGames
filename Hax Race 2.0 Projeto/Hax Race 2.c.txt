/*
  Nome do Projeto: Hax Race 2.0
  Instituição: IFET Barbacena
  Programadores: Mateus Ferreira Silva
                 Arthur Nascimento Assuncao
  Data: 08/2011 - 09/2011
  Descrição: Constinuação do jogo Hax Race 1.0 feito em pascal durante o 
             primeiro período do curso Sistemas para Internet IFET Barbacena. 
             Feito em C + Allegro.

                        Cheat 
  Vida maxima - Durante o pause digite 5 vezes a tecla 'V'
*/

#include <allegro.h>
#include <time.h>
#include <alpng.h>
#include <algif.h> // habilita gif 
#include <jpgalleg.h> //biblioteca jpg
#include "pmask/pmask.h"
#include "pmask/collist.h"
#include <malloc.h> //alocacao dinamina
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h> //para caracteres, sera usada por causa do toupper
#include "fmod.h"
#include "al_screen/al_screen.h" //atualizar a tela melhor

#define res_x     800
#define res_y     600
#define res_z     32
#define move_speed  1
#define MAXIMORANKING 10 //maximo de dados em cada ranking
#define MAXFPS 75 //maximo de frames por segundo
#define RESTFPS 5
#define RESTFPSJOGO 2
#define CINZA makecol(100,100,100)

//Tipos
typedef struct
    {
      int x; //padrao 260
      int y; //padrao 440
      int vida; //numero de vidas
      int energia; //qntidade de energia, tera 3, se tomar 3 tiros perde uma vida
      BITMAP *imagem;
      PMASK mask;
      BITMAP *imagemEsq; //imagem da nave qndo pressione seta para esquerda
      PMASK maskEsq;
      BITMAP *imagemDir; //imagem da nave qndo pressione seta para direita
      PMASK maskDir;
    }naves;
#define MAXTIROS 5
typedef struct
    {
      int x;
      int y;
    }tiros;
#define MAXSUPER 5
typedef struct
    {
      int x;
      int y;
    }supers;
#define MAXTIROSINIMIGOS 3
typedef struct
{
        int tiroCont;
        int tiroAtivado;
        int tempoTiro; //tempo ate dar outro tiro, contara pelas iteracoes
        int x[MAXTIROSINIMIGOS];
        int y[MAXTIROSINIMIGOS];
  }tiroInimigo;
typedef struct
{
     int x;
     int y;
     int vida;
     int cont;
     int cacaNaTela;
     int desviando;
     int naopersegue;
     tiroInimigo tiro;
   }inimigos; 
typedef struct
    {
      int x;
      int y;
      int ativado;
    }balas; 
typedef struct DadosRanking
{
        int nivel;
        int pontos;
        char nome[3];
}ranking;    
    
//Criando a enumeracao:
enum boolean {
    false, // = 0
    true // = 0+1 = 1
};
//Permitindo o uso do tipo bool, fiz isso por causa da biblioteca al_screen q foi escrita em c++ e pode dar problema
typedef enum boolean bool;
    
// fechar jogo
volatile int FecharJogo = FALSE;
//variaveis Countador de FPS
volatile int contFrames = 0, contTempo = 0; // Conta a quantidade de frames em cada segundo
//volatile int fps = 0; // Armazena a taxa atual de Fps
short int fpsC=0,fpsT=0,fps=0;
unsigned int exibirFPS=0;
unsigned int vSync=0;

//Contador Frames Por Segundo
void funcFPS(void) 
{ 
	contFrames++; 
} 
END_OF_FUNCTION(funcFPS); 
//Fim Contador FPS
//Contador de tempo
void funcTempo(void) 
{ 
/*fps = contFrames; 
contFrames = 0;*/
	fpsT++;
	contTempo++;
} 
END_OF_FUNCTION(funcTempo); 

//Volume do jogo
int volume=255; 
int contClassico = 1;
int contBatalha = 1;

void init();
void deinit();
void highcolor_fade_in(BITMAP *bmp_orig, int speed,int x,int y); // Fade In
void highcolor_fade_out(int speed,int x,int y); // Fade Out 
void intro(); // Introdução
void jogar(int nivel, int corCarro); // parametros NIVEL nivel selecionado, corCarro cor do carro desejado
void instrucoes();
void info();
int fsair();
void niveis();
void pausarJogo(int *vidas);
void pausarJogoBatalha(int *vidas, int *energia, int *superCont);
int escolhercor();
void bateu();
void fimdoclassico(int pontos,int nivel, int corCarro);
void volumeop();
void BotaoFechar(void);
void jogarBatalha(int nivel);
void atiraBatalha(BITMAP *buffer, BITMAP *tiro, tiros tiros1[], int *tiroCont, int *tiroAtivado);
void superBatalha(BITMAP *buffer, BITMAP *missel, supers super[], int *superCont, int *superAtivado);
void municaoBatalha(BITMAP *buffer, int *naoAtira, int *naoAtiraCont, int *tiroCont);
void fimDoBatalha(int pontos,int nivel);

void mostraRanking();
void ordenaArquivo(int codArquivo);

void niveisBatalha();

//outras funcoes 
int abs(int x);

int main() {
        
	init();
	
	// Faz o lock das variaveis usadas pela funcao de timer e da propria funcao 
    LOCK_VARIABLE(fps); 
    LOCK_VARIABLE(cont); 
    LOCK_FUNCTION(func_fps); 
	
    int opx=322, opy=500;
    int sair=0;
    
    FONT *font1 = load_font("fonts/niagra24i.pcx", NULL, NULL);
    FONT *font2 = load_font("fonts/arrows.pcx", NULL, NULL);
    FONT *font3 = load_font("fonts/impact.pcx", NULL, NULL);
    
    BITMAP *fundo = load_jpg("img/fundocaça.jpg", NULL);
	//BITMAP *buffer = create_bitmap(800, 600);
	BITMAP *buffer = create_bitmap(SCREEN_W, SCREEN_H);
	BITMAP *hr = load_bitmap("img/hr.bmp", NULL);
	//rectfill(buffer,0,0,800,600,makecol(0,0,0));
	
	//loading
	BITMAP *loading[4];
	loading[0] = load_jpg("img/carregando/carregando00.jpg", NULL);
	loading[1] = load_jpg("img/carregando/carregando01.jpg", NULL);
	loading[2] = load_jpg("img/carregando/carregando02.jpg", NULL);
	loading[3] = load_jpg("img/carregando/carregando03.jpg", NULL);
	int loadingCont=0;
	
	//Intro
	SAMPLE *som;
    som=load_wav("wav/Race Car Fast By.wav");
    play_sample(som,volume,90,1000,0);    
	intro();
	if (key[KEY_ESC] || key[KEY_ENTER]) //se o cara saiu da intro com enter ou esc ele vai parar o som
       stop_sample(som);
    stop_sample(som);
    
    // Tela de volume 
    volumeop();   

	SAMPLE *click = load_wav("wav/select.wav");
	SAMPLE *tema = load_wav("wav/MK.wav");
	SAMPLE *acel = load_wav("wav/acel.wav");
	SAMPLE *jatopassando = load_wav("wav/jatopassando.wav");
	SAMPLE *entrou = load_wav("wav/entrou.wav");
	SAMPLE *exit = load_wav("wav/sair.wav");
	
    int count = 1;
	
	if (!key[KEY_ESC] && !key[KEY_ENTER]) //se o cara nao saiu da intro com enter ou esc ele vai parar o som
       stop_sample(som);
	
	while (!sair && !FecharJogo) //para melhorar o double buffer eu coloquei para jogar as imagens no buffer e so no final jogar o buffer na screen
	{
	rest(RESTFPS); //diminui o uso de CPU
	while (!key[KEY_ESC] && !FecharJogo && contFrames>0 && !sair)
	{
	    acquire_bitmap(buffer);
		clear(buffer);
        if (count == 1)
           play_sample(tema,volume,90,1000,1);
        count++;
        
        if (vSync)
        vsync();
        draw_sprite(buffer,fundo,0,0);
		draw_sprite(buffer,hr,opy,opx);
    
    if(keypressed())
    {
        if(key[KEY_R]) //se apertar R no menu ele mostra o ranking
        {
           mostraRanking();               
        }
                 
		if(key[KEY_UP])
        {
           if(opx > 322)
           {
              play_sample(click,volume,90,1000,0);         
              opx -= 39;
              //opy -= 20; 
              rest(100); 
              stop_sample(click);                       
           }           
           else
           {
              play_sample(click,volume,90,1000,0);         
              opx = 478;
              rest(100); 
              stop_sample(click);                       
           }  
     
        }
        if(key[KEY_DOWN])
        {
           if(opx<478)   
           {  
              play_sample(click,volume,90,1000,0); 
              opx += 39;
              //opy += 20;
              rest(100);
              stop_sample(click);
                            
           }
           else
           {
              play_sample(click,volume,90,1000,0);         
              opx = 322;
              rest(100); 
              stop_sample(click);                       
           }
        }
           
          if(key[KEY_ENTER])
          {
             if(opx == 322)
             {
                 // Executa o codigo de Jogar 
                 count = 1;
                 play_sample(acel,volume,90,1000,0);
                 
                 //Loading imagens
                 for (loadingCont=0;loadingCont<4;loadingCont++)
                 {
                    draw_sprite(screen,loading[loadingCont],630,575);
                    rest(750); //como vai rodar 4 vezes entao vao ser 3 segundos(3000)
                 }
                 
                 //rest(3000);
                 stop_sample(acel);
                 stop_sample(tema);
                 //fimdoclassico(500,2,1);                 
                 niveis();
                  // para voltar a musica ao voltar no menu
                        
             }             
             // Criei
             if(opx == 361)
             {
                 // Executa o codigo de Jogar Batalha
                 count = 1;
                 play_sample(jatopassando,volume,90,1000,0); 
                 
                 //Carregando imagens
                 for (loadingCont=0;loadingCont<4;loadingCont++)
                 {
                    draw_sprite(screen,loading[loadingCont],630,575);
                    rest(750); //como vai rodar 4 vezes entao vao ser 3 segundos(3000)
                 }
                 
                 //rest(3000);
                 stop_sample(jatopassando);
                 stop_sample(tema);
                 niveisBatalha();
                 //jogarBatalha();
                  // para voltar a musica ao voltar no menu

                      
             }
             //ate aki
             else if(opx == 400)
             {
                // Executa o codigo de Instruções
                play_sample(entrou,volume,90,1000,0); 
                rest(100);
                stop_sample(entrou);
                instrucoes();

             }
             else if(opx == 439)
             {
                // Executa o codigo de Informacoes
                play_sample(entrou,volume,90,1000,0); 
                rest(100);
                stop_sample(entrou);
                info();
         
             }
             else if(opx == 478)
             {
                // Executa o codigo de sair
                stop_sample(tema);
                play_sample(exit,volume,90,1000,0); 
                rest(1500);
                stop_sample(exit);
                fsair();
                sair = fsair();
             }
          }
          
          //SOM Volume
          if ((key[KEY_MINUS_PAD] || key[KEY_MINUS]) && volume>0) // menos do teclado numerico e do teclado normal diminuem o volume
          {
             volume--;
             rest(10);
          }
          if ((key[KEY_PLUS_PAD] || key[KEY_EQUALS]) && volume<255) //mais do teclado numerico e igual do teclado normal aumentam o volume
          {
             volume++;
             rest(10);
          }                
    }                  
   	   if (!sair)	
       {		
			//pega o buffer
			//if (exibirFPS)
			//textprintf_ex(screen, font, 10, SCREEN_H - 20, makecol(230, 230, 230), -1, "FPS: %d - Tricks/s: %d", fps, fpsT);
			if (get_update_method())
			{
				buffer = get_buffer();
			}
			else
			{
				buffer = screen;
				if (vsync_is_enabled())
				{
					vsync();
				}
			}

			release_bitmap(buffer);

			//Atualiza a tela
			//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
			if (get_update_method())
			{
				update_screen();
			}
			else
			{
				// já está na tela
			}
			//Conta os frames
			contFrames--;
			if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
            fpsC++;
      }
            
            clear_keybuf(); 
		}
	}
	
	/*if (get_update_method())
    {
        shutdown_screen_updating();
    }*/
	
    //stop_sample(tema);
	//stop_sample(som);
    destroy_font(font1);
    destroy_font(font2);
    destroy_font(font3);
    destroy_bitmap(fundo);
    destroy_bitmap(hr);
	destroy_bitmap(buffer);
    deinit();
	return 0;
}
END_OF_MAIN()

void BotaoFechar(void) 
{ 
   FecharJogo = TRUE; 
} 
END_OF_FUNCTION(BotaoFechar)

//---------------------------------------------------------------------
void init() {
	int depth, res;
	allegro_init();
	install_pmask();
	set_uformat(U_ASCII); // Habilita acentuação em ALGUMAS FONTES
	
	install_timer();
	install_keyboard();
	clear_keybuf();
	install_mouse();
	
	// roda configuracao de um arquivo
	set_config_file("config.txt");
	
	set_color_depth(get_config_int("Inicializacao", "colordepth",16));
	exibirFPS=get_config_int("Inicializacao", "exibirFps",0);
	vSync=get_config_int("Inicializacao", "vsync",0);
	
	volume=get_config_int("Inicializacao", "volume", 128); //usa as config de volume do arquivo
	
	/*depth = desktop_color_depth();
	if (depth == 0) depth = 32;
	   set_color_depth(depth);*/
	
    #define GFX_BWINDOWSCREEN_ACCEL AL_ID('B','W','S','A')
	#define GFX_BWINDOWSCREEN        AL_ID('B','W','S',' ')
    AL_VAR(GFX_DRIVER, gfx_beos_bwindowscreen_accel);
    AL_VAR(GFX_DRIVER, gfx_beos_bwindowscreen);

    //Fullscreen
    //res = set_gfx_mode(GFX_AUTODETECT_FULLSCREEN & GFX_BWINDOWSCREEN_ACCEL, 800, 600, 0, 0);
    //Janela
	res = set_gfx_mode(GFX_AUTODETECT_WINDOWED, 800, 600, 0, 0); 
	if (res != 0) {
		allegro_message(allegro_error);
		exit(-1);
	}
	
	//initialize the screen update method
	initialize_screen_updating(get_config_int("Inicializacao", "updatemethod", UPDATE_TRIPLE_BUFFER));
	
	if(install_sound(DIGI_AUTODETECT, MIDI_AUTODETECT, NULL))
    {
        allegro_message("Sound Error: %s", allegro_error);
    }
    
    set_window_title("Hax Race 2.0"); //nome da Janela
    
    set_display_switch_mode(SWITCH_BACKGROUND); //roda o allegro em segundo plano
    
    //Botao fechar
    LOCK_FUNCTION(BotaoFechar); 
    set_close_button_callback(BotaoFechar);
    
    //Contador de frames
	// Faz o lock das variaveis usadas pela funcao de timer e da propria funcao 
    LOCK_VARIABLE(fps); 
    LOCK_VARIABLE(contFrames); 
    LOCK_FUNCTION(funcFPS);
	//chama a funcao funcFPS
	install_int_ex(funcFPS,BPS_TO_TIMER(MAXFPS)); //Frames por segundo, 60FPS
	//chama a funcao funcTempo
	LOCK_VARIABLE(contTempo); 
    LOCK_FUNCTION(funcTempo);
	install_int(funcTempo, 1000); //Timer "ticks" a cada mil milisegundos, ou seja, 1 segundo
	 
	/* add other initializations here */
}
//---------------------------------------------------------------------
void deinit() {
	clear_keybuf();
	set_config_int("Inicializacao", "volume", volume); //salva o volume q o usuario escolheu
	//fechando o allegro
	allegro_exit();
	/* add other deinitializations here */
}
//---------------------------------------------------------------------
void mostraRanking()
{     
     int i, x=50, y=0;
     long int tamanhoFacil=0, tamanhoDificil=0, tamanhoMedio=0;
     int criouFacil=0, criouMedio=0, criouDificil=0;
     long int tamanhoFacilBatalha=0, tamanhoDificilBatalha=0, tamanhoMedioBatalha=0;
     int criouFacilBatalha=0, criouMedioBatalha=0, criouDificilBatalha=0;
     ranking mostrar;
     FILE *recordFacil, *recordMedio, *recordDificil;
     FILE *recordFacilBatalha, *recordMedioBatalha, *recordDificilBatalha;
     
     FONT *font1 = load_font("fonts/impact22.pcx", NULL, NULL);
     
     PALLETE pl;
     BITMAP *fundo = load_jpg("img/ranking.jpg", pl);
     BITMAP *buffer = create_bitmap(800, 600);
     rectfill(buffer, 0, 0, 800, 600, makecol(0, 0, 0)); //fundo preto
     draw_sprite(buffer,fundo,0,0);
     
     //ordena os arquivos
     ordenaArquivo(11);
     ordenaArquivo(12);
     ordenaArquivo(13);
     
     ordenaArquivo(21);
     ordenaArquivo(22);
     ordenaArquivo(23);
     
     //classico
     recordFacil = fopen("Ranking/RecordsFacil.bin","rb");
     if(!recordFacil)
     {
       recordFacil = fopen("Ranking/RecordsFacil.bin","w+b");
       criouFacil=1;
     }
     recordMedio = fopen("Ranking/RecordsMedio.bin","rb");
     if(!recordMedio)
     {
       recordMedio = fopen("Ranking/RecordsMedio.bin","w+b"); 
       criouMedio=1;
     }
     recordDificil = fopen("Ranking/RecordsDificil.bin","rb");
     if(!recordDificil)
     {
       recordDificil = fopen("Ranking/RecordsDificil.bin","w+b");
       criouDificil=1;
     }
     
     //Batalha
     recordFacilBatalha = fopen("Ranking/RecordsFacilBatalha.bin","rb");
     if(!recordFacilBatalha)
     {
       recordFacilBatalha = fopen("Ranking/RecordsFacilBatalha.bin","w+b");
       criouFacilBatalha=1;
     }
     recordMedioBatalha = fopen("Ranking/RecordsMedioBatalha.bin","rb");
     if(!recordMedioBatalha)
     {
       recordMedioBatalha = fopen("Ranking/RecordsMedioBatalha.bin","w+b"); 
       criouMedioBatalha=1;
     }
     recordDificilBatalha = fopen("Ranking/RecordsDificilBatalha.bin","rb");
     if(!recordDificilBatalha)
     {
       recordDificilBatalha = fopen("Ranking/RecordsDificilBatalha.bin","w+b");
       criouDificilBatalha=1;
     }
     
     //Classico
     if (!criouFacil)
     {
         fseek(recordFacil, 0, SEEK_END); //posiciona no fim do arquivo
         tamanhoFacil=ftell(recordFacil)/sizeof(ranking); //tamanho do arquivo
         fseek(recordFacil, 0, SEEK_SET); //posiciona no inicio do arquivo
         if (tamanhoFacil>MAXIMORANKING)
            tamanhoFacil=MAXIMORANKING;
     }
     if (!criouMedio)
     {
         fseek(recordMedio, 0, SEEK_END); //posiciona no fim do arquivo
         tamanhoMedio=ftell(recordMedio)/sizeof(ranking); //tamanho do arquivo
         fseek(recordMedio, 0, SEEK_SET); //posiciona no inicio do arquivo
         if (tamanhoMedio>MAXIMORANKING)
            tamanhoMedio=MAXIMORANKING;
     }
     if (!criouDificil)
     {
         fseek(recordDificil, 0, SEEK_END); //posiciona no fim do arquivo
         tamanhoDificil=ftell(recordDificil)/sizeof(ranking); //tamanho do arquivo
         fseek(recordDificil, 0, SEEK_SET); //posiciona no inicio do arquivo
         if (tamanhoDificil>MAXIMORANKING)
            tamanhoDificil=MAXIMORANKING;
     }
     
     //Batalha
     if (!criouFacilBatalha)
     {
         fseek(recordFacilBatalha, 0, SEEK_END); //posiciona no fim do arquivo
         tamanhoFacilBatalha=ftell(recordFacilBatalha)/sizeof(ranking); //tamanho do arquivo
         fseek(recordFacilBatalha, 0, SEEK_SET); //posiciona no inicio do arquivo
         if (tamanhoFacilBatalha>MAXIMORANKING)
            tamanhoFacilBatalha=MAXIMORANKING;
     }
     if (!criouMedioBatalha)
     {
         fseek(recordMedioBatalha, 0, SEEK_END); //posiciona no fim do arquivo
         tamanhoMedioBatalha=ftell(recordMedioBatalha)/sizeof(ranking); //tamanho do arquivo
         fseek(recordMedioBatalha, 0, SEEK_SET); //posiciona no inicio do arquivo
         if (tamanhoMedioBatalha>MAXIMORANKING)
            tamanhoMedioBatalha=MAXIMORANKING;
     }
     if (!criouDificilBatalha)
     {
         fseek(recordDificilBatalha, 0, SEEK_END); //posiciona no fim do arquivo
         tamanhoDificilBatalha=ftell(recordDificilBatalha)/sizeof(ranking); //tamanho do arquivo
         fseek(recordDificilBatalha, 0, SEEK_SET); //posiciona no inicio do arquivo
         if (tamanhoDificilBatalha>MAXIMORANKING)
            tamanhoDificilBatalha=MAXIMORANKING;
     }
     
     //textprintf_ex(buffer, font1, 350, 5, makecol(255,255,0), -1, "%s","Ranking");
     
     #define DISTANCIATITULO 40
     #define INICIOFACIL 60
     #define RED 255
     #define GREEN 255
     #define BLUE 255
     #define XCLASSICO 130
     #define XBATALHA 555
     #define YINICIAL 20
     
     x=XCLASSICO;
     y=YINICIAL;
     
     //Jogo Classico
     //textprintf_ex(buffer, font1, 85, 15+YINICIAL, makecol(RED,GREEN,BLUE), -1, "%s","Classico");
     //textprintf_ex(buffer, font1, 100, INICIOFACIL+YINICIAL, makecol(RED,GREEN,BLUE), -1, "%s","Facil");
     textprintf_ex(buffer, font, x, INICIOFACIL+DISTANCIATITULO+YINICIAL, makecol(255,255,0), -1, "%s","Nome"); 
     textprintf_ex(buffer, font, x+50, INICIOFACIL+DISTANCIATITULO+YINICIAL, makecol(255,255,0), -1, "%s","Pontos"); 
     y+=10;
     for (i=0;i<tamanhoFacil;i++)
     {
         fread(&mostrar,sizeof(ranking),1,recordFacil);
         textprintf_ex(buffer, font, x-20, INICIOFACIL+DISTANCIATITULO+y, makecol(255,255,0), -1, "%d.",i+1);
         textprintf_ex(buffer, font, x, INICIOFACIL+DISTANCIATITULO+y, makecol(RED,GREEN,BLUE), -1, "%c",mostrar.nome[0]); x+=10;
         textprintf_ex(buffer, font, x, INICIOFACIL+DISTANCIATITULO+y, makecol(RED,GREEN,BLUE), -1, "%c",mostrar.nome[1]); x+=10;
         textprintf_ex(buffer, font, x, INICIOFACIL+DISTANCIATITULO+y, makecol(RED,GREEN,BLUE), -1, "%c",mostrar.nome[2]); x+=30;
         textprintf_ex(buffer, font, x, INICIOFACIL+DISTANCIATITULO+y, makecol(RED,GREEN,BLUE), -1, "%d",mostrar.pontos); y+=10;
         x=XCLASSICO;
     }
     y=YINICIAL;
     x=XCLASSICO;
     #define INICIOMEDIO 240
     //textprintf_ex(buffer, font1, 100, INICIOMEDIO, makecol(RED,GREEN,BLUE), -1, "%s","Medio");
     textprintf_ex(buffer, font, x, INICIOMEDIO+DISTANCIATITULO, makecol(255,255,0), -1, "%s","Nome"); 
     textprintf_ex(buffer, font, x+50, INICIOMEDIO+DISTANCIATITULO, makecol(255,255,0), -1, "%s","Pontos"); 
     y+=10;
     for (i=0;i<tamanhoMedio;i++)
     {
         fread(&mostrar,sizeof(ranking),1,recordMedio);
         textprintf_ex(buffer, font, x-20, INICIOMEDIO+DISTANCIATITULO+y-20, makecol(255,255,0), -1, "%d.",i+1);
         textprintf_ex(buffer, font, x, INICIOMEDIO+DISTANCIATITULO+y-20, makecol(RED,GREEN,BLUE), -1, "%c",mostrar.nome[0]); x+=10;
         textprintf_ex(buffer, font, x, INICIOMEDIO+DISTANCIATITULO+y-20, makecol(RED,GREEN,BLUE), -1, "%c",mostrar.nome[1]); x+=10;
         textprintf_ex(buffer, font, x, INICIOMEDIO+DISTANCIATITULO+y-20, makecol(RED,GREEN,BLUE), -1, "%c",mostrar.nome[2]); x+=30;
         textprintf_ex(buffer, font, x, INICIOMEDIO+DISTANCIATITULO+y-20, makecol(RED,GREEN,BLUE), -1, "%d",mostrar.pontos); y+=10;

         x=XCLASSICO;
     }
     y=YINICIAL;
     x=XCLASSICO;
     #define INICIODIFICIL 405
     //textprintf_ex(buffer, font1, 100, INICIODIFICIL, makecol(RED,GREEN,BLUE), -1, "%s","Dificil");
     textprintf_ex(buffer, font, x, INICIODIFICIL+DISTANCIATITULO, makecol(255,255,0), -1, "%s","Nome"); 
     textprintf_ex(buffer, font, x+50, INICIODIFICIL+DISTANCIATITULO, makecol(255,255,0), -1, "%s","Pontos"); 
     y+=10;
     for (i=0;i<tamanhoDificil;i++)
     {
         fread(&mostrar,sizeof(ranking),1,recordDificil);
         textprintf_ex(buffer, font, x-20, INICIODIFICIL+DISTANCIATITULO+y-20, makecol(255,255,0), -1, "%d.",i+1);
         textprintf_ex(buffer, font, x, INICIODIFICIL+DISTANCIATITULO+y-20, makecol(RED,GREEN,BLUE), -1, "%c",mostrar.nome[0]); x+=10;
         textprintf_ex(buffer, font, x, INICIODIFICIL+DISTANCIATITULO+y-20, makecol(RED,GREEN,BLUE), -1, "%c",mostrar.nome[1]); x+=10;
         textprintf_ex(buffer, font, x, INICIODIFICIL+DISTANCIATITULO+y-20, makecol(RED,GREEN,BLUE), -1, "%c",mostrar.nome[2]); x+=30;
         textprintf_ex(buffer, font, x, INICIODIFICIL+DISTANCIATITULO+y-20, makecol(RED,GREEN,BLUE), -1, "%d",mostrar.pontos); y+=10;
         x=XCLASSICO;
     }
     y+=10;
     
     //Jogo Batalha
     y=YINICIAL;
     x=XBATALHA;
     //textprintf_ex(buffer, font1, 485, 15+YINICIAL, makecol(RED,GREEN,BLUE), -1, "%s","Batalha");
     //textprintf_ex(buffer, font1, 500, INICIOFACIL+YINICIAL, makecol(RED,GREEN,BLUE), -1, "%s","Facil");
     textprintf_ex(buffer, font, 10+x, INICIOFACIL+DISTANCIATITULO+YINICIAL, makecol(255,255,0), -1, "%s","Nome"); 
     textprintf_ex(buffer, font, 10+x+50, INICIOFACIL+DISTANCIATITULO+YINICIAL, makecol(255,255,0), -1, "%s","Pontos"); 
     y+=10;
     for (i=0;i<tamanhoFacilBatalha;i++)
     {
         fread(&mostrar,sizeof(ranking),1,recordFacilBatalha);
         textprintf_ex(buffer, font, x-10, INICIOFACIL+DISTANCIATITULO+y, makecol(255,255,0), -1, "%d.",i+1);
         textprintf_ex(buffer, font, 10+x, INICIOFACIL+DISTANCIATITULO+y, makecol(RED,GREEN,BLUE), -1, "%c",mostrar.nome[0]); x+=10;
         textprintf_ex(buffer, font, 10+x, INICIOFACIL+DISTANCIATITULO+y, makecol(RED,GREEN,BLUE), -1, "%c",mostrar.nome[1]); x+=10;
         textprintf_ex(buffer, font, 10+x, INICIOFACIL+DISTANCIATITULO+y, makecol(RED,GREEN,BLUE), -1, "%c",mostrar.nome[2]); x+=30;
         textprintf_ex(buffer, font, 10+x, INICIOFACIL+DISTANCIATITULO+y, makecol(RED,GREEN,BLUE), -1, "%d",mostrar.pontos); y+=10;
         x=XBATALHA;
     }
     y=YINICIAL;
     x=XBATALHA;
     //textprintf_ex(buffer, font1, 500, INICIOMEDIO, makecol(RED,GREEN,BLUE), -1, "%s","Medio");
     textprintf_ex(buffer, font, 10+x, INICIOMEDIO+DISTANCIATITULO, makecol(255,255,0), -1, "%s","Nome"); 
     textprintf_ex(buffer, font, 10+x+50, INICIOMEDIO+DISTANCIATITULO, makecol(255,255,0), -1, "%s","Pontos"); 
     y+=10;
     for (i=0;i<tamanhoMedioBatalha;i++)
     {
         fread(&mostrar,sizeof(ranking),1,recordMedioBatalha);
         textprintf_ex(buffer, font, x-10, INICIOMEDIO+DISTANCIATITULO+y-20, makecol(255,255,0), -1, "%d.",i+1);
         textprintf_ex(buffer, font, 10+x, INICIOMEDIO+DISTANCIATITULO+y-20, makecol(RED,GREEN,BLUE), -1, "%c",mostrar.nome[0]); x+=10;
         textprintf_ex(buffer, font, 10+x, INICIOMEDIO+DISTANCIATITULO+y-20, makecol(RED,GREEN,BLUE), -1, "%c",mostrar.nome[1]); x+=10;
         textprintf_ex(buffer, font, 10+x, INICIOMEDIO+DISTANCIATITULO+y-20, makecol(RED,GREEN,BLUE), -1, "%c",mostrar.nome[2]); x+=30;
         textprintf_ex(buffer, font, 10+x, INICIOMEDIO+DISTANCIATITULO+y-20, makecol(RED,GREEN,BLUE), -1, "%d",mostrar.pontos); y+=10;

         x=XBATALHA;
     }
     y=YINICIAL;
     x=XBATALHA;
     //textprintf_ex(buffer, font1, 500, INICIODIFICIL, makecol(RED,GREEN,BLUE), -1, "%s","Dificil");
     textprintf_ex(buffer, font, 10+x, INICIODIFICIL+DISTANCIATITULO, makecol(255,255,0), -1, "%s","Nome"); 
     textprintf_ex(buffer, font, 10+x+50, INICIODIFICIL+DISTANCIATITULO, makecol(255,255,0), -1, "%s","Pontos"); 
     y+=10;
     for (i=0;i<tamanhoDificilBatalha;i++)
     {
         fread(&mostrar,sizeof(ranking),1,recordDificilBatalha);
         textprintf_ex(buffer, font, x-10, INICIODIFICIL+DISTANCIATITULO+y-20, makecol(255,255,0), -1, "%d.",i+1);
         textprintf_ex(buffer, font, 10+x, INICIODIFICIL+DISTANCIATITULO+y-20, makecol(RED,GREEN,BLUE), -1, "%c",mostrar.nome[0]); x+=10;
         textprintf_ex(buffer, font, 10+x, INICIODIFICIL+DISTANCIATITULO+y-20, makecol(RED,GREEN,BLUE), -1, "%c",mostrar.nome[1]); x+=10;
         textprintf_ex(buffer, font, 10+x, INICIODIFICIL+DISTANCIATITULO+y-20, makecol(RED,GREEN,BLUE), -1, "%c",mostrar.nome[2]); x+=30;
         textprintf_ex(buffer, font, 10+x, INICIODIFICIL+DISTANCIATITULO+y-20, makecol(RED,GREEN,BLUE), -1, "%d",mostrar.pontos); y+=10;
         x=XBATALHA;
     }
     y+=10;
     
     blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
     
     key[KEY_ESC] = 0 ;
	 while (!key[KEY_ESC] && !FecharJogo)
	 {
		rest(10); //diminui o uso de CPU
		while (!key[KEY_ESC] && !FecharJogo && contFrames>0)
		{
            //rest(10);
            //Conta os frames
            contFrames--;
            if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
            fpsC++;
		}
     }
     fclose(recordFacil);
     fclose(recordMedio);
     fclose(recordDificil);
     
     fclose(recordFacilBatalha);
     fclose(recordMedioBatalha);
     fclose(recordDificilBatalha);
     
     destroy_bitmap (buffer);
     destroy_font(font1);
     destroy_bitmap(fundo);
}


//----------------------------------------------------------------------
void jogar(int nivel, int corCarro)
{
     contFrames=0; //zera o contador
    int nivelbak = nivel; 
    disable_vsync();
    SAMPLE *somtiro = load_wav("wav/Gun.wav");
    SAMPLE *topgear = load_wav("wav/TopGear.wav");
    SAMPLE *sombateu = load_wav("wav/bateu.wav");
    play_sample(topgear,volume,90,1000,1); 
    
    //Mascaras para colisão
    PMASK mask_carro;
    PMASK mask_carropc1;
    PMASK mask_carropc2;
    PMASK mask_carropc3;
    PMASK mask_coracao;
    PMASK mask_metralhadoraH;
    PMASK mask_metralhadoraV;
    PMASK mask_tiro;
    
    PALLETE pl; 
    int Carro_x = 260,Carro_y = 440;
    int CarroX = 260,CarroY = 440;
    int esq = 0,dir = 0,cima= 0,baixo =0;
    int esqM = 0,dirM = 0,cimaM= 0,baixoM =0;   
    int random;
    int cor = 255; 
    
    BITMAP *explosion[9];
    int explosaoCont=0;
    
    explosion[0] = load_gif("img/explosion2/explosion1.gif", pl);
    explosion[1] = load_gif("img/explosion2/explosion2.gif", pl);
    explosion[2] = load_gif("img/explosion2/explosion3.gif", pl);
    explosion[3] = load_gif("img/explosion2/explosion4.gif", pl);
    explosion[4] = load_gif("img/explosion2/explosion5.gif", pl);
    explosion[5] = load_gif("img/explosion2/explosion6.gif", pl);
    explosion[6] = load_gif("img/explosion2/explosion7.gif", pl);
    explosion[7] = load_gif("img/explosion2/explosion8.gif", pl);
    explosion[8] = load_gif("img/explosion2/explosion9.gif", pl);
    explosion[9] = load_gif("img/explosion2/explosion10.gif", pl);
    
    
    FONT *font1 = load_font("fonts/impact.pcx", NULL, NULL);   

    BITMAP *buffer = create_bitmap(800, 600);
    BITMAP *buffer2 = create_bitmap(800, 600);
    BITMAP *rua = load_jpg("img/rua2.jpg", pl);
    BITMAP *ruabuffer = load_jpg("img/rua3.jpg", pl);
    BITMAP *coracao = load_gif("img/coração.gif",NULL);
    BITMAP *bateu = load_gif("img/bateu.gif", pl);
    BITMAP *fimdejogo = load_gif("img/Fim_jogo.gif", pl);
    BITMAP *metralhadoraH = load_gif("img/metralhadoraH.gif", pl);
    BITMAP *metralhadoraV = load_gif("img/metralhadoraV.gif", pl);
    BITMAP *tiro = load_gif("img/bala3.gif", pl);
    BITMAP *balaIMG = load_gif("img/bala1.gif", pl);
    
    //Load Cor do carro
    BITMAP *carro ;   
    if (corCarro == 1)
       carro = load_gif("img/carro_azul.gif", pl);
    else 
    if (corCarro == 2)
       carro = load_gif("img/carro_verm.gif", pl);
    else 
    if (corCarro == 3)
       carro = load_gif("img/carro_verde.gif", pl);
    else 
       carro = load_gif("img/carro_verm.gif", pl); 
    
    int randomCor;     
    // Carros pc         
    BITMAP *carpc1;
    BITMAP *carpc2;
    BITMAP *carpc3;
    srand(time(NULL));// gera numero aleatório toda hora que iniciado   
    randomCor=rand()%2;
    //Cor aleatória do carropc
        if(corCarro == 1)
        {
            
            switch (randomCor)
            {
                 case 0 : carpc1 = load_gif("img/carro_verde.gif", pl);
                          carpc2 = load_gif("img/carro_verde.gif", pl);
                          carpc3 = load_gif("img/carro_verde.gif", pl);
                          break;
                 case 1 : carpc1 = load_gif("img/carro_verm.gif", pl); 
                          carpc2 = load_gif("img/carro_verm.gif", pl);
                          carpc3 = load_gif("img/carro_verm.gif", pl);  
                          break; 
                 default : carpc1 = load_gif("img/carro_verde.gif", pl); 
                           carpc2 = load_gif("img/carro_verde.gif", pl); 
                           carpc3 = load_gif("img/carro_verde.gif", pl); 
                           break;
            }
        }else
        if(corCarro == 2)
        {

            switch (randomCor)
            {
                 case 0 : carpc1 = load_gif("img/carro_verde.gif", pl);
                          carpc2 = load_gif("img/carro_verde.gif", pl);
                          carpc3 = load_gif("img/carro_verde.gif", pl);   
                          break;
                 case 1 : carpc1 = load_gif("img/carro_azul.gif", pl);
                          carpc2 = load_gif("img/carro_azul.gif", pl);
                          carpc3 = load_gif("img/carro_azul.gif", pl);  
                          break; 
                 default : carpc1 = load_gif("img/carro_verde.gif", pl);
                           carpc2 = load_gif("img/carro_verde.gif", pl);
                           carpc3 = load_gif("img/carro_verde.gif", pl); 
                           break;
            }
        }else  
        if(corCarro == 3)
        {

            switch (randomCor)
            {
                 case 0 : carpc1 = load_gif("img/carro_verm.gif", pl);
                          carpc2 = load_gif("img/carro_verm.gif", pl);
                          carpc3 = load_gif("img/carro_verm.gif", pl);   
                          break;
                 case 1 : carpc1 = load_gif("img/carro_azul.gif", pl); 
                          carpc2 = load_gif("img/carro_azul.gif", pl);  
                          carpc3 = load_gif("img/carro_azul.gif", pl); 
                          break;
                 default : carpc1 = load_gif("img/carro_azul.gif", pl); 
                           carpc2 = load_gif("img/carro_azul.gif", pl);
                           carpc3 = load_gif("img/carro_azul.gif", pl);
                           break; 
            }
        }else
        {
            carpc1 = load_gif("img/carro_verde.gif", pl);
            carpc2 = load_gif("img/carro_verde.gif", pl); 
            carpc3 = load_gif("img/carro_verde.gif", pl);
        }    
    //------------------------ 
    
    
    BITMAP *logo = load_bitmap("img/minilogo.bmp", pl);
    BITMAP *itens = load_bitmap("img/itens.bmp", pl);
    
    //Agrupar mascara com variavel imagem
    init_allegro_pmask(&mask_carro, carro);
	init_allegro_pmask(&mask_carropc1, carpc1);
	init_allegro_pmask(&mask_carropc2, carpc2);
	init_allegro_pmask(&mask_carropc3, carpc3);
	init_allegro_pmask(&mask_coracao, coracao);
	init_allegro_pmask(&mask_metralhadoraH, metralhadoraH);
	init_allegro_pmask(&mask_metralhadoraV, metralhadoraV);
	init_allegro_pmask(&mask_tiro, tiro);
	
    int colide1;
    int colide2;
    int colide3;  // recebera informaçoes de colisões    
    
    int y_barra = 588;
    int x = 0; // coordenada da rua 1
    int y = -818; // coordenada da rua 2
    int vel = nivel; // indicador de velocidade
    int calculavel=0; // modifica velocidade ao apertar UP  
    
    int pontos = 0;
      
    //x_pc irá futuramente receber um valor especifico da variavel RANDOM 
    //igual ao HaxRace1.0
    // COORDENADAS PARA CADA PISTA
    // PISTA 1 = x_pc 45
    // PISTA 2 = x_pc 153
    // PISTA 3 = x_pc 259
    // PISTA 4 = x_pc 369
    // PISTA 5 = x_pc 479
    int posicao[5] = {45 , 153 , 259 , 369 , 479};
    int contPosicao = 0;
    int auxPosicao;
    int x_pc,x_pc2,x_pc3; // coordenada do carro pc
    int y_pc = -500,y_pc2 = -500,y_pc3=-500; // coordenada do carro pc    
    int velpc; // velocidade de descida do carropc, *deve ser negativa
    int carropc1_natela = 1;
    int carropc2_natela = 1;
    int carropc3_natela = 1;
    
    //Verifica nivel e atualiza a velocidade do carropc de acordo com nivel
    if (nivel == 15)
       velpc=1;
    if (nivel == 20)
       velpc=1;
    if (nivel == 25)
       velpc=1;
   
    int vidas = 3;
    int vidapc = 2,vidapc2 = 2,vidapc3 = 2;
    int contvidas = 0;
    int continteracao = 0;
    int continteracaoMetr = 0;
    
    int x_metr;
    int y_metr = -500;
    int metralhadoraAtiva = 0;
    int MetrX,MetrY; 
    int TiroX,TiroY;
    balas bala[30];
    int contTiro = 0;
    int maxTiros = 29;
    int i;
    int k; 
    
    int x_coracao = 446; // 118 , 255 , 332 , 446 
    int y_coracao = - 500;
    int colideCoracao;
    int colideMetr;  
    int randomCoracao;
    int randomMetralhadora;
    int contSubida;
    int colideTiro,colideTiro2,colideTiro3;
    int colideTiroAtivo=0,colideTiroAtivo2=0,colideTiroAtivo3=0;
    int colideCarroPc,colideCarroPc2;
    int contInteracaoTotal = 0;//conta totais de interaçoes por carro pc 1
    
    int tempoMotor = 0;
    int nivelreal; // armazena o nivel passado pelo jogador        
    draw_sprite(buffer,ruabuffer,0,0 );
    
    // loop principal-----------------------------------------------
    while (!key[KEY_ESC] && !FecharJogo) 
    {   
    rest(RESTFPSJOGO); //diminui o uso de CPU
    while (!key[KEY_ESC] && !FecharJogo && contFrames>0)
    {
        //acquire_bitmap(buffer);
        //clear(buffer);
        
      // FAZ COM QUE O TIRO MATE SOMENTE UM CARRO        
        if( (colideTiroAtivo) && (y_pc2>0 || y_pc3>0))
        { 
            y_pc = -500;
              
        }else
           if( (colideTiroAtivo) && (y_pc2<0 || y_pc3<0)) 
                colideTiroAtivo = 0;
               
        if( (colideTiroAtivo2) && (y_pc>0 || y_pc3>0))
        { 
            y_pc2 = -500;
              
        } else
            if( (colideTiroAtivo2) && (y_pc<0 || y_pc3<0))
                colideTiroAtivo2 = 0;
                
        if( (colideTiroAtivo3) &&  (y_pc2>0 || y_pc>0))
        { 
            y_pc3 = -500;           
             
        } else  
            if( (colideTiroAtivo3) && (y_pc2<0 || y_pc<0))
                 colideTiroAtivo3 = 0; 
              
        // FIM DE JOGO COM VIDAS 0
        if(vidas == 0)
        {
           draw_sprite(screen,fimdejogo,0,0 );
           rest(2000);
           key[KEY_ESC] = 1;
        } 
        // ALEATORIO PARA CARROPC1
        srand(time(NULL));// gera numero aleatório toda hora que iniciado   
        random=rand()%5;//%4 gera de 0  a 4
        
        if (!carropc1_natela)
        switch (random)
        {
           case 0 : x_pc = posicao[0]; 
                           break;
           case 1 : x_pc = posicao[1];
                           auxPosicao = posicao[0];
                           posicao[0] = posicao[1];
                           posicao[1] = auxPosicao; 
                           break;
           case 2 : x_pc = posicao[2];
                           auxPosicao = posicao[0];
                           posicao[0] = posicao[2];
                           posicao[2] = auxPosicao; 
                           break;
           case 3 : x_pc = posicao[3];
                           auxPosicao = posicao[0];
                           posicao[0] = posicao[3];
                           posicao[3] = auxPosicao; 
                           break;
           case 4 : x_pc = posicao[4];
                           auxPosicao = posicao[0];
                           posicao[0] = posicao[4];
                           posicao[4] = auxPosicao; 
                           break;
        }
        //--------
        srand(time(NULL));// gera numero aleatório toda hora que iniciado   
        random=(rand()%4) + 1;//%4 gera de 0  a 4 
          
        
        if (!carropc2_natela)                         
        switch (random)
        {
           case 1 : x_pc2 = posicao[1];
                    break;
           case 2 : x_pc2 = posicao[2];
                       auxPosicao = posicao[1];
                       posicao[1] = posicao[2];
                       posicao[2] = auxPosicao; 
           break;
           case 3 : x_pc2 = posicao[3];
                       auxPosicao = posicao[1];
                       posicao[1] = posicao[3];
                       posicao[3] = auxPosicao; 
           break;
           case 4 : x_pc2 = posicao[4];
                       auxPosicao = posicao[1];
                       posicao[1] = posicao[4];
                       posicao[4] = auxPosicao; 
           break;
        }        
       
        // ALEATORIO PARA CARROPC3
        srand(time(NULL));// gera numero aleatório toda hora que iniciado   
        random=(rand()%3) + 2;//%4 gera de 0  a 4
        
        if (!carropc3_natela) 
        switch (random)
        {
           case 2 : x_pc3 = posicao[2];
           break;
           case 3 : x_pc3 = posicao[3];
                       auxPosicao = posicao[2];
                       posicao[2] = posicao[3];
                       posicao[3] = auxPosicao; 
           break;
           case 4 : x_pc3 = posicao[4];
                       auxPosicao = posicao[2];
                       posicao[2] = posicao[4];
                       posicao[4] = auxPosicao; 
           break;
        }  
        
        // COLISAO          
        colide1 = check_pmask_collision (&mask_carro, &mask_carropc1, CarroX, CarroY, x_pc, y_pc);
        colide2 = check_pmask_collision (&mask_carro, &mask_carropc1, CarroX, CarroY, x_pc2, y_pc2);
        colide3 = check_pmask_collision (&mask_carro, &mask_carropc1, CarroX, CarroY, x_pc3, y_pc3);
        if (colide1 || colide2 || colide3)
        {    
             play_sample(sombateu,volume,90,1000,0);
             rest(1000);
             stop_sample(sombateu);       
             while (!key[KEY_ENTER] && !FecharJogo)
	         {
        		rest(RESTFPSJOGO); //diminui o uso de CPU
        		while (!key[KEY_ENTER] && !FecharJogo && contFrames>0)
        		{                
                    textout_ex(screen,font1,"BATEU",679,350,makecol(255,255,0),-1); 
                    textout_ex(screen,font1,"PRESSIONE ENTER PARA",617,367,makecol(255,255,0),-1);
                    textout_ex(screen,font1,"CONTINUAR",663,384,makecol(255,255,0),-1);                             
                    //Conta os frames
        			contFrames--;
        			if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
                    fpsC++;
    	       	}
	         } 
             key[KEY_ENTER] = 0;  
             //Reinicia Carro            
             CarroX = 260;
             CarroY = 440;
             esq = 0;
             dir = 0;
             cima= 0;
             baixo =0;              
             //Reinicia Vel
             vel = nivel;
             //Deleta carropc da tela
             y_pc = -500;
             y_pc2 = -500;
             y_pc3 = -500;
             //Atualiza Vidas
             vidas -= 1; 
             y_coracao = -500;    
             //Atualiza Barra do Estresse do moto
             y_barra = 588;
             //Atualiza Cor do escrito do Acelerador
             cor = 255;
             //Retira Metralhadora
             metralhadoraAtiva = 0;
             contTiro=0;
             y_metr = -500;                  
        }  
        //Pausar jogo
        if (key[KEY_P])
        pausarJogo(&vidas);

        // DESENHA A RUA 
        draw_sprite(buffer,ruabuffer,0,0 );      
        x+=vel-vel/2;
        if (x >= 818)
          x=-818+vel;
        draw_sprite(buffer,rua,0,x );
        
        y+=vel-vel/2;
        if (y >= 818)
          y=-818+vel;
        draw_sprite(buffer,rua,0,y ); 
                         
      // DESENHA CARRO PC
      if(nivel >= 15)
      {          
        if(y_pc>=700)
        {
           y_pc=-280;
           //reseta a vida caso ele saia da tela
           vidapc = 2; 
           if(nivel < 20) 
              pontos+=10;
           else
           if(nivel < 25) 
              pontos+=20;
           else
           if(nivel >= 25) 
              pontos+=30;
           continteracao += 1;
           continteracaoMetr += 1;
           contInteracaoTotal += 1;
           carropc1_natela = 0;
          //Conta total de interaçoes feitas pelo carro pc 1 e incrementa NIVEL
          if (contInteracaoTotal>0 && contInteracaoTotal%5==0 && nivel < 25)
          {
             vel++;                      
             nivel++;
          } else
          if (contInteracaoTotal>0 && contInteracaoTotal%7==0 && nivel >= 25 && nivel <= 30)
          {
             vel++;                      
             nivel++;
          } 
               
        } else 
               carropc1_natela = 1;     
        if(y_pc<=-500)
        {
               y_pc=-280;
               carropc1_natela = 0;
               //reseta a vida caso ele morra 
               vidapc = 2;              
        } 
        draw_sprite(buffer,carpc1,x_pc,y_pc );
        y_pc+=vel-vel/2-velpc;
      } 
      
      // DESENHA CARRO PC 2
      if(nivel >= 20)
      {          
        if(y_pc2>=700)
        {
           y_pc2=-280;
           //reseta a vida caso ele saia da tela
           vidapc3 = 2;  
           if(nivel < 20) 
              pontos+=10;
           else
           if(nivel < 25) 
              pontos+=20;
           else
           if(nivel >= 25) 
              pontos+=30;
           //continteracao += 1;
           //continteracaoMetr += 1;
           carropc2_natela = 0;
        } else 
               carropc2_natela = 1;     
        if(y_pc2<=-500)
        {
               y_pc2=-280;
               carropc2_natela = 0;
               //reseta a vida caso ele morra 
               //vidapc = 2;              
        } 
        draw_sprite(buffer,carpc2,x_pc2,y_pc2 );
        y_pc2+=vel-vel/2-velpc;
      } 
       // DESENHA CARRO PC 3
      if(nivel >= 25)
      {          
        if(y_pc3>=700)
        {
           y_pc3=-280;
           //reseta a vida caso ele saia da tela
           vidapc3 = 2;  
           if(nivel < 20) 
              pontos+=10;
           else
           if(nivel < 25) 
              pontos+=20;
           else
           if(nivel >= 25)
              pontos+=30;
           //continteracao += 1;
           //continteracaoMetr += 1;
           carropc3_natela = 0;
        } else 
               carropc3_natela = 1;     
        if(y_pc3<=-500)
        {
           y_pc3=-280;
           carropc3_natela = 0;
           //reseta a vida caso ele morra 
           //vidapc = 2;              
        } 
        draw_sprite(buffer,carpc3,x_pc3,y_pc3 );
        y_pc3+=vel-vel/2-velpc;
      } 
      
      //DESENHA CORACAO NA TELA
     //Calcula mais vidas
     if ( continteracao != 0 && continteracao % 10 == 0 && vidas < 5)
     {
      srand(time(NULL));// gera numero aleatório toda hora que iniciado   
      randomCoracao=rand()%4;
      if (!carropc1_natela)
      switch (randomCoracao)
      {
           // 118 , 223 , 332 , 446 
           case 0 : x_coracao = 118; break;
           case 1 : x_coracao = 223; break;
           case 2 : x_coracao = 332; break;
           case 3 : x_coracao = 446; break;
      }                       
      colideCoracao = check_pmask_collision (&mask_carro, &mask_coracao, CarroX, CarroY, x_coracao, y_coracao);
      if (colideCoracao == 1)
      {
         vidas += 1;
         y_coracao = -500;
         continteracao=0;  
      }   
      y_coracao+=vel-vel/2;
      draw_sprite(buffer,coracao,x_coracao,y_coracao );
     } 
     else 
        y_coracao = -500;
        
     //DESENHA METRALHADORA 
     if ( continteracaoMetr != 0 && continteracaoMetr % 8 == 0 && !metralhadoraAtiva )
     {
      srand(time(NULL));// gera numero aleatório toda hora que iniciado   
      randomMetralhadora=rand()%4;
      if (!carropc1_natela)
      switch (randomMetralhadora)
      {
           // 107 , 212 , 322 , 435 
           case 0 : x_metr = 107; break;
           case 1 : x_metr = 212; break;
           case 2 : x_metr = 322; break;
           case 3 : x_metr = 435; break;
      }                       
      colideMetr = check_pmask_collision (&mask_carro, &mask_metralhadoraH, CarroX, CarroY, x_metr, y_metr);
      if (colideMetr == 1)
      {
         y_metr = -500;
         continteracaoMetr=0;
         metralhadoraAtiva = 1;
         contTiro=0;  
      }   
      y_metr+=vel-vel/2;
      draw_sprite(buffer,metralhadoraH,x_metr,y_metr );
     }else 
        y_metr = -500;
          
     
        // DESENHA MENU LATERAL
        rectfill(buffer, 603, 0, 800, 600, makecol(100, 100, 100));      
        line(buffer, 598,0, 598,600, makecol(100,150,100 ));
        line(buffer, 599,0, 599,600, makecol(100,200,100 ));
        line(buffer, 600,0, 600,600, makecol(100,255,100 ));
        line(buffer, 601,0, 601,600, makecol(100,200,100 ));
        line(buffer, 602,0, 602,600, makecol(100,150,100 ));
        draw_sprite(buffer,logo,610,5 );
        line(buffer, 601,40, 800,40, makecol(100,150,100 ));
        line(buffer, 601,41, 800,41, makecol(100,255,100 ));
        line(buffer, 601,42, 800,42, makecol(100,150,100 ));
        draw_sprite(buffer,itens,625,50 ); 
               
        //DESENHA VELOCIMETRO
        circlefill(buffer, 700,220,41, makecol(0,255,0));
        circlefill(buffer, 700,220,40, makecol(0,220,0));
        circlefill(buffer, 700,220,39, makecol(0,200,0));
        circlefill(buffer, 700,220,38, makecol(0,150,0));
        rectfill(buffer,650,220,750,280,makecol(100,100,100));
        line(buffer, 659,220, 741,220, makecol(0,255,0 ));
        line(buffer, 659,221, 741,221, makecol(0,255,0 ));
        line(buffer, 659,222, 741,222, makecol(0,255,0 ));
        line(buffer, 661,220, 739,220, makecol(0,150,0 ));
        line(buffer, 661,221, 739,221, makecol(0,200,0 ));
        textprintf_ex(buffer, font, 685, 215, makecol(0,255,0), -1, "KM/H");
        
        //PONTEIRO VELOCIMETRO
         if (vel<=7)
           line(buffer,660+vel*2,220-vel*4,700,220, makecol(255,255,0 ));
        else
        if (vel>7 && vel<=17)
           line(buffer,660+vel*2,220-28-vel+7,700,220, makecol(255,255,0 ));
        else
        if (vel>17 && vel<=20)
           line(buffer,660+vel*2,220-28-vel+10,700,220, makecol(255,255,0 ));
        else
        if (vel>20 && vel<=25)
           line(buffer,660+vel*2,220-38+vel-22,700,220, makecol(255,255,0 ));
        else
        if (vel>25 && vel<=35)
           line(buffer,660+vel*2,220-38+vel-22,700,220, makecol(255,255,0 ));
        //Imprime Velocidade
       if(vel!=2)    
        textprintf_ex(buffer, font1, 686, 195, makecol(0,255,0), -1, "%d",vel*10);
       else
        textprintf_ex(buffer, font1, 686, 195, makecol(0,255,0), -1, "0"); 
        //Imprime Vidas       
        for(contvidas = 0; contvidas < vidas; contvidas++)
           draw_sprite(buffer,coracao,650+contvidas*15,125); 
                  
        // Movimento e limites laterais do carro 
       if (vel>1)
       {              	
      	   	
            if (key[KEY_LEFT])
            {   		
               if (Carro_x - esq + dir >= 50)
               {
                     esq += 10;
                     CarroX = Carro_x - esq + dir;
                     CarroY = Carro_y - cima + baixo;
                     rotate_sprite(buffer, carro,CarroX,CarroY , itofix(-3));
               }else
                {
                  CarroX = Carro_x - esq + dir;
                  CarroY = Carro_y - cima + baixo;  
                  draw_sprite(buffer,carro,CarroX,CarroY);
                } 
            } 
            else                                    
            if (key[KEY_RIGHT])
            {
               if (Carro_x - esq + dir <= 480)
               {
                   dir += 10;
                   CarroX = Carro_x - esq + dir;
                   CarroY = Carro_y - cima + baixo;
                   rotate_sprite(buffer, carro,CarroX,CarroY, itofix(2));  
               }else 
                {
                  CarroX = Carro_x - esq + dir;
                  CarroY = Carro_y - cima + baixo;   
                  draw_sprite(buffer,carro,CarroX,CarroY );
                }  
            }
            else
            {
                 CarroX = Carro_x - esq + dir;
                 CarroY = Carro_y - cima + baixo;
                 draw_sprite(buffer,carro,CarroX,CarroY ); 
            }     
                                      
       }
       //METRALHADORA ATIVADA 
         if(metralhadoraAtiva)
         {                                          
            //VAZENDO A MOVIMENTAÇÃO    
                if (key[KEY_LEFT])
                {   		
                   if (Carro_x - esq + dir >= 50)
                   {
                         MetrX = Carro_x - esq + dir + 40;
                         MetrY = Carro_y - cima + baixo - 10;
                         rotate_sprite(buffer, metralhadoraV,MetrX,MetrY , itofix(-3));
                   }else
                    {
                      MetrX = Carro_x - esq + dir + 40;
                      MetrY = Carro_y - cima + baixo - 10;  
                      draw_sprite(buffer,metralhadoraV,MetrX,MetrY);
                    } 
                } 
                else                                    
                if (key[KEY_RIGHT])
                {
                   if (Carro_x - esq + dir <= 480)
                   {
                       MetrX = Carro_x - esq + dir + 40;
                       MetrY = Carro_y - cima + baixo - 10;
                       rotate_sprite(buffer, metralhadoraV,MetrX,MetrY, itofix(2));  
                   }else 
                    {
                      MetrX = Carro_x - esq + dir + 40;
                      MetrY = Carro_y - cima + baixo - 10;   
                      draw_sprite(buffer,metralhadoraV,MetrX,MetrY );
                    }  
                }
                else
                {
                     MetrX = Carro_x - esq + dir + 40;
                     MetrY = Carro_y - cima + baixo - 10;
                     draw_sprite(buffer,metralhadoraV,MetrX,MetrY ); 
                }
            //------------------IMPRIME AS BALAS NO MENU----------------- 
             draw_sprite(buffer,metralhadoraV,610,465 );
             rect(buffer,635,476,790,522,makecol(0,150,0));
             rect(buffer,634,475,791,523,makecol(0,200,0));
             rect(buffer,633,474,792,524,makecol(0,255,0));
             rectfill(buffer,633,484,792,514,makecol(100,100,100));
              for(k = 0; k <= maxTiros-contTiro;k++)
              {
                if (k <= 14)    
                 draw_sprite(buffer,balaIMG,639+k*10,480);
                else
                for(i=0;i<=maxTiros-contTiro-15;i++)
                 draw_sprite(buffer,balaIMG,639+i*10,500);
                 
              }      
             // IMPRIMINDO TIRO NA TELA        
           //-------------------------------------
                 
          if (key[KEY_W] || key[KEY_SPACE]) 
         {
              bala[contTiro].x = MetrX + 7;
              bala[contTiro].y = MetrY - 18;  // Sai da arma no pixel MetrX + 7 MetrY - 18
              bala[contTiro].ativado = 1;
              for (contSubida = 1;contSubida <= 200; contSubida++);    
              if(contTiro <= maxTiros)   
                 contTiro+=1;
              else
              {
                 contTiro=0;
                 metralhadoraAtiva=0; 
              }
        // play_sample(somtiro,volume,90,1000,1);
              
             key[KEY_W]=0;
             key[KEY_SPACE]=0;                 
         }
          //-----------------------------------------------------            
           for (i=0;i<contTiro;i++)
          {
             if (bala[i].ativado)
             { 
                 draw_sprite(buffer,tiro,bala[i].x,bala[i].y);      
                 bala[i].y-=15;
                 if(bala[i].y<0 && contTiro >= 1)
                 {
                  //contTiro--;
                  bala[i].x = 1500;
                  bala[i].y = 1500;
                  bala[i].ativado = 0;
                 } 
             }
             colideTiro = check_pmask_collision (&mask_carropc1, &mask_metralhadoraH, x_pc, y_pc, bala[i].x, bala[i].y);
             colideTiro2 = check_pmask_collision (&mask_carropc2, &mask_metralhadoraH, x_pc2, y_pc2, bala[i].x, bala[i].y);
             colideTiro3 = check_pmask_collision (&mask_carropc3, &mask_metralhadoraH, x_pc3, y_pc3, bala[i].x, bala[i].y);
          //DETECTANDO COLISSAO DO TIRO   
             if(colideTiro /*|| colideTiro2 || colideTiro3*/ )
             {  
                for (explosaoCont=0;explosaoCont<9;explosaoCont++)
                {
                    draw_sprite(buffer, explosion[explosaoCont], bala[i].x, bala[i].y);
                    //if (explosaoCont%3==0)
                    //rest(1);
                }
                bala[i].x = 1500;
                bala[i].y = 1500;
                //Reseta variavel de colisao de tiro
                colideTiro = 0;
                //Diminui vida pc
                vidapc--;
                if (vidapc == 0)
                {
                    //Reseta CarroPc       
                   y_pc = -500;
                   //y_pc2 = -500;
                   //y_pc3 = -500;
                   //Aumenta pontos por Colisao do tiro no carropc
                   pontos += 50;
                   colideTiroAtivo = 1; 
                }
                   
             }
            if(colideTiro2)
             {  
                for (explosaoCont=0;explosaoCont<9;explosaoCont++)
                {
                    draw_sprite(buffer, explosion[explosaoCont], bala[i].x, bala[i].y);
                    if (explosaoCont%3==0)
                    rest(1);
                }
                bala[i].x = 1500;
                bala[i].y = 1500;
                //Reseta variavel de colisao de tiro
                colideTiro = 0;
                //Diminui vida pc
                vidapc2--;
                if (vidapc2 == 0)
                {
                    //Reseta CarroPc       
                   y_pc2 = -500;
                   //Aumenta pontos por Colisao do tiro no carropc
                   pontos += 50;
                    colideTiroAtivo2 = 1;
                }
                    
             }  
             if(colideTiro3)
             {  
                for (explosaoCont=0;explosaoCont<9;explosaoCont++)
                {
                    draw_sprite(buffer, explosion[explosaoCont], bala[i].x, bala[i].y);
                    if (explosaoCont%3==0)
                    rest(1);
                }
                bala[i].x = 1500;
                bala[i].y = 1500;
                //Reseta variavel de colisao de tiro
                colideTiro = 0;
                //Diminui vida pc
                vidapc3--;
                if (vidapc3 == 0)
                {
                    //Reseta CarroPc       
                   y_pc3 = -500;
                   //Aumenta pontos por Colisao do tiro no carropc
                   pontos += 50;
                    colideTiroAtivo3 = 1; 
                }  
                 
             }                   
          }
           if(contTiro > maxTiros)
               textout_ex(buffer,font1,"LIBERAR",681,489,makecol(255,255,0),-1); 
    

         }
         
                         		      
        //aumenta velocidade com a tecla up
        if (key[KEY_UP])
         {
            if (vel<=30)
               calculavel++;
         }
         else //if(!key[KEY_DOWN] && !key[KEY_RIGHT] && !key[KEY_LEFT]) //isso evita q reduza a velocidade caso use as setas
         {
             if (calculavel!=-10 && vel>nivel)
                calculavel--;
         }   
         if (calculavel==10)
         {
               vel++;
               calculavel=0;
          }
         else if(calculavel<=-10)
         {
              vel--;
              calculavel=0;
         }
         // FREIO 
         if (key[KEY_DOWN])
         {
            if (vel>nivel)
               calculavel-=3;
            textout_ex(buffer,font1,"FREIO ATIVADO",647,577,makecol(255,255,0),-1);   
         }
         // Barra de ESTRESSE DO TURBO e BARRA ACELERADOR
        line(buffer, 601,547, 800,547, makecol(100,150,100 ));
        line(buffer, 601,548, 800,548, makecol(100,255,100 ));
        line(buffer, 601,549, 800,549, makecol(100,150,100 ));
        line(buffer, 601,574, 800,574, makecol(100,150,100 ));
        line(buffer, 601,575, 800,575, makecol(100,255,100 ));
        line(buffer, 601,576, 800,576, makecol(100,150,100 ));            
        
         rectfill(buffer, 564, 490, 584, 590, makecol(0, 255, 0));
         rectfill(buffer, 566, 492, 582, 588, makecol(0, 100, 0));
         rectfill(buffer, 566, y_barra, 582, 588, makecol(255, 0, 0));       
         if (key[KEY_UP])
         {
            if (vel>=31 && y_barra > 492)            
               y_barra--;
            if (cor > 0)   
                cor--;   
            textout_ex(buffer,font1,"ACELERADOR ATIVADO",622,551,makecol(255,cor,0),-1); 
         }else  
         {     
         if (y_barra < 588)
             y_barra++;             
         if (cor < 255)
             cor++;              
         }
         if (vel==nivel)
            cor = 255;                           
        key[KEY_UP]==1;            
        textout_ex(buffer,font,"M",571,497,makecol(255,255,0),-1);
        textout_ex(buffer,font,"O",571,516,makecol(255,255,0),-1);
        textout_ex(buffer,font,"T",571,536,makecol(255,255,0),-1);
        textout_ex(buffer,font,"O",571,556,makecol(255,255,0),-1);
        textout_ex(buffer,font,"R",571,576,makecol(255,255,0),-1);
        //---------------------------PONTOS--------------------------------
        textprintf_ex(buffer, font1, 690, 80, makecol(0,255,0), -1, "%d",pontos);   
      
        //----------------------------ESTOURO DO MOTOR------------------------------          
        if(y_barra == 492)
        { 
          tempoMotor++;
          if(tempoMotor != 250)
          {                  
          textout_ex(buffer,font1,"REDUZA",270,5,makecol(255,255,0),-1);// 299 316 
          textout_ex(buffer,font1,"MOTOR ESTRESSANDO",219,25,makecol(255,255,0),-1);
          }                 
          if(tempoMotor == 250)
          {                      
             play_sample(sombateu,volume,90,1000,0);
            
             key[KEY_DOWN] = 1 ;
             key[KEY_UP] = 0 ;
             nivelreal = nivel;
             nivel=0;
             //Deleta carropc1 da tela
             y_pc = -500;
             remove_keyboard();             
          }               
        //Somente caira neste if se motor estressado             
        }
        else
        if (y_barra < 492)
           tempoMotor=0; 
        if(vel==1)
        {
          install_keyboard();
          stop_sample(sombateu);       
          nivel = nivelreal;
          key[KEY_DOWN] = 0 ;
          key[KEY_UP] = 0 ;
          while (!key[KEY_ENTER] && !FecharJogo)
	      {
        		rest(RESTFPS); //diminui o uso de CPU
        		while (!key[KEY_ENTER] && !FecharJogo && contFrames>0)
        		{                                                   
                textout_ex(screen,font1,"MOTOR ESTRESSADO",627,350,makecol(255,255,0),-1); 
                textout_ex(screen,font1,"PRESSIONE ENTER PARA",617,367,makecol(255,255,0),-1);
                textout_ex(screen,font1,"CONTINUAR",663,384,makecol(255,255,0),-1);                             
               //Conta os frames
    			contFrames--;
    			if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
                fpsC++;
		     }
	      } 
             key[KEY_ENTER] = 0;  
             //Reinicia Carro            
             CarroX = 260;
             CarroY = 440;
             esq = 0;
             dir = 0;
             cima= 0;
             baixo =0;              
             //Reinicia Vel
             vel = nivel;
             //Deleta carropc1 da tela
             y_pc = -500;
             y_pc2 = -500;
             y_pc3 = -500;
             //Atualiza Vidas
             vidas -= 1;
             y_coracao = -500;     
             //Atualiza Barra do Estresse do moto
             y_barra = 588;
             //Atualiza Cor do escrito do Acelerador
             cor = 255;
             //Atualiza tempoMotor
             tempoMotor = 0;
             //Retira Metralhadora
             metralhadoraAtiva = 0 ;
             contTiro=0;
             y_metr = -500;
                         
        }
        //Para testar metralhadora na primeira interação
        //metralhadoraAtiva = 1;
        
        //rest(RESTFPS);
        if (vSync)
           vsync();
        //rest(2);
        //masked_blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
        //blit(buffer2, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
        //blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
        
        acquire_bitmap(buffer2);
        clear(buffer2);
        draw_sprite(buffer2,buffer,0,0 );
        
        //pega o buffer
        if (exibirFPS)
           textprintf_ex(buffer2, font, 10, SCREEN_H - 20, makecol(230, 230, 230), -1, "FPS: %d - Tricks/s: %d", fps, fpsT);
        if (get_update_method())
        {
            buffer2 = get_buffer();
        }
        else
        {
            buffer2 = screen;
            if (vsync_is_enabled())
            {
                vsync();
            }
        }
        
        /*acquire_bitmap(buffer);
        clear(buffer);*/
        release_bitmap(buffer2);
        
        
        //Atualiza a tela
        //blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
        if (get_update_method())
        {
            update_screen();
        }
        else
        {
            // já está na tela
        }

        
        // Limpa o buffer 
        clear_bitmap(buffer);
        clear_bitmap(buffer2);    
        // Conta um frame 
        //cont++; 
      
      //Conta os frames
        contFrames--;
        if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
        fpsC++;
        
    }//fim segundo while do jogo
        
    }//fim primeiro while do jogo
    
    /*if (get_update_method())
    {
        shutdown_screen_updating();
    }*/
   stop_sample(topgear); 
   stop_sample(somtiro);
   //Exibe tela de Fim de Jogo
   if (vidas == 0)
   fimdoclassico(pontos,nivelbak,corCarro);
      
   destroy_bitmap(buffer); 
   destroy_bitmap(fimdejogo);  
   destroy_bitmap(carro);
   destroy_bitmap(logo);
   destroy_bitmap(itens);
   destroy_bitmap(rua);  
   destroy_bitmap(ruabuffer);
   destroy_bitmap(carpc1);
   destroy_bitmap(carpc2);
   destroy_bitmap(carpc3);
   destroy_bitmap(coracao);   
   destroy_bitmap(bateu);
   destroy_bitmap(metralhadoraH); 
   destroy_bitmap(metralhadoraV);
   destroy_bitmap(tiro);
   destroy_bitmap(balaIMG); 
   
   destroy_font(font1);
   
   deinit_pmask(&mask_carro);
   deinit_pmask(&mask_carropc1);
   deinit_pmask(&mask_carropc2);
   deinit_pmask(&mask_carropc3);
   deinit_pmask(&mask_coracao);
   deinit_pmask(&mask_metralhadoraH);
   deinit_pmask(&mask_metralhadoraV);
   deinit_pmask(&mask_tiro);
}
//---------------------------------SAIR---------------------------------
int fsair()
{
   rectfill(screen, 0, 0, 800, 600, makecol(0, 0, 0));
   rest(500); 
   return 1;
}
//---------------------------TELA DE NIVEIS------------------------------
void niveis()
{
  contFrames=0; //zera o contador de frames
     
  int opy=100;
  int cor;
  SAMPLE *sonic = load_wav("wav/Sonic4.wav");
  play_sample(sonic,volume,90,1000,1);    
  SAMPLE *click = load_wav("wav/select.wav");
  BITMAP *fundofacil = load_jpg("img/fundofacil.jpg", NULL);
  BITMAP *fundomedio = load_jpg("img/fundomedio.jpg", NULL);
  BITMAP *fundodificil = load_jpg("img/fundodificil.jpg", NULL);
  BITMAP *buffer = create_bitmap(SCREEN_W, SCREEN_H);
  BITMAP *hr = load_bitmap("img/hr.bmp", NULL);
  
  while (!key[KEY_ESC] && !FecharJogo)
  {
    rest(RESTFPS); //diminui o uso de CPU
    while (!key[KEY_ESC] && !FecharJogo && contFrames>0)
    {
    	acquire_bitmap(buffer);
    	clear(buffer);
   	
      if (vSync)
       vsync();
    
    if (opy==100)
       draw_sprite(buffer,fundofacil,0,0);  
    if (opy==290)
       draw_sprite(buffer,fundomedio,0,0);  
    if (opy==480)
       draw_sprite(buffer,fundodificil,0,0);                            
  
    line(buffer, 40,90, 800-40,90, CINZA);
    
    draw_sprite(buffer,hr,opy,145);
    
    if(keypressed())
    {
                 
		if(key[KEY_LEFT])
        {
           if(opy > 100)
           {
              play_sample(click,volume,90,1000,0);         
              opy -= 190; 
              rest(100); 
              stop_sample(click);                       
           }      
        }
        if(key[KEY_RIGHT])
        {
           if(opy<480)   
           {  
              play_sample(click,volume,90,1000,0); 
              opy += 190;
              rest(100);
              stop_sample(click);                            
           }
        }
                 
           // Apos apertar ENTER     
          if(key[KEY_ENTER])
          {
             if(opy == 100)
             {
                 // Executa o codigo de Facil  
                 
                 cor = escolhercor();  
                 stop_sample(sonic);                            
                 jogar(15, cor);           
                      
             }
             else if(opy == 290)
             {
                // Executa o codigo de Medil
                  
                cor = escolhercor(); 
                stop_sample(sonic);             
                jogar(20 , cor);
                
             }
             else if(opy == 480)
             {
                // Executa o codigo de Dificil
                  
                cor = escolhercor();  
                stop_sample(sonic);            
                jogar(25, cor);                
             }           
          } 
          clear_keybuf();
		}
		//pega o buffer
		if (exibirFPS)
		textprintf_ex(buffer, font, 10, SCREEN_H - 20, makecol(230, 230, 230), -1, "FPS: %d - Tricks/s: %d", fps, fpsT);
		if (get_update_method())
		{
			buffer = get_buffer();
		}
		else
		{
			buffer = screen;
			if (vsync_is_enabled())
			{
				vsync();
			}
		}

		release_bitmap(buffer);

		//Atualiza a tela
		//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
		if (get_update_method())
		{
			update_screen();
		}
		else
		{
			// já está na tela
		}
		//Conta os frames
		contFrames--;
		if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
        fpsC++;
	}
	
	/*if (get_update_method())
    {
        shutdown_screen_updating();
    }*/   
     
  }
    key[KEY_ESC] = 0; // após voltar pela fimdoclassico ele cancela o ESC 
    stop_sample(sonic);   
    destroy_bitmap(fundofacil);
    destroy_bitmap(fundomedio);
    destroy_bitmap(fundodificil);
    destroy_bitmap(hr);

}
//----------------------------ESCOLHER COR DO CARRO ----------------------
int escolhercor()
{
    PALLETE pl;
     
    BITMAP *escolhercor = load_jpg("img/escolhercor.jpg", NULL);
    BITMAP *carro1 = load_gif("img/carro_verm.gif", pl);
    BITMAP *carro2 = load_gif("img/carro_azul.gif", pl);
    BITMAP *carro3 = load_gif("img/carro_verde.gif", pl);
    BITMAP *hr = load_bitmap("img/hr.bmp", pl);
    BITMAP *buffer = create_bitmap(SCREEN_W, SCREEN_H);
    SAMPLE *click = load_wav("wav/select.wav");
    
    int girar1 = 0;
    int girar2 = 0;
    int girar3 = 0;
    int opy = 90;
    int enterApertado = 0;

    key[KEY_ENTER] = 0;
  while (!key[KEY_ENTER] && !FecharJogo)
  {
	rest(RESTFPS); //diminui o uso de CPU
	while (!key[KEY_ENTER] && !FecharJogo && contFrames>0)
	{
		acquire_bitmap(buffer);
		clear(buffer);
    if (vSync)
    vsync();
    draw_sprite(buffer,escolhercor,0,0);
    line(buffer, 40,90, 800-40,90, CINZA);
    

        if (opy == 90 )
        {
        rotate_sprite(buffer, carro2,135,200, itofix(girar1));
        girar1++;
        }else
        {
        draw_sprite(buffer,carro2,135,200);
        girar1 = 0;
        }
        
        if (opy == 280)
        {
        rotate_sprite(buffer, carro1,360,200, itofix(girar2));
        girar2++;
        }else
        {
        draw_sprite(buffer,carro1,360,200);
        girar2 = 0;
        }
         
        if (opy == 520)
        {
        rotate_sprite(buffer, carro3,580,200, itofix(girar3));
        girar3++;
        }else
        {
        girar3 = 0;
        draw_sprite(buffer,carro3,580,200);
        }                                  

    
    
    draw_sprite(buffer,hr,opy,145);
       // MOVIMENTOS DO CURSOR           
		if(key[KEY_LEFT])
        {
           if(opy > 90 && opy != 520)
           {
              play_sample(click,volume,90,1000,0);
              opy -= 190; 
              rest(100); 
              stop_sample(click);                       
           }else
           if (opy == 520)
           {
           play_sample(click,volume,90,1000,0);          
           opy = 280; 
           rest(100);
           stop_sample(click); 
           }     
        }
        key[KEY_LEFT] = 0;
        if(key[KEY_RIGHT])
        {
           if(opy<520 && opy != 280)   
           {  
              play_sample(click,volume,90,1000,0); 
              opy += 190;
              rest(100);
              stop_sample(click);                            
           } else
           if (opy == 280)
           {
           play_sample(click,volume,90,1000,0);
           opy = 520;
           rest(100);
           stop_sample(click);
           }
        }
        key[KEY_RIGHT] = 0;
                 
           // Apos apertar ENTER     
          if(key[KEY_ENTER])
          {
             if(opy == 90)
             {
                 // Azul
                 return 1;                           
             }
             else if(opy == 280)
             {
                // Vermelho
                return 2;
                
             }
             else if(opy == 520)
             {
                // Verde
                return 3;               
             } 
             else return 2;          
          } 
          clear_keybuf();
    
    
    
    //blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
    //pega o buffer
		if (exibirFPS)
		textprintf_ex(buffer, font, 10, SCREEN_H - 20, makecol(230, 230, 230), -1, "FPS: %d - Tricks/s: %d", fps, fpsT);
		if (get_update_method())
		{
			buffer = get_buffer();
		}
		else
		{
			buffer = screen;
			if (vsync_is_enabled())
			{
				vsync();
			}
		}

		release_bitmap(buffer);

		//Atualiza a tela
		//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
		if (get_update_method())
		{
			update_screen();
		}
		else
		{
			// já está na tela
		}
		//Conta os frames
		contFrames--;
		if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
        fpsC++;
	}
	}
	
	/*if (get_update_method())
    {
        shutdown_screen_updating();
    }*/
        
     destroy_bitmap(hr);
     destroy_bitmap(carro1);
     destroy_bitmap(carro2);
     destroy_bitmap(carro3);    
     destroy_bitmap(escolhercor);
    return 0; 
}
//---------------------------INSTRUÇÕES----------------------------------
void instrucoes()
{
  BITMAP *ComoJogar = load_jpg("img/ComoJogar.jpg", NULL);
     
  draw_sprite(screen,ComoJogar,0,0);  
    
  int ativado=1;
	while (ativado && !FecharJogo)
	{
		rest(10); //diminui o uso de CPU
		while (ativado && !FecharJogo && contFrames>0)
		{     
         if(key[KEY_ESC])
            ativado = 0;
         if(key[KEY_ENTER])
            ativado = 0;                                                  
        //Conta os frames
		contFrames--;
		if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
        fpsC++;
		}
	}  
  key[KEY_ESC] = 0;
  key[KEY_ENTER] = 0;
  
  destroy_bitmap(ComoJogar);
    
}
//-----------------------------CREDITOS-------------------------------------
void info()
{ 
   if (vSync)
    vsync();                         
    BITMAP *creditos = load_jpg("img/creditos.jpg",NULL);
    draw_sprite(screen,creditos,0,0);  
    line(screen, 40,90, 800-40,90, CINZA);    
    line(screen, 40,220, 800-40,220, CINZA);     
    line(screen, 40,380, 800-40,380, CINZA);
            
  int ativado=1;
	while (ativado && !FecharJogo)
	{
		rest(10); //diminui o uso de CPU
		while (ativado && !FecharJogo && contFrames>0)
		{      
         if(key[KEY_ESC])
            ativado = 0;
         if(key[KEY_ENTER])
            ativado = 0;                                                  
          //Conta os frames
	  	  contFrames--;
	  	  if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
          fpsC++;
		}
	}  
  key[KEY_ESC] = 0;
  key[KEY_ENTER] = 0;
  destroy_bitmap(creditos);
}
// -----------------------------------------------------------------------------
void intro()
{
      
     // INTRODUÇÃO HAX RACE 2.0   
    rectfill(screen, 0, 0, 800, 600, makecol(0, 0, 0));        
    BITMAP *logo = load_bitmap("img/haxrace.bmp",NULL);
    highcolor_fade_in(logo,1,140,200);
    
    //rest(3000);
    int cont=1, seg;
    seg=10;
    while (cont<seg*1000)
    {
          //rest(1);
          if (key[KEY_ESC] || key[KEY_ENTER])
             cont=3000;

          cont++;
    }
    
    key[KEY_ESC]=0; //isso aki faz ele apenas sair da primeira imagem da intro
    key[KEY_ENTER]=0;
    BITMAP *ifet = load_bitmap("img/IFET.bmp",NULL);
    highcolor_fade_in(ifet,1,150,200); 
    
    //rest(1000);
    cont=1;
    seg=3;
    while (cont<seg*1000)
    {
          //rest(1);
          if (key[KEY_ESC] || key[KEY_ENTER])
             cont=seg*1000;
          cont++;
    }
    
    //highcolor_fade_out(16,140,200);
	
   // FIM INTRODUÇÃO   
   
    destroy_bitmap(logo);
	destroy_bitmap(ifet);  
	

}
//----------------------------------------------------------------------------

// -------------------------------faz o fade in de BITMAPS--------------------
void highcolor_fade_in(BITMAP *bmp_orig, int speed,int x,int y)
{
     enable_vsync(); //ativa o vsync
     
   BITMAP *bmp_buff;

    if ((bmp_buff = create_bitmap(SCREEN_W, SCREEN_H)))
    {
        int a;
        if (speed <= 0) speed = 16;

        for (a = 0; a < 256; a+=speed)
        {
            clear(bmp_buff);
            set_trans_blender(0,0,0,a);
            draw_trans_sprite(bmp_buff, bmp_orig, x, y);

            if (vSync)
            vsync();
            blit(bmp_buff, screen, 0,0, 0,0, SCREEN_W, SCREEN_H);
            
            if (key[KEY_ESC] || key[KEY_ENTER]) //isso faz ele abandonar o codigo
            {
               break;
            }
        }
        //to zerando as teclas ESC e ENTER no codigo Intro
        destroy_bitmap(bmp_buff);
    } 

    blit(bmp_orig, screen, x,y, x,y, SCREEN_W, SCREEN_H);
    
    disable_vsync(); //desativa o vsync
    
}
// ----------------------- faz o fade out de BITMAPS --------------------------
void highcolor_fade_out(int speed,int x,int y)
{
     enable_vsync(); //ativa o vsync
     
    BITMAP *bmp_orig, *bmp_buff;

    if ((bmp_orig = create_bitmap(SCREEN_W, SCREEN_H)))
    {
        if ((bmp_buff = create_bitmap(SCREEN_W, SCREEN_H)))
        {
            int a;
            blit(screen, bmp_orig, 0,0, 0,0, SCREEN_W, SCREEN_H);
            if (speed <= 0) speed = 16;

            for (a = 255-speed; a > 0; a-=speed)
            {
                clear(bmp_buff);
                set_trans_blender(0,0,0,a);
                draw_trans_sprite(bmp_buff, bmp_orig, x, y);
                if (vSync)
                   vsync();
                blit(bmp_buff, screen, 0,0, 0,0, SCREEN_W, SCREEN_H);
                
                if (key[KEY_ESC] || key[KEY_ENTER]) //isso faz ele abandonar o codigo
                {
                   break;
                }
                
            }
            destroy_bitmap(bmp_buff);
        }
        destroy_bitmap(bmp_orig);
    }

    rectfill(screen, 0,0, SCREEN_W,SCREEN_H, makecol(0,0,0));
    
    disable_vsync(); //desativa o vsync
}



// CRIEI
// ====================== Funcoes Batalha =============
//so serao usadas jpg
void jogarBatalha(int nivel)
{
     contFrames=0;
    disable_vsync();
    //nivel = 300 facil, nivel = 500 medio, nivel = 700 dificil
    long int contIteracoesBatalha=0; //variavel para contar as iteracoes do jogo
    
    SAMPLE *topgear = load_wav("wav/TopGear.wav");
    SAMPLE *somMissel = load_wav("wav/missel.wav");
    SAMPLE *somTiro = load_wav("wav/tiro.wav");
    SAMPLE *somLazer = load_wav("wav/lazer.wav");
    play_sample(topgear,volume,90,1000,0);
    int i, j, k, sair=0; //contadores
    
    int esq = 0,dir = 0,cima= 0,baixo =0;  
    int random;
    
    srand(time(NULL));// gera numero aleatório toda hora que iniciado   
    random=rand()%4;//gera numeros de 0  a 4
    
    FONT *font1 = load_font("fonts/impact.pcx", NULL, NULL); //inicializa a fonte
    
    
    PALLETE pl;
    BITMAP *buffer = create_bitmap(800, 600); clear_bitmap(buffer);
    BITMAP *buffer2 = create_bitmap(800, 600); clear_bitmap(buffer);
    BITMAP *nuvem = load_jpg("img/cacas/oceano.jpg", pl); //fundo do jogo
    BITMAP *nuvemBuffer = load_jpg("img/cacas/oceano.jpg", pl); //buffer de fundo
    //BITMAP *navepc2 = load_gif("img/caça.gif", pl);
    BITMAP *logo = load_bitmap("img/minilogo.bmp", pl);
    BITMAP *itens = load_jpg("img/itensbatalha.jpg", pl);
    
    BITMAP *throttle = load_gif("img/throttle_mao.gif", pl);
    BITMAP *throttleBase = load_gif("img/throttle_base.gif", pl);
    
    //Energia
    BITMAP *naveEnergia[5];
    naveEnergia[0]= load_gif("img/cacas/caca_energia_0.gif", pl);
    naveEnergia[1]= load_gif("img/cacas/caca_energia_1.gif", pl);
    naveEnergia[2]= load_gif("img/cacas/caca_energia_2.gif", pl);
    naveEnergia[3]= load_gif("img/cacas/caca_energia_3.gif", pl);
    naveEnergia[4]= load_gif("img/cacas/caca_energia_3.gif", pl); //Essa imagem nao vai aparecer
    
    //Colisao
    int colide=0; //0 se nao colidiu e 1 se colidiu
    
    //Nave 1 e Colisao
    #define MAXENERGIA 4
    #define MAXVIDA 2
    
    naves nave1; //vetor para fazer player 1 e 2
    nave1.vida=MAXVIDA; //3 vidas
    nave1.energia=MAXENERGIA; //3 de energia, ou seja, se tomar 3 tiros perde 1 vida
    nave1.imagem = load_gif("img/cacas/caca_75x145.gif", pl); //imagens do caça do jogador
    nave1.imagemEsq = load_gif("img/cacas/caca_75x145_esq.gif", pl);
    nave1.imagemDir = load_gif("img/cacas/caca_75x145_dir.gif", pl);
    
    init_allegro_pmask(&nave1.mask, nave1.imagem); //inicia as mascaras para as imagens do caça
    init_allegro_pmask(&nave1.maskEsq, nave1.imagemEsq);
    init_allegro_pmask(&nave1.maskDir, nave1.imagemDir);
    
    nave1.x=260; //posicao iniciao do caça
    nave1.y=440;
    
    //fim Nave 1
    
    //Inimigo 1 ESSA PARTE SERA EXCLUIDA EM BREVE
    /*naves navePc1;
    navePc1.imagem = load_gif("img/cacas/cacapc_75x119.gif", pl);
    
    init_allegro_pmask(&navePc1.mask, navePc1.imagem);
    
    srand(time(NULL)); //gera numero aleatório toda hora que iniciado   
    random=rand()%4;
    navePc1.x=45+(random*140); //45
    navePc1.y=-280; //-280*/
    
    //fim Inimigo 1 SERA EXCLUIDO ATE AKI
    
    //Inimigos
    #define MAXINIMIGOS 4
    inimigos navesPc[MAXINIMIGOS]; //vetor para fazer inimigos
    BITMAP *navesPcImagem = load_gif("img/nave_alien_75x73.gif", pl);
    PMASK navesPcMask;
    int inimigoColide[MAXINIMIGOS]={0,0,0,0}; //vetor para a colisao dos inimigos, no caso 4
    int numeroInimigos=1; //comecara com um inimigo
    switch (nivel)
    {
       case 300: numeroInimigos=1; break; //nivel facil
       case 500: numeroInimigos=2; break; //nivel medio
       case 700: numeroInimigos=3; break; //nivel dificil
    }
    
    init_allegro_pmask(&navesPcMask, navesPcImagem); //inicia a mascara da imagem da nave inimiga
    
    int xInimigos[4]={36,176,324,476}; //posicoes para as naves inimigas
    #define YINIMIGO -130
   
    navesPc[0].x=xInimigos[0]; //36
    navesPc[0].y=YINIMIGO;
    navesPc[1].x=xInimigos[1]; //176
    navesPc[1].y=YINIMIGO;
    navesPc[2].x=xInimigos[2]; //324
    navesPc[2].y=YINIMIGO;
    navesPc[3].x=xInimigos[3]; //476
    navesPc[3].y=YINIMIGO;
    
    navesPc[0].vida=2; //dois tiros o e inimigo morre
    navesPc[1].vida=2;
    navesPc[2].vida=2;
    navesPc[3].vida=2;
    
    #define TEMPOINIMIGO 1000 //tempo para o inimigo ir embora
    //inicializando variaveis dos inimigos
    for (i=0;i<MAXINIMIGOS;i++) //Inicializa as variaveis dos inimigos
    {
       navesPc[i].cont=0; //cont dos inimigos para o tempo q eles ficam na tela
       navesPc[i].cacaNaTela=0; //se for 0 o inimigo nao esta na tela, se 1 esta na tela
       navesPc[i].desviando=0; //se for 0 o inimigo nao esta desviando, se 1 esta desviando
       (i%2==0) ? (navesPc[i].naopersegue=0) : (navesPc[i].naopersegue=1); //se for 0 persegue, 1 vai para a direita e 2 para a esquerda
       navesPc[2].naopersegue=4;
       //inicializando as variaveis dos tiros dos inimigos
       navesPc[i].tiro.tempoTiro=0; //tem 0 iteracoes de tempo q o tiro foi dado
       srand(time(NULL));
       random=rand()%(100+i);
       navesPc[i].tiro.tempoTiro=random; //como tempoTiro%numero faz a nave atirar, entao elas nao atirarao juntas
       navesPc[i].tiro.tiroAtivado=0; //os tiros estao desativados, talvez essa variavel sera excluida
       navesPc[i].tiro.tiroCont=0; //Contador de tiros, 0 nao atirou ainda, e qndo tiros ja atirou
       for (j=0;j<MAXTIROSINIMIGOS;j++)
          navesPc[i].tiro.y[j]=700; //valor "nulo"
    }
    
    //Fim Inimigos
    
    //Missel
    #define TAMANHOSUPER 27 //TAMANHOSUPER = "altura" da imagem do missel
    #define LARGURASUPER 7 //LARGURASUPER = "largura" da imagem do missel
    supers super1[MAXSUPER];
    int super1Cont=5, super1Ativado=1; 
    int superColide=0;
    BITMAP *missel = load_gif("img/cacas/missel2.gif", pl); //imagem do missel
    PMASK misselMask;
    init_allegro_pmask(&misselMask, missel); //mascara da imagem do missel
    
    //Fim Missel
    
    //Tiro
    #define TAMANHOTIRO 20 //TAMANHOTIRO = "altura" do tiro
    #define LARGURATIRO 1 //LARGURATIRO = "largura" do tiro
    tiros tiros1[MAXTIROS]; //em vetor
    int tiro1Cont=1, tiro1Ativado=0, naoAtira=0, naoAtiraCont=0;
    int tiroColide=0;
    BITMAP *tiro = load_gif("img/cacas/tiro.gif", pl); //imagem do tiro
    PMASK tiroMask;
    init_allegro_pmask(&tiroMask, tiro); //mascara da imagem do tiro
    
    //Fim Tiro
    
    /*
    //Codigo do caca animado
    BITMAP *naveanimada[15];
    naveanimada[0] = load_gif("img/cacas/animacao/caca01.gif", pl);
    naveanimada[1] = load_gif("img/cacas/animacao/caca02.gif", pl);
    naveanimada[2] = load_gif("img/cacas/animacao/caca03.gif", pl);
    naveanimada[3] = load_gif("img/cacas/animacao/caca04.gif", pl);
    naveanimada[4] = load_gif("img/cacas/animacao/caca05.gif", pl);
    naveanimada[5] = load_gif("img/cacas/animacao/caca06.gif", pl);
    naveanimada[6] = load_gif("img/cacas/animacao/caca07.gif", pl);
    naveanimada[7] = load_gif("img/cacas/animacao/caca08.gif", pl);
    naveanimada[8] = load_gif("img/cacas/animacao/caca09.gif", pl);
    naveanimada[9] = load_gif("img/cacas/animacao/caca10.gif", pl);
    naveanimada[10] = load_gif("img/cacas/animacao/caca11.gif", pl);
    naveanimada[11] = load_gif("img/cacas/animacao/caca12.gif", pl);
    naveanimada[12] = load_gif("img/cacas/animacao/caca13.gif", pl);
    naveanimada[13] = load_gif("img/cacas/animacao/caca14.gif", pl);
    naveanimada[14] = load_gif("img/cacas/animacao/caca15.gif", pl);
    */
    
    
    //Explosao, qndo alguem leva tiro
    BITMAP *explosion[9];
    int explosaoCont=0;
    
    explosion[0] = load_gif("img/explosion2/explosion1.gif", pl);
    explosion[1] = load_gif("img/explosion2/explosion2.gif", pl);
    explosion[2] = load_gif("img/explosion2/explosion3.gif", pl);
    explosion[3] = load_gif("img/explosion2/explosion4.gif", pl);
    explosion[4] = load_gif("img/explosion2/explosion5.gif", pl);
    explosion[5] = load_gif("img/explosion2/explosion6.gif", pl);
    explosion[6] = load_gif("img/explosion2/explosion7.gif", pl);
    explosion[7] = load_gif("img/explosion2/explosion8.gif", pl);
    explosion[8] = load_gif("img/explosion2/explosion9.gif", pl);
    explosion[9] = load_gif("img/explosion2/explosion10.gif", pl);
    
    
    int x = 0; // coordenada da nuvem 1
    int y = -1131; // coordenada da nuvem 2
    int vel = 0; // indicador de velocidade
    int calculaVel=nivel; // modifica o maximo de velocidade ao apertar UP e DOWN
    int nivelVariavel=nivel; //esse nivelVariavel mudara de acordo com as iteracoes
    
    int pontos = 0; //pontos do jogador, comecam com 0
    
    int velpc = -15; //velocidade das naves em relacao ao fundo, so para nao parecer q movimentam juntas ao fundo
       
    //draw_sprite(buffer,nuvemBuffer,0,0 );
    
    //int pausa=0;
    while (!key[KEY_ESC] && !FecharJogo && !sair) 
    {   
    rest(RESTFPSJOGO); //diminui o uso de CPU
    while (!key[KEY_ESC] && !sair && !FecharJogo && contFrames>0)
    {
        //Pausar jogo
        if (key[KEY_P])
        pausarJogoBatalha(&nave1.vida, &nave1.energia, &super1Cont); //pause ativado/desativado com P
        
        //acquire_bitmap(buffer);
        //clear(buffer);
        
        // DESENHA A NUVEM 
        draw_sprite(buffer,nuvemBuffer,0,0 );
        draw_sprite(buffer,nuvem,0,x );
        x+=vel/50;
        if (x >= 1131)
          x=-1131+(vel/50);
        draw_sprite(buffer,nuvem,0,y );
        y+=vel/50;
        if (y >= 1131)
          y=-1131+(vel/50);  
         
                         
        // DESENHA NAVE PC
        /*draw_sprite(buffer,navesPcImagem,navePc1.x,navePc1.y );
        navePc1.y+=(vel/50)+velpc;
        if(navePc1.y>=1000)
        {
               navePc1.y=-280;
               srand(time(NULL)); //gera numero aleatório toda hora que iniciado   
               random=rand()%4;
               navePc1.x=45+(random*140);
        }
        if(navePc1.y<=-2000)
               navePc1.y=-280;*/
               
        //DESENHA INIMIGOS NavesPc
        for (i=0;i<numeroInimigos;i++)
        {          
           if (navesPc[i].cacaNaTela==0 && navesPc[i].y==YINIMIGO)
           {
               srand(time(NULL)); //gera numero aleatório toda hora que iniciado   
               random=rand()%4;
               navesPc[i].x=xInimigos[random];
               navesPc[i].cacaNaTela=1;
           }
           
           //MOVIMENTO DOS INIMIGOS
           
           if (navesPc[i].y<0) //qndo a nave esta fora da tela ela desce na tela
              navesPc[i].y+=3;
           if (navesPc[i].cont>TEMPOINIMIGO) //se passou do tempo da nave ficar na tela ela vai embora
           {
              navesPc[i].y+=4;
              (navesPc[i].x>300) ? (navesPc[i].x+=3) : (navesPc[i].x-=3);
           }
           if (navesPc[i].y>600) //se a nave ultrapassou a tela
           {
              navesPc[i].cacaNaTela=0;
              navesPc[i].y+=3;
           }
           if (navesPc[i].y>600+400)
           {
              navesPc[i].cacaNaTela=1;
              navesPc[i].y=YINIMIGO;
              navesPc[i].vida=2;
              srand(time(NULL)); //o caca inimigo vai ficar num tempo indeterminado na tela, sendo no maximo 1000 iteracoes
              random=rand()%300;
              navesPc[i].cont=random;
              srand(time(NULL));
              random=rand()%4;
              navesPc[i].x=xInimigos[random];
           }
           else
           if (navesPc[i].cacaNaTela==0 && navesPc[i].y<=600)
           {
               navesPc[i].y=601;
           }
           
           //para as naves nao aparecerem na parte direita da tela
           if (navesPc[i].x<36 && navesPc[i].cont<TEMPOINIMIGO && (navesPc[i].cacaNaTela==0 || navesPc[i].y>600))
           {
              srand(time(NULL));
              random=rand()%4;
              navesPc[i].x=xInimigos[random];
           }
           else
           if (navesPc[i].x>476 && navesPc[i].cont<TEMPOINIMIGO && (navesPc[i].cacaNaTela==0 || navesPc[i].y>600))
           {
              srand(time(NULL));
              random=rand()%4;
              navesPc[i].x=xInimigos[random];
           }
              
           
           //desvia tiros AI
           if (tiros1[0].x>=navesPc[i].x-3 && tiros1[0].x<navesPc[i].x+75+3 && tiros1[0].y<300) //tem tiro na direcao do caça
           {
              //desviando=1;
              navesPc[i].desviando=1;
              if (tiro1Cont>2) //se tiver mais de dois tiros do jogador na tela
              {
                 if (tiros1[1].x>=navesPc[i].x-120 && tiros1[1].x<navesPc[i].x+34)
                 {
                    if (navesPc[i].x<600-5)
                       navesPc[i].x+=2;
                 }
                 else
                 if (tiros1[1].x>=navesPc[i].x+34 && tiros1[1].x<navesPc[i].x+75+75+1)
                 {
                    if (navesPc[i].x>0+5)
                       navesPc[i].x-=2;
                 }
              }
              else
              {
                  if (tiros1[0].x>=navesPc[i].x-LARGURATIRO && tiros1[0].x<navesPc[i].x+34)
                      navesPc[i].x+=2;
                  else
                  if (tiros1[0].x>=navesPc[i].x+34 && tiros1[0].x<navesPc[i].x+75+(2*LARGURATIRO))
                      navesPc[i].x-=2;
              }
           }
           else
               navesPc[i].desviando=0;
           
           //Inimigo desvia misseis
           for (j=0;j<abs(super1Cont-5);j++)   
           {        
               int desvia=1;
               srand(time(NULL));
               desvia=rand()%2;
               if (desvia)
               {
               if (super1[j].x+LARGURASUPER>=navesPc[i].x-1 && super1[j].x<navesPc[i].x+76) //tem missel na direcao do caça
               {
                  navesPc[i].desviando=1;
                  
                  if (abs(super1Cont-5)<6)
                  {
                      if (super1[j].x+LARGURASUPER>=navesPc[i].x && super1[j].x<navesPc[i].x+34)
                      {
                          navesPc[i].x+=2;
                      }
                      else
                      if (super1[j].x>=navesPc[i].x+34 && super1[j].x<navesPc[i].x+75+1)
                      {
                          navesPc[i].x-=2;
                      }
                  }
               }
               }
               else
                   navesPc[i].desviando=0;
           }
           
           if (tiro1Ativado)
           if (!navesPc[i].naopersegue && navesPc[i].cont<TEMPOINIMIGO)
           {
               if (!navesPc[i].desviando && navesPc[i].x-2!=tiros1[0].x && navesPc[i].x+76+2!=tiros1[0].x)
               if (navesPc[i].y>=0)
               {
                   if (navesPc[i].x<nave1.x-esq+dir)
                   {
                      navesPc[i].x+=2;
                   }
                   else
                   if (navesPc[i].x>nave1.x-esq+dir)
                   {
                      navesPc[i].x-=2;
                   }
               }
           }
           else
           if (navesPc[i].naopersegue==1 || navesPc[i].naopersegue==2)
           {
           if (!navesPc[i].desviando && navesPc[i].x-2!=tiros1[0].x && navesPc[i].x+76+2!=tiros1[0].x)
           {
               if (navesPc[i].naopersegue==1)
               {
                  navesPc[i].x+=2;
                  if (navesPc[i].x>600-75-9)
                      navesPc[i].naopersegue=2;
               }
               else
               if (navesPc[i].naopersegue==2)
               {
                  navesPc[i].x-=2;
                  if (navesPc[i].x<9)
                     navesPc[i].naopersegue=1;
               }
           }
           }
           else
           if (navesPc[i].naopersegue==4) //segue mais ou memos
           if (!navesPc[i].desviando && navesPc[i].x-2!=tiros1[0].x && navesPc[i].x+76+2!=tiros1[0].x)
           {
              if (navesPc[i].y>=0)
               {
                   int sorteio;
                   srand(time(NULL));
                   sorteio=(rand()%70)+70;
                   
                   if (navesPc[i].x<nave1.x-esq+dir-sorteio && navesPc[i].x<nave1.x-esq+dir+75)
                   {
                      navesPc[i].x+=2;
                   }
                   else
                   if (navesPc[i].x>nave1.x-esq+dir+sorteio && navesPc[i].x>nave1.x-esq+dir+75)
                   {
                      navesPc[i].x-=2;
                   }
               }
           }
           
           //movimento qndo nao estou atirando
           if (!tiro1Ativado)
           if (!navesPc[i].naopersegue && navesPc[i].cont<TEMPOINIMIGO)
           {
               if (!navesPc[i].desviando && navesPc[i].x-LARGURASUPER!=super1[0].x && navesPc[i].x+76+2!=super1[0].x)
               if (navesPc[i].y>=0)
               {
                   if (navesPc[i].x<nave1.x-esq+dir)
                   {
                      navesPc[i].x+=2;
                   }
                   else
                   if (navesPc[i].x>nave1.x-esq+dir)
                   {
                      navesPc[i].x-=2;
                   }
               }
           }
           else
           if (navesPc[i].naopersegue==1 || navesPc[i].naopersegue==2)
           {
           if (!navesPc[i].desviando && navesPc[i].x-2!=tiros1[0].x && navesPc[i].x+76+2!=tiros1[0].x)
           {
               if (navesPc[i].naopersegue==1 && navesPc[i].y>=0) //vai para a direita
               {
                  navesPc[i].x+=2;
                  if (navesPc[i].x>600-75-9)
                      navesPc[i].naopersegue=2;
               }
               else
               if (navesPc[i].naopersegue==2 && navesPc[i].y>=0) //vai para a esquerda
               {
                  navesPc[i].x-=2;
                  if (navesPc[i].x<9)
                     navesPc[i].naopersegue=1;
               }
           }
           }
           else
           if (navesPc[i].naopersegue==4) //segue mais ou memos
           if (!navesPc[i].desviando && navesPc[i].x-2!=tiros1[0].x && navesPc[i].x+76+2!=tiros1[0].x)
           {
              if (navesPc[i].y>=0)
               {
                   int sorteio;
                   srand(time(NULL));
                   sorteio=(rand()%70)+70;
                   
                   if (navesPc[i].x<nave1.x-esq+dir-sorteio && navesPc[i].x<nave1.x-esq+dir)
                   {
                      navesPc[i].x+=2;
                   }
                   else
                   if (navesPc[i].x>nave1.x-esq+dir+sorteio && navesPc[i].x>nave1.x-esq+dir+75)
                   {
                      navesPc[i].x-=2;
                   }
               }
           }
           

           //desviando=0; //zera desviando
           navesPc[i].cont++; //contador para o tempo em q os inimigos ficam na tela
           
           if (navesPc[i].x%2!=0) //navesPc[i].x sempre sera par, so para garantir
              navesPc[i].x+=1;
           
           //FIM MOVIMENTO DOS INIMIGOS
           
           //Vida dos inimigos
           if (navesPc[i].vida>0)
           {
               draw_sprite(buffer,navesPcImagem,navesPc[i].x,navesPc[i].y);
               rectfill(buffer, navesPc[i].x+5, navesPc[i].y+90, navesPc[i].x+5+1, navesPc[i].y+90+5, makecol(200, 200, 0));
               if (navesPc[i].vida==2)
                  rectfill(buffer, navesPc[i].x+5+3, navesPc[i].y+90, navesPc[i].x+5+4, navesPc[i].y+90+5, makecol(200, 200, 0));
           }
        } //do if q desenha e movimenta os inimigos 
     
        // DESENHA MENU LATERAL
        rectfill(buffer, 603, 0, 800, 600, makecol(100, 100, 100));      
        line(buffer, 598,0, 598,600, makecol(100,150,100 ));
        line(buffer, 599,0, 599,600, makecol(100,200,100 ));
        line(buffer, 600,0, 600,600, makecol(100,255,100 ));
        line(buffer, 601,0, 601,600, makecol(100,200,100 ));
        line(buffer, 602,0, 602,600, makecol(100,150,100 ));
        draw_sprite(buffer,logo,610,5 );
        line(buffer, 601,40, 800,40, makecol(100,150,100 ));
        line(buffer, 601,41, 800,41, makecol(100,255,100 ));
        line(buffer, 601,42, 800,42, makecol(100,150,100 ));
        draw_sprite(buffer,itens,625,50 ); 

        //DESENHA VELOCIMETRO
        //VELOCIMETRO
        /*if (vel%100==0) //pra nao ficar numa velocidade constante, por exemplo, 300
            textprintf_ex(buffer, font1, 720, 240, makecol(230,230,0), -1, "%d",vel+rand()%20);
        else*/
            textprintf_ex(buffer, font1, 720, 240, makecol(230,230,0), -1, "%d",vel);
        
        //---------------------------PONTOS--------------------------------
        textprintf_ex(buffer, font1, 660, 80, makecol(230,230,0), -1, "%d",pontos);
        
        //Vida e Energia
        textprintf_ex(buffer, font1, 660, 127, makecol(230,230,0), -1, "%d",nave1.vida+1);
        //textprintf_ex(buffer, font1, 690, 520, makecol(0,255,0), -1, "%d",nave1.energia);
        
        //Energia Nave 1
        draw_sprite(buffer,naveEnergia[abs(nave1.energia-MAXENERGIA)],630,460); //MAXENERGIA = 4
        
        //Especiais
        //textout_ex(buffer, font1, "Especiais", 650, 240, makecol(255, 255, 0), -1);
        //textprintf_ex(buffer, font1, 680, 185, makecol(255,255,0), -1, "%d",super1Cont);
        int contMissel;
        for (contMissel=0;contMissel<super1Cont;contMissel++)
            draw_sprite(buffer, missel, 680+(contMissel)*15, 180);
        
        //Throttle
        draw_sprite(buffer,throttleBase,620,150 );
        draw_sprite(buffer,throttle,620-15,150+142-25-(calculaVel/10));
        
        // Movimento e limites laterais do caça 
       if (vel>1)
       {              	
      		if (key[KEY_LEFT])
               if (nave1.x - esq + dir >= 20)
               {
                     esq += 4;
                     draw_sprite(buffer,nave1.imagemEsq,nave1.x - esq + dir - 9,nave1.y - cima + baixo );
                     //colide = check_pmask_collision(&nave1.maskEsq, &navePc1.mask, nave1.x - esq + dir, nave1.y, navePc1.x, navePc1.y);
               }
               else
               {
                   draw_sprite(buffer,nave1.imagem,nave1.x - esq + dir,nave1.y - cima + baixo );  
                   //colide = check_pmask_collision(&nave1.mask, &navePc1.mask, nave1.x - esq + dir, nave1.y, navePc1.x, navePc1.y);
               }
            else          
            if (key[KEY_RIGHT])
               if (nave1.x - esq + dir <= 500)
               {
                   dir += 4;
                   draw_sprite(buffer,nave1.imagemDir,nave1.x - esq + dir + 5,nave1.y - cima + baixo );
                   //colide = check_pmask_collision(&nave1.maskDir, &navePc1.mask, nave1.x - esq + dir, nave1.y, navePc1.x, navePc1.y);
               }
               else
               {
                   draw_sprite(buffer,nave1.imagem,nave1.x - esq + dir,nave1.y - cima + baixo );
                   //colide = check_pmask_collision(&nave1.mask, &navePc1.mask, nave1.x - esq + dir, nave1.y, navePc1.x, navePc1.y);
               }
            else
            if (!key[KEY_RIGHT] && !key[KEY_LEFT])
            {
                draw_sprite(buffer,nave1.imagem,nave1.x - esq + dir,nave1.y - cima + baixo );
                //colide = check_pmask_collision(&nave1.mask, &navePc1.mask, nave1.x - esq + dir, nave1.y, navePc1.x, navePc1.y);
                /*int cont;
                for (cont=0;cont<15;cont++)
                    draw_sprite(screen,naveanimada[cont],nave[0].x - esq + dir,nave[0].y - cima + baixo );*/
            }
       }
       else
       {
          draw_sprite(buffer,nave1.imagem,nave1.x - esq + dir,nave1.y - cima + baixo );
          //colide = check_pmask_collision(&nave1.mask, &navePc1.mask, nave1.x - esq + dir, nave1.y, navePc1.x, navePc1.y);
       }
    
        /*if (key[KEY_UP])
               if (nave[0].y - cima + baixo != 0)           
   		          cima += 10; 
        if (key[KEY_DOWN])
               if (nave[0].y - cima + baixo != 450)  
      		      baixo += 10;*/
      		      
        //aumenta velocidade com a tecla espaco
        if (nivelVariavel>calculaVel) //se o nivel q estiver for menor q a velocidade minima a velocidade minima eh aumentada
           calculaVel=nivelVariavel;
        if (key[KEY_UP])
        {
           if (calculaVel<1100) //calculaVel é o limite da velocidade
              calculaVel+=100;
           key[KEY_UP]=0;
        }
        else
        if (key[KEY_DOWN])
        {
           if (calculaVel>nivelVariavel)
           if (calculaVel>=100)        
              calculaVel-=100;
           key[KEY_DOWN]=0;
        }
        if (vel<calculaVel)
           vel+=1;
        else
        if (vel>calculaVel)
           vel-=1;
           
        //INIMIGO ATIRA, TIROS DOS INIMIGOS
        int tiroInimigoColide;
        for (i=0;i<numeroInimigos;i++)
        {
           tiroInimigoColide=0;
           int dentroDaTela=(navesPc[i].x>0 && navesPc[i].x<550);
           if (navesPc[i].y>=0 && navesPc[i].cacaNaTela && dentroDaTela)
           {
              if (navesPc[i].tiro.tempoTiro%100==0)
              {
                  
                  int atirou=0;
                  j=0;
                  while (j<navesPc[i].tiro.tiroCont+1 && !atirou)
                  {
                     if (navesPc[i].tiro.y[j]>=600)
                     {
                        navesPc[i].tiro.x[j]=navesPc[i].x+38;
                        //navesPc[i].tiro.y[j]=navesPc[i].y+119; para os cacas inimigos
                        navesPc[i].tiro.y[j]=navesPc[i].y+90;
                        atirou=1;
                        if (navesPc[i].tiro.tiroCont<MAXTIROSINIMIGOS-1)
                           navesPc[i].tiro.tiroCont++;
                        play_sample(somLazer,volume,90,1000,0);
                     }
                     j++;
                  }
              }
            
            }
            navesPc[i].tiro.tempoTiro++;
            
           int xTiro, yTiro;
           for (j=0;j<navesPc[i].tiro.tiroCont;j++)
           {
              //int valor;
              if (navesPc[i].tiro.y[j]<=600)
                 draw_sprite(buffer,tiro,navesPc[i].tiro.x[j]-LARGURATIRO,navesPc[i].tiro.y[j]-TAMANHOTIRO);
              //int valor=(nivelVariavel/100)-2; //a cada tempo nivelVariavel vai aumentar em 100, nivelVariavel eh o minimo de velocidade
              int valor=(vel/160); //a cada tempo nivelVariavel vai aumentar em 100, nivelVariavel eh o minimo de velocidade
              navesPc[i].tiro.y[j]+=(valor<2) ? 2 : valor; // TAMANHOTIRO/5;              
           
            xTiro=navesPc[i].tiro.x[j]-LARGURATIRO;
            yTiro=navesPc[i].tiro.y[j]-TAMANHOTIRO;
            tiroInimigoColide=check_pmask_collision(&tiroMask, &nave1.mask, xTiro, yTiro, nave1.x - esq + dir, nave1.y);
            if (tiroInimigoColide)
            {
                for (explosaoCont=0;explosaoCont<9;explosaoCont++)
                {
                    draw_sprite(screen, explosion[explosaoCont], xTiro-30, yTiro-TAMANHOTIRO);
                    if (explosaoCont%3==0)
                       rest(1);
                }
                
                if (nave1.vida>=0 && nave1.energia>0)
                   nave1.energia-=1;
                if (nave1.energia==0)
                {
                   if (nave1.vida>0)
                   {
                      nave1.energia=MAXENERGIA;
                      nave1.vida-=1;
                   }
                   else
                   {
                      /*nave1.energia=MAXENERGIA;
                      nave1.vida=MAXVIDA;*/
                      fimDoBatalha(pontos, nivel);
                      sair=1;
                      break;
                   }
                }
                navesPc[i].tiro.x[j]=700; //valor "nulo"
                navesPc[i].tiro.y[j]=700;
                /*if (navesPc[i].tiro.tiroCont>0)
                   navesPc[i].tiro.tiroCont--;*/
            }
           }
        }

        //Atirar
        if (key[KEY_W] || key[KEY_SPACE]) //atira com A ou Space
        {
           if (!naoAtira)
           {
           key[KEY_SPACE]=0;
           key[KEY_W]=0;
             if (tiro1Cont<=MAXTIROS) //5 sera o maximo de tiros
             {
                if (tiros1[tiro1Cont-2].y+TAMANHOTIRO+10<nave1.y - cima + baixo) //so vai atirar se o tiro nao estiver em cima do anterior
                {
                    if (!key[KEY_LEFT] && !key[KEY_RIGHT])
                    {
                        tiros1[tiro1Cont-1].x=38+nave1.x - esq + dir; //50
                        tiros1[tiro1Cont-1].y=5+nave1.y - cima + baixo;
                    }
                    else
                    if (key[KEY_LEFT])
                    {
                        tiros1[tiro1Cont-1].x=32+nave1.x - esq + dir;
                        tiros1[tiro1Cont-1].y=11+nave1.y - cima + baixo;
                    }
                    else
                    if (key[KEY_RIGHT])
                    {
                        tiros1[tiro1Cont-1].x=40+nave1.x - esq + dir;
                        tiros1[tiro1Cont-1].y=8+nave1.y - cima + baixo;
                    }
                    tiro1Ativado=1;
                    tiro1Cont+=1;
                    
                    play_sample(somTiro,volume,90,1000,0);
                    //stop_sample(somTiro);
                }

             }
           }
        }
        if (tiro1Ativado)
        {
           for (i=0; i<tiro1Cont;i++)
           {
              //tiroColide=check_pmask_collision(&tiroMask, &navePc1.mask, tiros1[i].x-LARGURATIRO, tiros1[i].y-TAMANHOTIRO, navePc1.x, navePc1.y);
              
              if (tiroColide)
              {
                  for (explosaoCont=0;explosaoCont<9;explosaoCont++)
                  {
                      draw_sprite(screen, explosion[explosaoCont], tiros1[i].x-LARGURATIRO-30, tiros1[i].y-TAMANHOTIRO-TAMANHOTIRO);
                      if (explosaoCont%3==0)
                         rest(1);
                  }
                  tiros1[i].x=-100; //deixando o tiro invalido caso acerte o inimigo
                  tiros1[i].y=-100;
                  tiroColide=0;
                  //allegro_message("rodou");
              }
              //TESTA COLISAO NOS INIMIGOS
              for (j=0;j<numeroInimigos;j++)
              {
                 inimigoColide[j] = check_pmask_collision(&tiroMask, &navesPcMask, tiros1[i].x-LARGURATIRO, tiros1[i].y-TAMANHOTIRO, navesPc[j].x, navesPc[j].y);
                 if (inimigoColide[j] && navesPc[j].vida>0)
                 {
                      for (explosaoCont=0;explosaoCont<9;explosaoCont++)
                      {
                          draw_sprite(screen, explosion[explosaoCont], tiros1[i].x-LARGURATIRO-30, tiros1[i].y-TAMANHOTIRO-TAMANHOTIRO);
                          if (explosaoCont%3==0)
                             rest(1);
                      }
                      tiros1[i].x=-100; //deixando o tiro invalido caso acerte o inimigo
                      tiros1[i].y=-100;
                      inimigoColide[j]=0;
                      navesPc[j].vida-=1;
                      if (navesPc[j].vida==0)
                      {
                         navesPc[j].cacaNaTela=0;
                         pontos+=50;
                      }
                 }
              }
              
           }
           atiraBatalha(buffer, tiro, tiros1, &tiro1Cont , &tiro1Ativado);
        }
        municaoBatalha(buffer, &naoAtira, &naoAtiraCont, &tiro1Cont);
        
        //Especial
        //ganha missel
        if (contIteracoesBatalha%200==0 && (super1Cont<4 || (super1[0].y<0-TAMANHOSUPER && super1[0].y>600)))
           super1Cont++;
        
        //usa-se Q e E cada tecla para um lado do aviao
        if (super1Cont>0) //se tiver misseis o super1Ativado=1
           super1Ativado=1;
           
        if (super1Ativado)
        {
            if (key[KEY_Q] || key[KEY_E])
            {
                int valido=0;
                if (super1Cont)
                {
                    if (super1Cont==MAXSUPER)
                       valido=1;
                    else
                    if (super1[abs(super1Cont-5)-1].y+TAMANHOSUPER<nave1.y - cima + baixo)
                       valido=1;
                }
                if (valido)
                {
                    if (key[KEY_Q])
                    {
                       if (!key[KEY_LEFT] && !key[KEY_RIGHT])
                          super1[abs(super1Cont-5)].x=-2+nave1.x - esq + dir;
                       if (key[KEY_LEFT])
                          super1[abs(super1Cont-5)].x=-7+nave1.x - esq + dir;
                       if (key[KEY_RIGHT])
                          super1[abs(super1Cont-5)].x=3+nave1.x - esq + dir;
                    }
                    else
                    if (key[KEY_E]) //o missel vai aparecer no lado direito
                    {
                       if (!key[KEY_LEFT] && !key[KEY_RIGHT])
                          super1[abs(super1Cont-5)].x=18+52+nave1.x - esq + dir; //40+52+
                       if (key[KEY_LEFT])
                          super1[abs(super1Cont-5)].x=-10+18+52+nave1.x - esq + dir;
                       if (key[KEY_RIGHT])
                          super1[abs(super1Cont-5)].x=2+18+52+nave1.x - esq + dir;
                    }
                    super1[abs(super1Cont-5)].y=68+nave1.y - cima + baixo;
                    if (super1Cont>=1)
                       super1Cont-=1; //diminui o numero de tiros
                    if (super1Cont<0)
                       super1Cont=0;
                    
                    play_sample(somMissel,volume,90,1000,0);
                    //stop_sample(somMissel);
                }
                key[KEY_Q]=0;
                key[KEY_E]=0;
            }
           for (i=0; i<abs(super1Cont-5);i++)
           {
              //superColide=check_pmask_collision(&misselMask, &navePc1.mask, super1[i].x, super1[i].y, navePc1.x, navePc1.y);
              if (superColide)
              {
                  for (explosaoCont=0;explosaoCont<9;explosaoCont++)
                  {
                      draw_sprite(screen, explosion[explosaoCont], super1[i].x-30, super1[i].y-15);
                      if (explosaoCont%3==0)
                         rest(1);
                  }
                  super1[i].x=-100; //deixando o tiro invalido caso acerte o inimigo
                  super1[i].y=-100;
                  superColide=0;
                  //allegro_message("rodou super");
              }
           
              //TESTA COLISAO NOS INIMIGOS
              for (j=0;j<numeroInimigos;j++)
              {
                 inimigoColide[j] = check_pmask_collision(&misselMask, &navesPcMask, super1[i].x, super1[i].y, navesPc[j].x, navesPc[j].y);
                 if (inimigoColide[j] && navesPc[j].vida>0)
                 {
                      for (explosaoCont=0;explosaoCont<9;explosaoCont++)
                      {
                          draw_sprite(screen, explosion[explosaoCont], super1[i].x-30, super1[i].y-15);
                          if (explosaoCont%3==0)
                             rest(1);
                      }
                      super1[i].x=-100; //deixando o tiro invalido caso acerte o inimigo
                      super1[i].y=-100;
                      inimigoColide[j]=0;
                      navesPc[j].vida=0;
                      if (navesPc[j].vida==0)
                      {
                         navesPc[j].cacaNaTela=0;
                         pontos+=50;
                      }
                 }
              }
           }
           superBatalha(buffer, missel, super1, &super1Cont, &super1Ativado);
        }
        
        //cheat para ganhar especial, sera tirado
        /*if (key[KEY_R])
        {
           super1Cont=5;
           key[KEY_R]=0;
        }*/
        
        if (vSync)
             vsync();
        //rest(1); //tire o rest

        //stop_sample(somTiro);
        //stop_sample(somMissel);
        
        //Aumenta o numero de inimigos de acordo com o nivel       
        switch (nivelVariavel)
        {
            case 300: numeroInimigos=1; break;
            case 500: numeroInimigos=2; break;
            case 700: numeroInimigos=3; break;
            case 900: numeroInimigos=4; break;
        }
        
        //nivelVariavel aumenta de acordo com as iteracoes
        if (contIteracoesBatalha%2000==0 && contIteracoesBatalha>0 && nivelVariavel<1000) //a cada 2000 iteracoes aumenta o nivel
           nivelVariavel+=100;
        
        //Aumenta as iteracoes
        contIteracoesBatalha+=1;
        
        //Se ficar lento apague esse IF
        /*if (contIteracoesBatalha%3==0)
           rest(1);*/
        //rest(2);
           
        
        acquire_bitmap(buffer2);
        clear(buffer2);
        draw_sprite(buffer2,buffer,0,0 );
           
        //pega o buffer
        if (exibirFPS)
           textprintf_ex(buffer2, font, 10, SCREEN_H - 20, makecol(230, 230, 230), -1, "FPS: %d - Tricks/s: %d", fps, fpsT);
        if (get_update_method())
        {
            buffer2 = get_buffer();
        }
        else
        {
            buffer2 = screen;
            if (vsync_is_enabled())
            {
                vsync();
            }
        }
        
        release_bitmap(buffer2);
        
        
        //Atualiza a tela
        //blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
        if (get_update_method())
        {
            update_screen();
        }
        else
        {
            // já está na tela
        }
        
        // Limpa o buffer 
        clear_bitmap(buffer2);
        clear_bitmap(buffer);
        
        //Conta os frames
        contFrames--;
        if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
        fpsC++;
        
    }//fim segundo while do jogo
        
    }//fim primeiro while do jogo
    
    /*if (get_update_method())
    {
        shutdown_screen_updating();
    }*/

    
    stop_sample(somTiro);
    stop_sample(somLazer);
    stop_sample(somMissel);
    
   destroy_bitmap(buffer);
   destroy_bitmap(nave1.imagem);
   destroy_bitmap(nave1.imagemEsq);
   destroy_bitmap(nave1.imagemDir);
   stop_sample(topgear);
   destroy_bitmap(logo);
   destroy_bitmap(itens);
   destroy_bitmap(nuvem);
   
   destroy_bitmap(nuvemBuffer);
   //destroy_bitmap(navePc1.imagem);
   //destroy_bitmap(navepc2);
   destroy_font(font1);
   
   deinit_pmask(&nave1.mask);
   deinit_pmask(&nave1.maskEsq);
   deinit_pmask(&nave1.maskDir);
   //deinit_pmask(&navePc1.mask);
   
   //free(tiros1); //desaloca a memoria de tiros1
}
void atiraBatalha(BITMAP *buffer, BITMAP *tiro, tiros tiros1[], int *tiroCont, int *tiro1Ativado)
{
   //#define TAMANHOTIRO 20 //TAMANHOTIRO = "altura" do tiro
   //#define LARGURATIRO 5 //LARGURATIRO = "largura" do tiro
   int i;
   for (i=0;i<*tiroCont-1;i++)
   {
      //rectfill(buffer,tiros1[i].x-LARGURATIRO,tiros1[i].y-TAMANHOTIRO,tiros1[i].x,tiros1[i].y,makecol(255,255,0));
      draw_sprite(buffer,tiro,tiros1[i].x-LARGURATIRO,tiros1[i].y-TAMANHOTIRO);
      tiros1[i].y-=TAMANHOTIRO/5;
      //tiros1[i].y-=TAMANHOTIRO;
      if (tiros1[i].y<0)
      {
         tiros1[i].y=tiros1[*tiroCont-2].y;
         tiros1[i].x=tiros1[*tiroCont-2].x;
         tiros1[*tiroCont-2].y=-100;
         tiros1[*tiroCont-2].x=-100;
         *tiroCont-=1;
      }
      /*if (*tiroCont==1)
      {
          *tiro1Ativado=0;
      }*/
      if (tiros1[i].y==tiros1[*tiroCont-1].y && *tiroCont==1)
        *tiro1Ativado=0;
   }
}

void superBatalha(BITMAP *buffer, BITMAP *missel, supers super[], int *superCont, int *superAtivado)
{
   //#define TAMANHOSUPER 27 //TAMANHOSUPER = "altura" da imagem do missel
   //#define LARGURASUPER 7 //LARGURASUPER = "largura" da imagem do missel
   int i;
   
   for (i=0;i<abs(*superCont-5);i++)
   {
      draw_sprite(buffer,missel,super[i].x,super[i].y);
      
      super[i].y-=TAMANHOSUPER/2;
      if (super[i].y<0)
      {
         super[i].y=-100; //zera o missel
         super[i].x=-100;
      }
      /*if (super[i].y<0)
      {
         super[i].y=super[*superCont-1].y;
         super[i].x=super[*superCont-1].x;
         //*superCont-=1;
      }*/
      if ((super[MAXSUPER].y<0 && super[i].y==super[*superCont-1].y) && *superCont==1)
        *superAtivado=0;
   }
}

void municaoBatalha(BITMAP *buffer, int *naoAtira, int *naoAtiraCont, int *tiroCont)
{
     //Numero de balas
    int municao=MAXTIROS;
    int x_municao=0, y_municao=0;
    int i;
    //if (!naoAtira)
    for (;municao>0;municao--,x_municao+=15)
    {
        rectfill(buffer,650+x_municao,560,660+x_municao,580,makecol(255,255,0));
        rectfill(buffer,652+x_municao,562,658+x_municao,578,makecol(200,200,0));
    }

    //municao=MAXTIROS-tiroCont+1;
    municao=*tiroCont-1;
    if (*tiroCont>1)
    if (!*naoAtira)
    for (x_municao=0;municao>0;municao--,x_municao+=15)
    {
        rectfill(buffer,652+x_municao,562,658+x_municao,578,makecol(200,200-((x_municao*3)+20),0)); //(x_municao+(abs(x_municao-(200/MAXTIROS))) ou x_municao+5
        if (x_municao>=15*(MAXTIROS-1)) //talvez tera q arrumar isso, tava >=
        {
           *naoAtira=1; //0 eh falso e qualquer outra valor verdadeiro
           *naoAtiraCont=1; //ativa o naoAtiraCont para q naoAtira possa aumentar ate MAXTIROS
        }
    }
    
    if (*naoAtira)
    {
       municao=MAXTIROS;
       for (x_municao=0;municao>0;municao--,x_municao+=15)
       {
          if (*naoAtira<=20 && *naoAtiraCont) //ate naoAtira = 12 ele vai imprimir em vermelho a municao
          {
             rectfill(buffer,650+x_municao,560,660+x_municao,580,makecol(255,255,0));
             rectfill(buffer,652+x_municao,562,658+x_municao,578,makecol(200,0,0));
          }
       }
    
       textout_ex(buffer,font,"Esquentou",650,545,makecol(200,0,0),-1); //favou mudar a palavra-frase
       
       if (*naoAtira==50) //50 iteracoes, mas como aumenta e diminui entao sao 100
          *naoAtiraCont=0; //agora o naoAtira vai diminuir ate 0
       
       //tenho q arrumar esses codigos, estao imensos
       //Mudam a cor de qndo esquenta a municao, vai diminuindo ate voltar a funcionar a municao
       if (*naoAtiraCont && (*naoAtira<20)) //MAXTIROS esta como 5, ver definicao dele la em cima
       {
          rectfill(buffer,652+(15*(MAXTIROS-1)),562,658+(15*(MAXTIROS-1)),578,makecol(200,0,0));
          for (i=2;i<MAXTIROS;i++) //2 a MAXTIROS-1
          {
              rectfill(buffer,652+(15*(MAXTIROS-i)),562,658+(15*(MAXTIROS-i)),578,makecol(200,(i-1)*(200/(MAXTIROS-1)),0));
          }
          rectfill(buffer,652+(15*(MAXTIROS-MAXTIROS)),562,658+(15*(MAXTIROS-MAXTIROS)),578,makecol(200,180,0));
       }
       else
       if (*naoAtiraCont && (*naoAtira>=20 && *naoAtira<40)) //MAXTIROS esta como 5, ver definicao dele la em cima
       {
          rectfill(buffer,652+(15*(MAXTIROS-1)),562,658+(15*(MAXTIROS-1)),578,makecol(200,200,0));
          for (i=2;i<MAXTIROS;i++)
          {
              rectfill(buffer,652+(15*(MAXTIROS-i)),562,658+(15*(MAXTIROS-i)),578,makecol(200,(i-1)*(200/(MAXTIROS-1)),0));
          }
          rectfill(buffer,652+(15*(MAXTIROS-5)),562,658+(15*(MAXTIROS-5)),578,makecol(200,180,0));
       }
       else
       if ((*naoAtiraCont && *naoAtira>=40) || (!*naoAtiraCont && *naoAtira>40)) //MAXTIROS esta como 5, ver definicao dele la em cima
       {
          rectfill(buffer,652+(15*(MAXTIROS-1)),562,658+(15*(MAXTIROS-1)),578,makecol(200,200,0));
          rectfill(buffer,652+(15*(MAXTIROS-2)),562,658+(15*(MAXTIROS-2)),578,makecol(200,200,0));
          for (i=3;i<MAXTIROS;i++)
          {
              rectfill(buffer,652+(15*(MAXTIROS-i)),562,658+(15*(MAXTIROS-i)),578,makecol(200,(i-1)*(200/(MAXTIROS-1)),0));
          }
          rectfill(buffer,652+(15*(MAXTIROS-5)),562,658+(15*(MAXTIROS-5)),578,makecol(200,180,0));
       }
       else
       if (!*naoAtiraCont && (*naoAtira<=40 && *naoAtira>20)) //MAXTIROS esta como 5, ver definicao dele la em cima
       {
          rectfill(buffer,652+(15*(MAXTIROS-1)),562,658+(15*(MAXTIROS-1)),578,makecol(200,200,0));
          rectfill(buffer,652+(15*(MAXTIROS-2)),562,658+(15*(MAXTIROS-2)),578,makecol(200,200,0));
          rectfill(buffer,652+(15*(MAXTIROS-3)),562,658+(15*(MAXTIROS-3)),578,makecol(200,200,0));
          for (i=4;i<MAXTIROS;i++)
          {
              rectfill(buffer,652+(15*(MAXTIROS-i)),562,658+(15*(MAXTIROS-i)),578,makecol(200,(i-1)*(200/(MAXTIROS-1)),0));
          }
          rectfill(buffer,652+(15*(MAXTIROS-5)),562,658+(15*(MAXTIROS-5)),578,makecol(200,180,0));
       }
       else
       if (!*naoAtiraCont && (*naoAtira<=20)) //MAXTIROS esta como 5, ver definicao dele la em cima
       {
          rectfill(buffer,652+(15*(MAXTIROS-1)),562,658+(15*(MAXTIROS-1)),578,makecol(200,200,0));
          rectfill(buffer,652+(15*(MAXTIROS-2)),562,658+(15*(MAXTIROS-2)),578,makecol(200,200,0));
          rectfill(buffer,652+(15*(MAXTIROS-3)),562,658+(15*(MAXTIROS-3)),578,makecol(200,200,0));
          rectfill(buffer,652+(15*(MAXTIROS-4)),562,658+(15*(MAXTIROS-4)),578,makecol(200,200,0));
          /*for (i=5;i<MAXTIROS;i++)
          {
              rectfill(buffer,652+(15*(MAXTIROS-i)),562,658+(15*(MAXTIROS-i)),578,makecol(200,(i-1)*(200/(MAXTIROS-1)),0));
          }*/
          rectfill(buffer,652+(15*(MAXTIROS-5)),562,658+(15*(MAXTIROS-5)),578,makecol(200,180,0));
       }
       
       
       if (*naoAtiraCont)
          *naoAtira+=1;
       else
           *naoAtira-=1;
    } //fim do if naoAtira
}

void pausarJogo(int *vidas)
{
     PALLETE pl;
     BITMAP *pausado = load_gif("img/pause.gif", pl);
     int pausa=0;
     
     if (key[KEY_P])
     {
       pausa=1;
       key[KEY_P]=0;
       int contVidasCheat = 0;
       while (pausa)
	   {
		rest(RESTFPS); //diminui o uso de CPU
		while (pausa && contFrames>0)
        {
		/*acquire_bitmap(buffer);
		clear(buffer);*/
		
         draw_sprite(screen,pausado,210,140 );
         if (key[KEY_P] || key[KEY_ESC]) //isso vai fazer sair do pause com P e ESC sendo q com ESC ele saira tbm do jogo pq nos nao desativamos o ESC
            pausa=0;
         if(key[KEY_V])
         {
            key[KEY_V] = 0;
            contVidasCheat+=1;
            if(contVidasCheat == 5)
            {
                  *vidas = 5; 
                  contVidasCheat=0;           
            }                  
         }   
       //pega o buffer
			/*if (exibirFPS)
			textprintf_ex(buffer, font, 10, SCREEN_H - 20, makecol(230, 230, 230), -1, "FPS: %d - Tricks/s: %d", fps, fpsT);
			if (get_update_method())
			{
				buffer = get_buffer();
			}
			else
			{
				buffer = screen;
				if (vsync_is_enabled())
				{
					vsync();
				}
			}

			release_bitmap(buffer);*/

			//Atualiza a tela
			//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
			/*if (get_update_method())
			{
				update_screen();
			}
			else
			{
				// já está na tela
			}*/
			//Conta os frames
			contFrames--;
			if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
            fpsC++;
		}
	}
	
	/*if (get_update_method())
    {
        shutdown_screen_updating();
    }*/
       key[KEY_P]=0;
     }
     destroy_bitmap(pausado);
}

void pausarJogoBatalha(int *vidas, int *energia, int *superCont)
{
     PALLETE pl;
     BITMAP *pausado = load_gif("img/pause.gif", pl);
     BITMAP *buffer = create_bitmap(SCREEN_H, SCREEN_W);
     int pausa=0;
     int contVidasCheat=0;
     int contEspecialCheat=0;
     
     if (key[KEY_P])
     {
     
       pausa=1;
       key[KEY_P]=0;
       while (pausa)
	   {
		rest(RESTFPS); //diminui o uso de CPU
		while (pausa && contFrames>0)
        {
		/*acquire_bitmap(buffer);
		clear(buffer);*/
		
         draw_sprite(screen,pausado,210,140 );
         if (key[KEY_P] || key[KEY_ESC]) //isso vai fazer sair do pause com P e ESC sendo q com ESC ele saira tbm do jogo pq nos nao desativamos o ESC
            pausa=0;
         if (key[KEY_V])
         {
            key[KEY_V]=0;
            contVidasCheat+=1;
            if (contVidasCheat==5)
            {
               *vidas=MAXVIDA;
               *energia=MAXENERGIA;
               contVidasCheat=0;
            }    
         }
         if (key[KEY_R])
         {
            key[KEY_R]=0;
            contEspecialCheat+=1;
            if (contEspecialCheat==5)
            {
               *superCont=MAXSUPER;
               contEspecialCheat=0;
            }    
         }
        //pega o buffer
			/*if (exibirFPS)
			textprintf_ex(buffer, font, 10, SCREEN_H - 20, makecol(230, 230, 230), -1, "FPS: %d - Tricks/s: %d", fps, fpsT);
			if (get_update_method())
			{
				buffer = get_buffer();
			}
			else
			{
				buffer = screen;
				if (vsync_is_enabled())
				{
					vsync();
				}
			}

			release_bitmap(buffer);*/

			//Atualiza a tela
			//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
			/*if (get_update_method())
			{
				update_screen();
			}
			else
			{
				// já está na tela
			}*/
			//Conta os frames
			contFrames--;
			if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
            fpsC++;
		}
	}
	
	/*if (get_update_method())
    {
        shutdown_screen_updating();
    }*/
       key[KEY_P]=0;
     }
     destroy_bitmap(pausado);
}
void niveisBatalha()
{
    contFrames=0; //zera o contador de frames
    
   int nivel, sair=0; //facil=0, medio=1, dificil=2
   int opy=100;
  int cor;
  SAMPLE *sonic = load_wav("wav/Sonic4.wav");
  play_sample(sonic,volume,90,1000,1);    
  SAMPLE *click = load_wav("wav/select.wav");
  BITMAP *fundoFacil = load_jpg("img/fundofacilbatalha.jpg", NULL);
  BITMAP *fundoMedio = load_jpg("img/fundomediobatalha.jpg", NULL);
  BITMAP *fundoDificil = load_jpg("img/fundodificilbatalha.jpg", NULL);
  BITMAP *hr = load_bitmap("img/hr.bmp", NULL);
  BITMAP *buffer = create_bitmap(SCREEN_W, SCREEN_H);
  
  while (!key[KEY_ESC] && !sair && !FecharJogo)
  {
  rest(RESTFPS); //diminui o uso de CPU
  while (!key[KEY_ESC] && !sair && !FecharJogo && contFrames>0)
  {
        
   	/*acquire_bitmap(buffer);
   	clear(buffer);*/
   	if (vSync)
       vsync();
    
    if (opy==100)
       draw_sprite(buffer,fundoFacil,0,0);  
    if (opy==290)
       draw_sprite(buffer,fundoMedio,0,0);  
    if (opy==480)
       draw_sprite(buffer,fundoDificil,0,0);                            
  
    line(buffer, 40,90, 800-40,90, CINZA);
    
    draw_sprite(buffer,hr,opy,145);
    
    if(keypressed())
    {
                 
		if(key[KEY_LEFT])
        {
           if(opy > 100)
           {
              play_sample(click,volume,90,1000,0);         
              opy -= 190; 
              rest(100); 
              stop_sample(click);                       
           }      
        }
        if(key[KEY_RIGHT])
        {
           if(opy<480)   
           {  
              play_sample(click,volume,90,1000,0); 
              opy += 190;
              rest(100);
              stop_sample(click);                            
           }
        }
                 
           // Apos apertar ENTER     
          if(key[KEY_ENTER])
          {
             if(opy == 100)
             {
                 // Executa o codigo de Facil  
                  
                 stop_sample(sonic);                            
                 jogarBatalha(300); //300 = calculavel = maximo de veocidade inicial
                 sair=1;          
             }
             else if(opy == 290)
             {
                // Executa o codigo de Medil
                
                stop_sample(sonic);
                jogarBatalha(500);
                sair=1;
             }
             else if(opy == 480)
             {
                // Executa o codigo de Dificil
                  
                stop_sample(sonic);            
                jogarBatalha(700);
                sair=1;                
             }           
          } 
          clear_keybuf();
        
		}
		//pega o buffer
		/*if (exibirFPS)
		textprintf_ex(buffer, font, 10, SCREEN_H - 20, makecol(230, 230, 230), -1, "FPS: %d - Tricks/s: %d", fps, fpsT);
		if (get_update_method())
		{
			buffer = get_buffer();
		}
		else
		{
			buffer = screen;
			if (vsync_is_enabled())
			{
				vsync();
			}
		}

		release_bitmap(buffer);

		//Atualiza a tela
		//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
		if (get_update_method())
		{
			update_screen();
		}
		else
		{
			// já está na tela
		}*/
		blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
		//Conta os frames
		contFrames--;
		if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
        fpsC++;
        if (sair)
           key[KEY_ESC]=1;
	}
	
	/*if (get_update_method())
    {
        shutdown_screen_updating();
    }*/
  
     
  }
    key[KEY_ENTER]=0;
    key[KEY_ESC]=0;
    stop_sample(sonic);   
    destroy_bitmap(fundoFacil);
    destroy_bitmap(fundoMedio);
    destroy_bitmap(fundoDificil);
    destroy_bitmap(buffer);
    destroy_bitmap(hr);
    
}

int abs(int x)
{
    if (x<0)
       return (-x);
    return x;
}


void bateu()
{
     PALLETE pl;
     BITMAP *pausado = load_gif("img/pause.gif", pl);
     int pausa=1;


     while (pausa)
	 {
		rest(RESTFPS); //diminui o uso de CPU
		while (pausa && contFrames>0)
		{
         draw_sprite(screen,pausado,210,140 );   
         if (key[KEY_ENTER]) //isso vai fazer sair do bateu
            pausa=0;
  
         if (exibirFPS)
			textprintf_ex(screen, font, 10, SCREEN_H - 20, makecol(230, 230, 230), -1, "FPS: %d - Tricks/s: %d", fps, fpsT);
         //Conta os frames
  	     contFrames--;
		 if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
         fpsC++;
		}
	}
       key[KEY_ENTER]=0;
     destroy_bitmap(pausado);
}
void fimdoclassico(int pontos,int nivel, int corCarro)
{ 
     //ranking e DadosRanking
     int tamanhoArquivo=0, escreveCont=1; //para escrever somente uma vez
     ranking recordDefault, novaPontuacao;
     FILE *recordFacil, *recordMedio, *recordDificil;
     int nivelbak=nivel;
      
     
     switch (nivel)
     {
        case 15:nivel=1;break; //facil
        case 20:nivel=2;break; //Medio
        case 25:nivel=3;break; //Dificil
     }     
     
     PALLETE pl;
     BITMAP *fundo = load_jpg("img/fimdoclassico.jpg", pl);
     BITMAP *hr = load_bitmap("img/hr.bmp", NULL);
     FONT *font1 = load_font("fonts/impact22.pcx", NULL, NULL);
     SAMPLE *click = load_wav("wav/select.wav");
     SAMPLE *sonic = load_wav("wav/Sonic4.wav");
     play_sample(sonic,volume,90,1000,1);
        
     BITMAP *buffer = create_bitmap(800, 600);

     char enter;
     char *nome;
     int tamanho=1, volta=1, i;
    
     nome=(char*)malloc(tamanho*sizeof(char));
     enter=0; //null
    
     int opy = 430;
     int opx = 45;
     int cont = 0;
     //x 45 y 430
     //x 100 y 498
     key[KEY_ESC] = 0 ;
     while(!key[KEY_ESC])
     {
      clear_keybuf();                   
      draw_sprite(screen,fundo,0,0 );  
      line(screen, 40,90, 800-40,90, CINZA);
      textprintf_ex(screen, font1, 165, 196, makecol(255,255,0), -1, "%d",pontos);                            
      
      //---------
      while (!key[KEY_ENTER] && cont == 0 ) //tecla enter enter!=13
      {
           
            enter=readkey();
            enter=toupper(enter); //converte a letra em maiuscula
            if (enter>=33 && enter<=126) //letras,numero e simbolos
            {
               //nome[tamanho-1]=enter;
               if (volta==1)
               {
                  nome[tamanho-1]=enter;
                  if (tamanho<=3)
                  {
                     tamanho++;
                     nome=realloc(nome,tamanho);
                  }
               }
               else
               {
                  nome[tamanho-volta]=enter;
                  volta-=1;
               }
            }
            else
            if (enter==8) //tecla backspace
            {
               if (tamanho-volta!=0)
               {
                  volta+=1;
                  nome=realloc(nome,tamanho-volta+1);
               }
            }
          if(key[KEY_ENTER] && tamanho-volta != 3 )
                    key[KEY_ENTER] = 0;  
          draw_sprite(screen,fundo,0,0 );  
          line(screen, 40,90, 800-40,90, CINZA);
          textprintf_ex(screen, font1, 165, 196, makecol(255,255,0), -1, "%d",pontos);
          
        //nome=realloc(nome,tamanho-volta+1);
        for(i=0;i<tamanho-volta;i++)
        {                                     
          textprintf_ex(screen, font1, 147+i*38, 135, makecol(255,255,0), -1, "%c",nome[i]); 
        }       
      } //while
      
      //Escreve no arquivo
      if (escreveCont)
      {
      switch (nivel)
      {
       case 1:
            recordFacil = fopen("Ranking/RecordsFacil.bin","r+b"); //abre o arquivo binario
            if(!recordFacil)
            {
               recordFacil = fopen("Ranking/RecordsFacil.bin","w+b"); //cria arquivo binario
            }
            novaPontuacao.pontos=pontos;
            novaPontuacao.nivel=nivel;
            novaPontuacao.nome[0]=nome[0];
            novaPontuacao.nome[1]=nome[1];
            novaPontuacao.nome[2]=nome[2];
            fseek(recordFacil, 0, SEEK_END);
            if (ftell(recordFacil)/sizeof(ranking)>MAXIMORANKING)
               fseek(recordFacil, (10)*sizeof(ranking), SEEK_SET); //posiciona na decima posicao
            fwrite(&novaPontuacao,sizeof(ranking),1,recordFacil); //escreve no arquivo
            fclose(recordFacil); //fecha arquivo
            break;
       case 2:
            recordMedio = fopen("Ranking/RecordsMedio.bin","r+b"); //abre o arquivo binario
            if(!recordMedio)
            {
               recordMedio = fopen("Ranking/RecordsMedio.bin","w+b"); 
            }
            novaPontuacao.pontos=pontos;
            novaPontuacao.nivel=nivel;
            novaPontuacao.nome[0]=nome[0];
            novaPontuacao.nome[1]=nome[1];
            novaPontuacao.nome[2]=nome[2];
            fseek(recordMedio, 0, SEEK_END);
            if (ftell(recordMedio)/sizeof(ranking)>MAXIMORANKING)
               fseek(recordMedio, (10)*sizeof(ranking), SEEK_SET); //posiciona na decima posicao
            fwrite(&novaPontuacao,sizeof(ranking),1,recordMedio); //escreve no arquivo
            fclose(recordMedio); //fecha arquivo
            break;
       case 3:
            recordDificil = fopen("Ranking/RecordsDificil.bin","r+b"); //abre o arquivo binario
            if(!recordDificil)
            {
               recordDificil = fopen("Ranking/RecordsDificil.bin","w+b"); 
            }
            novaPontuacao.pontos=pontos;
            novaPontuacao.nivel=nivel;
            novaPontuacao.nome[0]=nome[0];
            novaPontuacao.nome[1]=nome[1];
            novaPontuacao.nome[2]=nome[2];
            fseek(recordDificil, 0, SEEK_END);
            if (ftell(recordDificil)/sizeof(ranking)>MAXIMORANKING)
               fseek(recordDificil, (10)*sizeof(ranking), SEEK_SET); //posiciona na decima posicao
            fwrite(&novaPontuacao,sizeof(ranking),1,recordDificil); //escreve no arquivo
            fclose(recordDificil); //fecha arquivo
            break;  
       }
       escreveCont=0;
       }
      
      //---------
      key[KEY_ENTER] = 0 ;
      cont = 1;
      
      for(i=0;i<tamanho-volta;i++)
      {
          textprintf_ex(screen, font1, 147+i*38, 135, makecol(255,255,0), -1, "%c",nome[i]); 
      } 
                         
      draw_sprite(screen,hr,opx,opy);                   
      if(readkey())
        {
    		if(key[KEY_LEFT])
            {
               if(opy ==498)
               {
                  play_sample(click,volume,90,1000,0);         
                  opy = 430;
                  opx = 45; 
                  rest(100); 
                  stop_sample(click);                       
               }      
            }
            if(key[KEY_RIGHT])
            {
               if(opy==430)   
               {  
                  play_sample(click,volume,90,1000,0); 
                  opy = 498;
                  opx = 100;
                  rest(100);
                  stop_sample(click);                            
               }
            }
                     
               // Apos apertar ENTER     
              if(key[KEY_ENTER])
              {
                 if(opy == 430)
                 {
                     // Executa o codigo Sair  
                     key[KEY_ESC] = 1;         
                          
                 }
                 else if(opy == 498)
                 {
                    // Executa o codigo Repetir
                    stop_sample(sonic);  
                    jogar(nivelbak,corCarro);  
                    
                 }           
              } 
              clear_keybuf();
        }   
                         
     }
     key[KEY_ENTER]=0;
    stop_sample(sonic);
    free(nome);
    destroy_bitmap (buffer);    
    destroy_font(font1); 
    destroy_bitmap(fundo);
    destroy_bitmap(hr); 
    
    //fclose(record);
}

void fimDoBatalha(int pontos, int nivel)
{ 
     //ranking e DadosRanking
     int tamanhoArquivo=0, escreveCont=1; //para escrever somente uma vez
     ranking recordDefault, novaPontuacao;
     FILE *recordFacilBatalha, *recordMedioBatalha, *recordDificilBatalha;
     int nivelbak=nivel;
      
     
     switch (nivel)
     {
        case 300:nivel=1;break; //facil
        case 500:nivel=2;break; //Medio
        case 700:nivel=3;break; //Dificil
     }     
     
     PALLETE pl;
     BITMAP *fundo = load_jpg("img/fimdobatalha.jpg", pl);
     BITMAP *hr = load_bitmap("img/hr.bmp", NULL);
     FONT *font1 = load_font("fonts/impact22.pcx", NULL, NULL);
     SAMPLE *click = load_wav("wav/select.wav");
     SAMPLE *sonic = load_wav("wav/Sonic4.wav");
     play_sample(sonic,volume,90,1000,1);
        
     BITMAP *buffer = create_bitmap(800, 600);

     char enter;
     char *nome;
     int tamanho=1, volta=1, i;
    
     nome=(char*)malloc(tamanho*sizeof(char));
     enter=0; //null
    
     int opy = 430;
     int opx = 45;
     int cont = 0;
     //x 45 y 430
     //x 100 y 498
     key[KEY_ESC] = 0 ;
     while(!key[KEY_ESC])
     {
      clear_keybuf();                   
      draw_sprite(screen,fundo,0,0 );  
      line(screen, 40,90, 800-40,90, CINZA);
      textprintf_ex(screen, font1, 165, 196, makecol(255,255,0), -1, "%d",pontos);                            
      
      //---------
      while (!key[KEY_ENTER] && cont == 0 ) //tecla enter enter!=13
      {
           
            enter=readkey();
            enter=toupper(enter); //converte a letra em maiuscula
            if (enter>=33 && enter<=126) //letras,numero e simbolos
            {
               //nome[tamanho-1]=enter;
               if (volta==1)
               {
                  nome[tamanho-1]=enter;
                  if (tamanho<=3)
                  {
                     tamanho++;
                     nome=realloc(nome,tamanho);
                  }
               }
               else
               {
                  nome[tamanho-volta]=enter;
                  volta-=1;
               }
            }
            else
            if (enter==8) //tecla backspace
            {
               if (tamanho-volta!=0)
               {
                  volta+=1;
                  nome=realloc(nome,tamanho-volta+1);
               }
            }
          if(key[KEY_ENTER] && tamanho-volta != 3 )
                    key[KEY_ENTER] = 0;  
          draw_sprite(screen,fundo,0,0 );  
          line(screen, 40,90, 800-40,90, CINZA);
          textprintf_ex(screen, font1, 165, 196, makecol(255,255,0), -1, "%d",pontos);
          
        //nome=realloc(nome,tamanho-volta+1);
        for(i=0;i<tamanho-volta;i++)
        {                                     
          textprintf_ex(screen, font1, 147+i*38, 135, makecol(255,255,0), -1, "%c",nome[i]); 
        }       
      } //while
      
      //Escreve no arquivo
      if (escreveCont)
      {
      switch (nivel)
      {
       case 1:
            recordFacilBatalha = fopen("Ranking/RecordsFacilBatalha.bin","r+b"); //abre o arquivo binario
            if(!recordFacilBatalha)
            {
               recordFacilBatalha = fopen("Ranking/RecordsFacilBatalha.bin","w+b"); //cria arquivo binario
            }
            novaPontuacao.pontos=pontos;
            novaPontuacao.nivel=nivel;
            novaPontuacao.nome[0]=nome[0];
            novaPontuacao.nome[1]=nome[1];
            novaPontuacao.nome[2]=nome[2];
            fseek(recordFacilBatalha, 0, SEEK_END);
            if (ftell(recordFacilBatalha)/sizeof(ranking)>MAXIMORANKING)
               fseek(recordFacilBatalha, (10)*sizeof(ranking), SEEK_SET); //posiciona na decima posicao
            fwrite(&novaPontuacao,sizeof(ranking),1,recordFacilBatalha); //escreve no arquivo
            fclose(recordFacilBatalha); //fecha arquivo
            break;
       case 2:
            recordMedioBatalha = fopen("Ranking/RecordsMedioBatalha.bin","r+b"); //abre o arquivo binario
            if(!recordMedioBatalha)
            {
               recordMedioBatalha = fopen("Ranking/RecordsMedioBatalha.bin","w+b"); 
            }
            novaPontuacao.pontos=pontos;
            novaPontuacao.nivel=nivel;
            novaPontuacao.nome[0]=nome[0];
            novaPontuacao.nome[1]=nome[1];
            novaPontuacao.nome[2]=nome[2];
            fseek(recordMedioBatalha, 0, SEEK_END);
            if (ftell(recordMedioBatalha)/sizeof(ranking)>MAXIMORANKING)
               fseek(recordMedioBatalha, (10)*sizeof(ranking), SEEK_SET); //posiciona na decima posicao
            fwrite(&novaPontuacao,sizeof(ranking),1,recordMedioBatalha); //escreve no arquivo
            fclose(recordMedioBatalha); //fecha arquivo
            break;
       case 3:
            recordDificilBatalha = fopen("Ranking/RecordsDificilBatalha.bin","r+b"); //abre o arquivo binario
            if(!recordDificilBatalha)
            {
               recordDificilBatalha = fopen("Ranking/RecordsDificilBatalha.bin","w+b"); 
            }
            novaPontuacao.pontos=pontos;
            novaPontuacao.nivel=nivel;
            novaPontuacao.nome[0]=nome[0];
            novaPontuacao.nome[1]=nome[1];
            novaPontuacao.nome[2]=nome[2];
            fseek(recordDificilBatalha, 0, SEEK_END);
            if (ftell(recordDificilBatalha)/sizeof(ranking)>MAXIMORANKING)
               fseek(recordDificilBatalha, (10)*sizeof(ranking), SEEK_SET); //posiciona na decima posicao
            fwrite(&novaPontuacao,sizeof(ranking),1,recordDificilBatalha); //escreve no arquivo
            fclose(recordDificilBatalha); //fecha arquivo
            break;  
       }
       escreveCont=0;
       }
      
      //---------
      key[KEY_ENTER] = 0 ;
      cont = 1;
      
      for(i=0;i<tamanho-volta;i++)
      {
          textprintf_ex(screen, font1, 147+i*38, 135, makecol(255,255,0), -1, "%c",nome[i]); 
      } 
                         
      draw_sprite(screen,hr,opx,opy);                   
      if(readkey())
        {
    		if(key[KEY_LEFT])
            {
               if(opy ==498)
               {
                  play_sample(click,volume,90,1000,0);         
                  opy = 430;
                  opx = 45; 
                  rest(100); 
                  stop_sample(click);                       
               }      
            }
            if(key[KEY_RIGHT])
            {
               if(opy==430)   
               {  
                  play_sample(click,volume,90,1000,0); 
                  opy = 498;
                  opx = 100;
                  rest(100);
                  stop_sample(click);                            
               }
            }
                     
               // Apos apertar ENTER     
              if(key[KEY_ENTER])
              {
                 if(opy == 430)
                 {
                     // Executa o codigo Sair  
                     key[KEY_ESC] = 1;         
                          
                 }
                 else if(opy == 498)
                 {
                    // Executa o codigo Repetir
                    stop_sample(sonic);  
                    jogarBatalha(nivelbak);  
                    
                 }           
              } 
              clear_keybuf();
        }   
                         
     }
     key[KEY_ENTER] = 0 ;
    stop_sample(sonic);
    free(nome);
    destroy_bitmap (buffer);    
    destroy_font(font1); 
    destroy_bitmap(fundo);
    destroy_bitmap(hr); 
    
    //fclose(record);
}


void volumeop()
{
     contFrames=0; //zera o contador de frames
     
     BITMAP *buffer = create_bitmap(800,600);
     BITMAP *fundosom = load_bmp("img/som.bmp",NULL);
     FONT *font1 = load_font("fonts/impact.pcx", NULL, NULL);
     key[KEY_ENTER] = 0;
          
     while (!key[KEY_ENTER])
	 {
		rest(RESTFPS); //diminui o uso de CPU
		while (!key[KEY_ENTER] && contFrames>0)
		{
			//acquire_bitmap(buffer);
			clear(buffer);
     
     draw_sprite(buffer,fundosom,0,0 );
 
     textprintf_ex(buffer, font1,740, 10, makecol(255,255,255), -1, "ENTER");
     // IMPRIME VOLUME E BARRAS    
     textprintf_ex(buffer, font1, 390, 330, makecol(255,255,255), -1, "%0.0f%%",volume/(float)2.55);
          if ((key[KEY_DOWN] || key[KEY_LEFT]) && volume>0) // menos do teclado numerico e do teclado normal diminuem o volume
          {
             volume--;
             rest(10);
          }
          if ((key[KEY_UP] || key[KEY_RIGHT]) && volume<255) //mais do teclado numerico e igual do teclado normal aumentam o volume
          {
             volume++;
             rest(10);
          }
          
          if(volume > 0)
          {
             rectfill(buffer, 360, 315, 372, 322, makecol(100, 0, 0));       
             rectfill(buffer, 360, 315, 371, 321, makecol(150, 0, 0));       
             rectfill(buffer, 360, 315, 370, 320, makecol(255, 0, 0));
             
          }   
          if(volume >= 51)
          {
             rectfill(buffer, 375, 300, 387, 322, makecol(100, 0, 0));       
             rectfill(buffer, 375, 300, 386, 321, makecol(150, 0, 0));       
             rectfill(buffer, 375, 300, 385, 320, makecol(255, 0, 0));
          }   
          if(volume >= 102)
          {
             rectfill(buffer, 390, 285, 402, 322, makecol(100, 0, 0));       
             rectfill(buffer, 390, 285, 401, 321, makecol(150, 0, 0));       
             rectfill(buffer, 390, 285, 400, 320, makecol(255, 0, 0));
          }   
          if(volume >= 153)
          {
             rectfill(buffer, 405, 270, 417, 322, makecol(100, 0, 0));
             rectfill(buffer, 405, 270, 416, 321, makecol(150, 0, 0));
             rectfill(buffer, 405, 270, 415, 320, makecol(255, 0, 0));
          }   
          if(volume >= 204)
          {
             rectfill(buffer, 420, 255, 432, 322, makecol(100, 0, 0));
             rectfill(buffer, 420, 255, 431, 321, makecol(150, 0, 0));
             rectfill(buffer, 420, 255, 430, 320, makecol(255, 0, 0));
          }   
          if(volume >= 255)
          {
             rectfill(buffer, 435, 240, 447, 322, makecol(100, 0, 0));
             rectfill(buffer, 435, 240, 446, 321, makecol(150, 0, 0));
             rectfill(buffer, 435, 240, 445, 320, makecol(255, 0, 0));
          }
         
       blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);    
            //pega o buffer
			if (exibirFPS)
			textprintf_ex(buffer, font, 10, SCREEN_H - 20, makecol(230, 230, 230), -1, "FPS: %d - Tricks/s: %d", fps, fpsT);
			/*if (get_update_method())
			{
				buffer = get_buffer();
			}
			else
			{
				buffer = screen;
				if (vsync_is_enabled())
				{
					vsync();
				}
			}

			release_bitmap(buffer);

			//Atualiza a tela
			//blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);
			if (get_update_method())
			{
				update_screen();
			}
			else
			{
				// já está na tela
			}*/
			//Conta os frames
			contFrames--;
			if (fpsT>0) fps=fpsC,fpsC=0,fpsT=0;
            fpsC++;
		}
	}
	
	/*if (get_update_method())
    {
        shutdown_screen_updating();
    }*/

     
     key[KEY_ENTER] = 0;

     
     destroy_font(font1);
     destroy_bitmap(buffer);
     destroy_bitmap(fundosom); 
}

void ordenaArquivo(int codArquivo)
{
    //11 = classico facil, 12 = classico medio, 13 = classico dificil
    //21 = batalha facil, 22 = batalha medio, 23 = batalha dificil
    long int tamanhoArquivo=0;
    int criouArquivo=0;
    int i, j; //contadores
    ranking dados[11], auxDados; //armazena os dados do arquivo
    FILE *arquivo;

    switch (codArquivo)
    {
       //classico
       case 11:
            arquivo = fopen("Ranking/RecordsFacil.bin","r+b"); //rb le e grava, mas nao sobrescreve, r+b sobrescreve
            if(!arquivo)
            {
               arquivo = fopen("Ranking/RecordsFacil.bin","w+b");
               criouArquivo=1;
            }
            break;
       case 12:
            arquivo = fopen("Ranking/RecordsMedio.bin","r+b");
            if(!arquivo)
            {
               arquivo = fopen("Ranking/RecordsMedio.bin","w+b");
               criouArquivo=1;
            }
            break;
       case 13:
            arquivo = fopen("Ranking/RecordsDificil.bin","r+b");
            if(!arquivo)
            {
               arquivo = fopen("Ranking/RecordsDificil.bin","w+b");
               criouArquivo=1;
            }
            break;
       //batalha
       case 21:
            arquivo = fopen("Ranking/RecordsFacilBatalha.bin","r+b");
            if(!arquivo)
            {
               arquivo = fopen("Ranking/RecordsFacilBatalha.bin","w+b");
               criouArquivo=1;
            }
            break;
       case 22:
            arquivo = fopen("Ranking/RecordsMedioBatalha.bin","r+b");
            if(!arquivo)
            {
               arquivo = fopen("Ranking/RecordsMedioBatalha.bin","w+b");
               criouArquivo=1;
            }
            break;
       case 23:
            arquivo = fopen("Ranking/RecordsDificilBatalha.bin","r+b");
            if(!arquivo)
            {
               arquivo = fopen("Ranking/RecordsDificilBatalha.bin","w+b");
               criouArquivo=1;
            }
            break;
    }
    
    if (!criouArquivo)
    {
         fseek(arquivo, 0, SEEK_END); //posiciona no fim do arquivo
         tamanhoArquivo=ftell(arquivo)/sizeof(ranking); //tamanho do arquivo
         fseek(arquivo, 0, SEEK_SET); //posiciona no inicio do arquivo
         if (tamanhoArquivo>MAXIMORANKING)
            tamanhoArquivo=MAXIMORANKING+1;
    }
    
    fseek(arquivo, 0, SEEK_SET); //posiciona no inicio do arquivo
    for (i=0;i<tamanhoArquivo;i++)
    {
       fread(&dados[i],sizeof(ranking),1,arquivo); //joga os dados no vetor dados
    }

    //Ordenacao Bolha
    j=0; i=1;
    for (j=0;j<tamanhoArquivo-1;j++)
    {
       for (i=j+1;i<tamanhoArquivo;i++)
       if (dados[j].pontos<dados[i].pontos)
       {                          
           auxDados=dados[j];
           dados[j]=dados[i];
           dados[i]=auxDados;
       }
    }
    
    //reescrecendo o arquivo
    fseek(arquivo, 0, SEEK_SET); //posiciona no inicio do arquivo
    for (i=0;i<tamanhoArquivo;i++)
    {
        fwrite(&dados[i],sizeof(ranking),1,arquivo); //escreve no arquivo
    }
    
    fclose(arquivo);
}




