#include <allegro.h>
#include <iostream>
#include "../allegro_iniciacao.h" //init e deinit
#include <time.h>
#include <alpng.h> //habilita o uso de png
#include <algif.h> //habilita o uso de gif
#include <jpgalleg.h> //habilita o uso de jpg
#include "../al_screen/al_screen.h" //atualizar a tela melhor
#include <malloc.h>
#include "snake.h"
#include "funcoes.h"

#define CINZA 190,190,190

//variaveis externas
extern volatile int FecharJogo;
extern unsigned int volume;
extern unsigned int vSync;
extern unsigned int exibirFPS;
extern int resolucaoX;
extern int resolucaoY;
//variaveis Countador de FPS
extern volatile int contFrames, contTempo; // Conta a quantidade de frames em cada segundo
//extern volatile int fps; // Armazena a taxa atual de Fps
extern short int fpsC,fpsT,fps;

int snake()
{
    PALLETE paleta;
	BITMAP *buffer = create_bitmap(resolucaoX, resolucaoY);
	BITMAP *fundo = create_bitmap(resolucaoX, resolucaoY);
	BITMAP *hud = create_bitmap(HUDX, HUDY);
	rectfill(fundo, 0, 0, 800, 600, makecol(0, 0, 0)); //fundo preto
	draw_sprite(buffer,fundo,0,0);
	//rectfill(hud, 0, 0, HUDX, HUDY, makecol(200, 200, 200)); //fundo preto
	int hudPontos[10] = {0,0,HUDX,0,HUDX,HUDY-20,HUDX-40,HUDY,0,HUDY}; //coloca os pontos no sentido horario
    polygon(hud, 10/2, hudPontos, makecol(255, 255, 0));

    int morreu=0;
	int direcao=1, tempDirecao; //0=cima, 1=direita, 2=baixo, 3=esquerda
	int velocidade=VELINICIAL, tamanho=1, random=0, comeu=0;
	int pontos=0;
	snakeDados *snake, bolinha;
	snake=(snakeDados*)malloc(tamanho*sizeof(snakeDados));
	bolinha.x=BOLINHANULA;
	snake[0].x=400-TAMANHO;
	snake[0].y=300-TAMANHO;
	snake[0].direcao=direcao;

    srand(time(NULL));
	while (!key[KEY_ESC] && !FecharJogo)
	{
		rest(5); //diminui o uso de CPU
		while (!key[KEY_ESC] && !FecharJogo && contFrames>0)
		{
		    int randomBol1, randomBol2;
			acquire_bitmap(buffer);
            clear(buffer);

            //se a bolinha nao esta na tela joga ela em algum lugar aleatorio
			if (bolinha.x==BOLINHANULA)
            {
                //srand(time(NULL));
                randomBol1=(rand()%(800-(TAMANHOBOL*2)))+TAMANHOBOL;
                //srand(time(NULL));
                randomBol2=(rand()%(600-(TAMANHOBOL*2)))+TAMANHOBOL;
                while (randomBol1<=HUDX && randomBol2<=HUDY)
                {
                    srand(time(NULL));
                    randomBol1=(rand()%(800-(TAMANHOBOL*2)))+TAMANHOBOL;
                    srand(time(NULL));
                    randomBol2=(rand()%(600-(TAMANHOBOL*2)))+TAMANHOBOL;
                }

                bolinha.x=randomBol1;
                bolinha.y=randomBol2;
            }

        /* COLOQUE O SEU CODIGO AQUI */

			//rectfill(buffer, x, y, x+TAMANHO, y+TAMANHO, makecol(100,100,100)); //quadrado na tela
			int i=0;
			for (i=1;i<tamanho;i++)
            {
                circlefill(buffer, snake[i].x, snake[i].y, TAMANHO, makecol(CINZA));
            }
            circlefill(buffer, snake[0].x, snake[0].y, TAMANHO, makecol(100+(snake[0].x%100),100+(snake[0].y%100),200));

            circlefill(buffer, bolinha.x, bolinha.y, TAMANHOBOL, makecol(100,100,100));

			if ((key[KEY_RIGHT] && (direcao!=3 || tamanho==1)) || direcao==1)
            {
                ordenaSnake(snake, tamanho, tempDirecao);
                snake[0].x+=velocidade;
                direcao=snake[0].direcao=1;
            }

            if ((key[KEY_LEFT] && (direcao!=1 || tamanho==1)) || direcao==3)
            {
                ordenaSnake(snake, tamanho, tempDirecao);
                snake[0].x-=velocidade;
                direcao=snake[0].direcao=3;
            }

            if ((key[KEY_DOWN] && (direcao!=0 || tamanho==1)) || direcao==2)
            {
                ordenaSnake(snake, tamanho, tempDirecao);
                snake[0].y+=velocidade;
                direcao=snake[0].direcao=2;
            }

            if ((key[KEY_UP] && (direcao!=2 || tamanho==1)) || direcao==0)
            {
                ordenaSnake(snake, tamanho, tempDirecao);
                snake[0].y-=velocidade;
                direcao=snake[0].direcao=0;
            }
            key[KEY_RIGHT]=key[KEY_LEFT]=key[KEY_DOWN]=key[KEY_UP]=0;

            //atravessa a tela
            if (snake[0].x>resolucaoX)
                snake[0].x=0;
            else
            if (snake[0].x<0)
                snake[0].x=resolucaoX;
            if (snake[0].y<0)
                snake[0].y=resolucaoY;
            else
            if (snake[0].y>resolucaoY)
                snake[0].y=0;

            if (siBateu(snake, tamanho))
            {
                morreu=1;
                key[KEY_ESC]=1; //so para sair
            }



            //COMEU HAHA

            if ((snake[0].x-TAMANHO<=bolinha.x && snake[0].x+TAMANHO>=bolinha.x))
            if ((snake[0].y-TAMANHO<=bolinha.y && snake[0].y+TAMANHO>=bolinha.y))
                comeu=1;

            if (comeu)
            {
                tamanho++;
                snake=(snakeDados*)realloc(snake,tamanho*sizeof(snakeDados));
                comeu=0;
                bolinha.x=BOLINHANULA;
                bolinha.y=BOLINHANULA;
                ordenaSnake(snake, tamanho, tempDirecao);
                (velocidade<10) ? (pontos+=5) : (pontos+=10);
                if (pontos%100==0)
                    velocidade++;
            }

            //Nao pode bater em si mesmo


            //Menu
            set_trans_blender(0,0,0,100);
            draw_trans_sprite(buffer, hud, 0, 0);
            set_trans_blender(0,0,0,0);
            textprintf_ex(buffer, font, 10, 10, makecol(230, 230, 230), -1, "Pontos: %d", pontos);
            textprintf_ex(buffer, font, 10, 25, makecol(230, 230, 230), -1, "Velocidade: %d", velocidade);

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

    if (!morreu || morreu) //depois eu mudo isso aqui
    {
        int quartoX=(resolucaoX/4), quartoY=(resolucaoY/4);
        clear(buffer);

        ellipsefill(fundo, quartoX*2, quartoY+100, 150, 100, makecol(100, 100, 200));
        set_trans_blender(0,0,0,150);
        draw_trans_sprite(buffer, fundo, 0, 0);
        set_trans_blender(0,0,0,0);

        textout_ex(buffer,font,"Criado por Arthur Assuncao",quartoX+100, quartoY+50, makecol(200, 50, 0), -1);
        textprintf_ex(buffer, font, quartoX+100, quartoY+100, makecol(230, 230, 230), -1, "Voce fez: %d pontos", pontos);
        blit(buffer, screen, 0,0,0,0, SCREEN_W, SCREEN_H);

        key[KEY_ESC]=key[KEY_ENTER]=key[KEY_ENTER_PAD]=0;
        while(!key[KEY_ESC] && !key[KEY_ENTER] && !key[KEY_ENTER_PAD])
        {
            rest(10);
        }
    }

	if (get_update_method())
    {
        shutdown_screen_updating();
    }

    free(snake);
    destroy_bitmap(fundo);
    destroy_bitmap(buffer);
    destroy_bitmap(hud);

    return 1;
}
