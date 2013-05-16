#include <allegro.h>
#include "snake.h"
#include "../allegro_iniciacao.h"
#include "../al_screen/al_screen.h"

#define DIVISAO 1

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

void telaInicial()
{
    BITMAP *buffer = create_bitmap(SCREEN_W, SCREEN_H);

    while(!key[KEY_ESC] && !key[KEY_ENTER] && !key[KEY_ENTER_PAD] && !FecharJogo)
    {
    rest(5); //diminui o uso de CPU
    while (!key[KEY_ESC] && !key[KEY_ENTER] && !key[KEY_ENTER_PAD] && !FecharJogo && contFrames>0)
    {
        int quartoX=(SCREEN_W/4), quartoY=(SCREEN_H/4);
        char frase1[]="Jogo feito por ARTHUR ASSUNCAO";
        char frase2[]="Feito em C++ e Allegro com a intencao de testar a utilizacao de Limitador de Frames por Segundo";
        char frase3[]="Criado durante uma aula de Linguagem de Programacao";
        char fim[]="Pressione Enter para Iniciar o Jogo";

        acquire_bitmap(buffer);
        clear(buffer);

        textout_ex(buffer,font,frase1,25, 50, makecol(200, 50, 0), -1);
        textout_ex(buffer,font,frase2,25, 100, makecol(200, 50, 0), -1);
        textout_ex(buffer,font,frase3,25, 150, makecol(200, 50, 0), -1);

        textout_ex(buffer,font,fim,quartoX-100, SCREEN_H-100, makecol(200, 50, 0), -1);

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
}

void ordenaSnake(snakeDados v[], int tamanho, int direcao)
{
    int i=0;
    for (i=tamanho-1;i>0;i--)
    {
        v[i]=v[i-1];
    }
}

int siBateu(snakeDados v[], int tamanho)
{
    int i=0;
    for (i=10;i<tamanho;i++)
    {
        if ((v[0].x<=v[i].x && v[0].x+TAMANHO>=v[i].x) && (v[0].y<=v[i].y && v[0].y+TAMANHO>=v[i].y))
            return 1;
    }
    return 0;
}
