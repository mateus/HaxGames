program Nave_by_Arthur;

uses crt, dos;

const largura=50;
      altura=25;
      dist=1; {dist=distancia da parede ate a nave}

var x, y, x2, y2, xi, yi, xt, yt, xt2, yt2, xti, yti, xs, ys, xs2, ys2:integer; {x y= eu, xi yi= inimigo, xt yt= tiro}
	cor, corasa, cont, velocidade, inimigos_mortos, level:integer;
	l, i, j, k, m:integer;
	pontos1, vidas1, num_especial1:integer;
	pontos2, vidas2, num_especial2:integer;

	teclas, teclas2:char;
	teclas3, teclas4:char;
	morreu, inimigo_morreu1, inimigo_morreu2, nave1morreu, nave2morreu, cont2, multiplayer:boolean;
	tiro1,  tiro2, tiroinimigo1, especial1, especial2:boolean;     {tiro1= nave1, tiro2=nave2}
	xrandom, aux_xrandom:integer; {randon para o xi do inimigo}
	
	{hora, }min, seg, mili:integer;
	
	menu:char;
	TelaInicialaux:boolean;
	
	tecla:char;
	{op:char;} opcao:integer;
	Dia, Mes, Ano, Hora, Minuto, Segundo, Dec_Segundo, Dia_Semana : word;{ para ser usado no getDate}

     {TeclasDosUsuarios: file of string;}

{----------------- Procedimentos ------------------}


{Procedimentos do menu}
procedure mudacor;
begin
	textbackground(3);
	textcolor(15);
end;

procedure voltacor;
begin
	textcolor(lightgreen);
	textbackground(0);
end;
{fim procedimentos menu}

procedure TeclasUsadas;
begin
	{readln(TeclasUsuario.txt,1);
	assign(TeclasDosUsuarios,TeclasUsuarios.txt);}
	
	clrscr;
	gotoxy(10,1);
	writeln('Teclas');
	writeln;
	
	writeln('                Player 1');
	writeln;
	writeln('         A - Move para Esquerda');
	writeln('         D - Move para Direita');
	writeln('         H - Atira (e space)');
	writeln('         J - Especial');
	writeln('         O - Pause');
	writeln('         = - Sai do Jogo');
	
	writeln;
	writeln;
	
	writeln('                Player 2');
	writeln;
	writeln('         4 - Move para Esquerda');
	writeln('         6 - Move para Direita');
	writeln('         ~ - Atira');
	writeln('         ] - Especial');
	writeln('         9 - Pause');
	writeln('         Backspace - Sai do Jogo');
	writeln('         7 - Ativa o modo Multiplayer');
	
	writeln;
	writeln;
	writeln('Pressione alguma tecla parra voltar ao menu Principal');
	readln;
	
end;

procedure creditos;
begin
	clrscr;
	gotoxy(10,1);
	writeln('Creditos');
	writeln;
	writeln('Desenvolvimento by Arthur Assuncao');
	writeln;
	writeln('Agradecimento tambem ao Prof. Wender');
	writeln;
	
	writeln;
	writeln('Pressione alguma tecla para voltar ao menu Principal');
	readln;
end;

procedure fim;
begin
	clrscr;
	repeat
		textcolor(cor);
		gotoxy(20,5);
		writeln('Game Over');
		writeln;
		gotoxy(20,7);
		writeln('Pontuacao Nave 1 = ',pontos1);
		if multiplayer then
		begin
			gotoxy(20,9);
			writeln('Pontuacao Nave 2 = ',pontos2);
		end;
		randomize;
		cor:=random(15);
		corasa:=random(15);
		morreu:=true;
		delay(200);
		TelaInicialaux:=true;
	until keypressed;
	exit;
end;

procedure Historia;
begin
	clrscr;
	gotoxy(10,1);
	writeln('Historia');
	writeln;
	
	writeln('Em breve');
	
	writeln;
	writeln('Pressione alguma tecla para voltar ao menu Principal');
	readln;
end;

Procedure TelaInicial;
begin
	
repeat
    clrscr;
	x:=1;
	i:=0;
	j:=0;
	k:=1;
	m:=80;
	{repeat }
	{clrscr;}
	{======Titulo======}
	textcolor(lightgreen);
	for l:=1 to 80 do
		write('_');
	textcolor(lightred);
	gotoxy(20,2);
	writeln('Machine Space 1.0');
	voltacor;
	for l:=1 to 80 do
		write('_');
	{======Fim Titulo=====}
	repeat
		
	gotoxy(18,5);
	textcolor(lightgreen); {cor das opcoes}
	if x=1 then
		mudacor;
	writeln('Single Player          ');
	voltacor;
	gotoxy(18,6);
	if x=2 then
		mudacor;
	writeln('MultiPlayer            ');
	voltacor;
	gotoxy(18,7);
	if x=3 then
		mudacor;
	writeln('Ver teclas             ');
	voltacor;
	gotoxy(18,8);
	if x=4 then
		mudacor;
	writeln('Creditos               ');
	voltacor;
	gotoxy(18,9);
	if x=5 then
		mudacor;
	writeln('Sair                   ');
	voltacor;
	textcolor(15);
	gotoxy(16,4+x);
	writeln(chr(62));    {use o 62 ou o 16}
	voltacor;
	
	
	{i:=0;
	j:=0;}
	{========Texto q se move=======}
	repeat
		GetDate(Ano, Mes, Dia, Dia_Semana);
		GetTime(Hora, Minuto, Segundo, Dec_Segundo);
		gotoxy(1,1);
	 	if minuto<10 then
			write('_',hora,':0',minuto,':',segundo,'_');
		gotoxy(1,1);
		if hora<10 then
			write('_0',hora,':',minuto,':',segundo,'_');
        gotoxy(1,1);
        if segundo<10 then
			write('_',hora,':',minuto,':0',segundo,'_');
        gotoxy(1,1);
        if (hora<10) and (minuto<10) then
			write('_0',hora,':0',minuto,':',segundo,'_');
        gotoxy(1,1);
        if (hora<10) and (minuto<10) and (segundo<10) then
			write('_0',hora,':0',minuto,':0',segundo,'_');
        gotoxy(1,1);
        if (minuto<10) and (segundo<10) then
			write('_',hora,':0',minuto,':0',segundo,'_');
        gotoxy(1,1);
        if (hora<10) and (segundo<10) then
			write('_0',hora,':',minuto,':0',segundo,'_');

		gotoxy(1,1);
		if (minuto>=10) and (hora>=10) and (segundo>=10) then
			write('_',hora,':',minuto,':',segundo,'_');
		gotoxy(70,1);
		write('_',dia,'/',mes,'/',ano,'_');
		
		{linha para direita andando}
		{gotoxy(k-1,3);
		write('_');}
		
		{if k=0 then
		begin
			gotoxy(80,3);
			write('_');
		end;}
		
		if k<40 then
			textcolor(5)
		else
			textcolor(lightgreen);
		gotoxy(k,3);
		write('_');
		k:=k+1;
		if k=81 then
			k:=0;
		
		{linha para esquerda}
		voltacor;
		
		{gotoxy(1+m,3);
		write('_');}
		{if m=81 then
		begin
			gotoxy(1,3);
			write('_');
		end;}
		
		if m>40 then
			textcolor(5)
		else
			textcolor(lightgreen);
		gotoxy(m,3);
		write('_');
		m:=m-1;
		
		if m=0 then
			m:=80;
			
		gotoxy(1,2);
		writeln(' ');
		gotoxy(1,25);
		
		voltacor;
		if i<36 then
		begin
			delay(80);
			i:=i+1;
			gotoxy(i,24);                        
			write(' Criado por Arthur Assuncao - 1 Periodo ');  {texto com 45 caracteres}
			if i>=36 then
				j:=0;
		end;
		if i>=36 then
		begin
			delay(80);
			j:=j+1;
			gotoxy(36-j,24);
			write(' Criado por Arthur Assuncao - 1 Periodo ');
			if j>=35 then
				i:=0;
		end;
	gotoxy(1,25);
	until keypressed;
	{========FIM Texto q se move=======}
	
	tecla:=readkey;
	tecla:=upcase(tecla);
	case tecla of
		#80 :begin gotoxy(16,4+x); writeln(' '); x:=x+1; end;
		#72 :begin gotoxy(16,4+x); writeln(' '); x:=x-1; end;
	end; 		
	if x=0 then
		x:=5
	else
	if x=6 then
		x:=1;
	
	
	gotoxy(80,24);
	until tecla=#13;
	opcao:=x;
	case opcao of
		1:TelaInicialaux:=true;
		2:begin multiplayer:=True; TelaInicialaux:=true; end;
		3:TeclasUsadas;
		{4:Historia;}
		4:Creditos;
		5:begin fim; exit; end; {exit ou Halt}
	end;
until (opcao=5) or (TelaInicialaux);

	clrscr;
end;

procedure nave1;
begin
if vidas1>0 then
begin
	{nave1 minha}
	textcolor(lightred);
     gotoxy(x+dist,y);
     write('  ');write(#179);write(' ');
     gotoxy(x+dist,y+1);
     textcolor(yellow);write(' /');textcolor(lightred);write(#178);textcolor(yellow);write('\ ');
     {gotoxy(1,1);
     gotoxy(x-1,y+1);
     write(' ');}
     gotoxy(80,24);
end;
end;

procedure nave1apagar;
begin
	textcolor(lightred);
     gotoxy(x+dist,y);
     write('  ');write(#32);write(' ');
     gotoxy(x+dist,y+1);
     textcolor(yellow);write('  ');textcolor(lightred);write(#32);textcolor(yellow);write('  ');
     gotoxy(80,24);
end;

procedure nave2;
begin
if (vidas2>0) and multiplayer then
begin
	{nave2 minha}
	textcolor(lightcyan);
     gotoxy(x2+dist,y2);
     write('  ');write(#30);write(' ');  {#179}
     gotoxy(x2+dist,y2+1);
     textcolor(yellow);write(' /');textcolor(lightcyan);write(#219);textcolor(yellow);write('\ '); {#178}
     gotoxy(80,24);
end;
end;

procedure nave2apagar;
begin
	textcolor(lightred);
     gotoxy(x2+dist,y2);
     write('  ');write(#32);write(' ');
     gotoxy(x2+dist,y2+1);
     textcolor(yellow);write('  ');textcolor(lightred);write(#32);textcolor(yellow);write('  ');
     gotoxy(80,24);
end;
     
procedure naveinimiga;
begin
     {naveinimiga}
     delay(50);
     textcolor(corasa);
     gotoxy(dist+xi,yi);
     write(' \');textcolor(cor);write(#178);textcolor(corasa);write('/ ');
     textcolor(cor);
     gotoxy(dist+xi,yi+1);
     write('  ');write(#179);write(' ');
     {gotoxy(1,1);
     gotoxy(xi-1,yi+1);
     write(' ');}
     gotoxy(80,24);
end;

procedure naveinimiga_apagar;
begin
     {apagando naveinimiga}

     textcolor(cor);
     gotoxy(dist+xi,yi);
     write('  ');write(#32);write('  ');
     gotoxy(dist+xi,yi+1);
     write('  ');write(#32);write(' ');
     {gotoxy(1,1);
     gotoxy(xi-1,yi+1);
     write(' ');}
     gotoxy(80,24);
end;

procedure tiromeu;
begin
if vidas1>0 then
begin
	textcolor(darkgray);
	gotoxy(xt,yt);
	write(#124);
	gotoxy(80,24);
end;
end;

procedure apagatiromeu;
begin
if tiro1 then
	begin
		gotoxy(xt,yt);
		write(' ');
		yt:=yt-1;
		tiromeu;
	end;
end;

procedure tironave2;
begin
if (vidas2>0) and multiplayer then
begin
	textcolor(darkgray);
	gotoxy(xt2,yt2);
	write(#127);  {#124}
	gotoxy(80,24);
end;
end;

procedure apagatironave2;
begin
if tiro2 then
	begin
		gotoxy(xt2,yt2);
		write(' ');
		yt2:=yt2-1;
		tironave2;
	end;
end;

procedure especialnave1;
begin
if vidas1>0 then
begin
	textcolor(darkgray);
	gotoxy(xs-1,ys);
	write(#124);write(#124);write(#124);
	gotoxy(80,24);
end;
end;

procedure apagarespecialnave1;
begin
if especial1 then
	begin
		gotoxy(xs-1,ys);
		write('   ');
		ys:=ys-1;
		especialnave1;
	end;
end;

procedure especialnave2;
begin
if (vidas2>0) and multiplayer then
begin
	textcolor(darkgray);
	gotoxy(xs2-1,ys2);
	write(#127);write(#127);write(#127);  {#124}
	gotoxy(80,24);
end;
end;

procedure apagarespecialnave2;
begin
if especial2 then
	begin
		gotoxy(xs2-1,ys2);
		write('   ');
		ys2:=ys2-1;
		especialnave2;
	end;
end;

procedure tiroinimigo;
begin
	textcolor(darkgray);
	gotoxy(xti,yti);
	write(#124);
	gotoxy(80,24);
end;

procedure apagartiroinimigo;
begin
if tiroinimigo1 then
	begin
		gotoxy(xti,yti);
		write(' ');
		yti:=yti+1;
		tiroinimigo;
	end;
end;

procedure nave1morre;
begin
	if (((xti=x+1+dist) or (xti=x+3+dist)) and (yti=y)) or ((xti=x+2+dist) and (yti=y-1)) then
		nave1morreu:=true;
	
	if nave1morreu then
	begin
		nave1apagar;
		dec(vidas1); {diminui 1 em vidas}
		x:=15;
		y:=24;
		nave1;
		nave1morreu:=false;
		apagartiroinimigo;
	end;
end;

procedure nave2morre;
begin
if multiplayer then
begin
	if (((xti=x2+1+dist) or (xti=x2+3+dist)) and (yti=y2)) or ((xti=x2+2+dist) and (yti=y2-1)) then
		nave2morreu:=true;
	
	if nave2morreu then
	begin
		nave2apagar;
		dec(vidas2); {diminui 1 em vidas}
		x2:=35;
		y2:=24;
		nave2;
		nave2morreu:=false;
		apagartiroinimigo;
	end;
end;
end;

procedure inimigomorre;
begin
	{tiro meu - nave1}
	if ((xt=dist+xi+1) and (yt<=1)) or ((xt=dist+xi+2) and (yt<=2)) or ((xt=dist+xi+3) and (yt<=1)) then
	inimigo_morreu1:=true
	
	else {evita q o tiro e o especial qndo acertarem ao mesmo tempo valham como 2 pontos}
	{especial}
	if ((xs-1=xi+2+dist) or (xs=xi+2+dist) or (xs+1=xi+2+dist)) and (ys=yi+1) then
	inimigo_morreu1:=true
	
	else {especial da esquerda acerta inimigo}
		if (xs-1=xi+3+dist) and (ys=yi) then
	     inimigo_morreu1:=true
		 
		else {especial da direita acerta inimigo}
			if (xs+1=xi+1+dist) and (ys=yi) then
			inimigo_morreu1:=true;
			
	{fim tiro e especial meu - nave 1}

	{tiro e especial nave 2}
	if ((xt2=dist+xi+1) and (yt2<=1)) or ((xt2=dist+xi+2) and (yt2<=2)) or ((xt2=dist+xi+3) and (yt2<=1)) then
	inimigo_morreu2:=true
	
	else {evita q o tiro e o especial qndo acertarem ao mesmo tempo valham como 2 pontos}
	{especial}
	if ((xs2-1=xi+2+dist) or (xs2=xi+2+dist) or (xs2+1=xi+2+dist)) and (ys2=yi+1) then
	inimigo_morreu2:=true
	
	else {especial da esquerda acerta inimigo}
		if (xs2-1=xi+3+dist) and (ys2=yi) then
	     inimigo_morreu2:=true
		 
		else {especial da direita acerta inimigo}
			if (xs2+1=xi+1+dist) and (ys2=yi) then
			inimigo_morreu2:=true;
	
	{fim tiro e especial nave 2}
	
	{se inimgo morreu}
	if inimigo_morreu1 then
	begin
		case level of
			1:pontos1:=pontos1+10;
			2:pontos1:=pontos1+15;
		     3:pontos1:=pontos1+20;
		     4:pontos1:=pontos1+30;
		     5:pontos1:=pontos1+40;
		     6:pontos1:=pontos1+50;
		     7:pontos1:=pontos1+60;
		end;
		naveinimiga_apagar;
		xi:=25;
		yi:=1;
		randomize;
		repeat
			cor:=random(15);
		until cor<>0;
		repeat
			corasa:=random(15);
		until corasa<>0;
		naveinimiga;
		inc(inimigos_mortos);  {aumenta 1 na variavel inimigos_mortos}
		inimigo_morreu1:=false;
	end
	else
		if inimigo_morreu2 then
		begin
			case level of
				1:pontos2:=pontos2+10;
				2:pontos2:=pontos2+15;
			     3:pontos2:=pontos2+20;
			     4:pontos2:=pontos2+30;
			     5:pontos2:=pontos2+40;
			     6:pontos2:=pontos2+50;
			     7:pontos2:=pontos2+60;
			end;
			naveinimiga_apagar;
			xi:=25;
			yi:=1;
			randomize;
			repeat
				cor:=random(15);
			until cor<>0;
			repeat
				corasa:=random(15);
			until corasa<>0;
			naveinimiga;
			inc(inimigos_mortos);  {aumenta 1 na variavel inimigos_mortos}
			inimigo_morreu2:=false;
		end;
end;

procedure movimentoinimigo;
begin
	{Movimento do inimigo}
     {gettime(hora, min, seg, mili);
     if mili mod 5<>0 then
     begin}
	     randomize;
	     xrandom:=random(61);
	     if not cont2 then
	     	aux_xrandom:=xrandom;
	     {case xrandom of
	    		0:xrandom:=1;
	     	1:xrandom:=2;
	     end; }
	{end; }
	if not cont2 then
	if x+1<>xi+1 then
	case xrandom of
		0..5:if xi<largura then
				xi:=xi+1;
		6..10:if xi>1 then
				xi:=xi-1;
		11..15:if xi<largura then
				xi:=xi+1;
		16..35:if xi>1 then
				xi:=xi-1;
		36..55:if xi<largura then
				xi:=xi+1;
		56..61:if xi>1 then
				xi:=xi-1;
	end
	else
	begin
		cont2:=true;
	end;    
	if (cont2) and (xi<largura) and (xi>1) then
	case aux_xrandom of
		0..30:xi:=xi+1;
		31..61:xi:=xi-1;
	end;	
	cont:=cont+1;	
	if (cont<>0) and (not cont2) then
		cont:=0;
	if cont>=5 then
	begin
		cont:=0;
		cont2:=false;
	end;
	{fim movimento inimigo}
end;


{ -------------------FIM DOS PROCEDIMENTOS--------------------- }	

Begin
	{HighVideo;}
	
	exec('cmd.exe','/c title Naves jogo feito em Pascal por Arthur Assuncao');
	
				{Iniciando variaveis}
	i:=0;
	j:=0;
	x:=15;
	y:=24;
	x2:=35;
	y2:=24;
	xi:=15;
	yi:=1;
	xt:=1;
	yt:=24;
	xt2:=1;
	yt2:=24;
	xti:=1;
	yti:=2;
	xs:=1;
	ys:=24;
	xs2:=1;
	ys2:=24;
	velocidade:=30;
	level:=1;
	TelaInicialaux:=false;
	
	multiplayer:=false;
	
	tiro1:=false;
	tiro2:=false;
	tiroinimigo1:=false;
	especial1:=false;
	especial2:=false;
	num_especial1:=3;
	num_especial2:=3;
	inimigos_mortos:=0;
	inimigo_morreu1:=false;
	inimigo_morreu2:=false;
	cont:=0;
	pontos1:=0;
	pontos2:=0;
	vidas1:=3;
	vidas2:=3;
	repeat
		cor:=5; {0 a 15}
		randomize;
		cor:=random(15);
	until cor<>0;	
	repeat
		corasa:=5; {0 a 15}
		randomize;
		corasa:=random(15);
	until cor<>0;
			
			{fim Iniciando Variaveis}

	textcolor(lightgreen);
	
	repeat
		TelaInicial;
	until TelaInicialaux;
	
	textcolor(darkgray);
	for i:=1 to 25 do
	begin
		gotoxy(1,i);
		writeln(#219);
		gotoxy(56,i);
		writeln(#219);
	end;
	for i:=57 to 80 do  {linha dividindo dados nave 1 e dados nave 2}
	begin
		gotoxy(i,12);
		writeln('_');
	end;
	{for i:=1 to 50 do
	begin
		gotoxy(i,1);
		writeln(#220);
		gotoxy(i,25);
		writeln(#220);
	end; }
	
	
	
	textcolor(lightgreen);
	
	
repeat

	apagatiromeu;
	apagatironave2;
	apagarespecialnave1;
	apagarespecialnave2;
	
	inimigomorre;
	
	textcolor(lightgreen);
	gotoxy(65,1);
	write('Level ',level);
	gotoxy(60,3);
	write('Inimigos Mortos ',inimigos_mortos);
	
	{Dados Nave 1}
	if vidas1>=0 then
	begin
		gotoxy(60,5);
		write('Pontos = ',pontos1);
		gotoxy(60,7);
		write('Especias = ',num_especial1);
		gotoxy(60,9);
		write('Vidas = ',vidas1);
	end;
	
	{Dados Nave 2}
	if (multiplayer) and (vidas2>=0) then
	begin
		gotoxy(60,17);            {apaga o Nave 2 press 7}
		write('               ');
		gotoxy(60,15);
		write('Pontos = ',pontos2);
		gotoxy(60,17);
		write('Especias = ',num_especial2);
		gotoxy(60,19);
		write('Vidas = ',vidas2);
	end;
	
	if not multiplayer then
	begin
		gotoxy(60,17);
		write('Nave 2 press 7');
	end;
	gotoxy(80,24);

	teclas:='N';
	teclas2:='N';
	teclas3:='N';
	teclas4:='N';
	nave1;
	nave2;
	naveinimiga;
     
     {teclas mover}
     if keypressed then
	begin 
		case readkey of
			{Teclas Nave 1}
			#65,#97:teclas:='A';  {esquerda}
			#68,#100:teclas:='D';  {direita}
			{#87,#119:teclas:='W';  cima
			#83,#115:teclas:='S';  baixo}	
 
			#79,#111:teclas2:='O'; {pause}
			#72,#104,' ',#10:teclas2:='H'; {tiro}
			#74,#106:teclas2:='J';   {especial nave1}
			#61:teclas2:='B';{ = para sair, mas o programa ve B pra sair}


			{Teclas Nave 2}
			#52:teclas3:='4';  {esquerda - '4' } {#75 seta esquerda}
			#54:teclas3:='6';  {direita -  '6' }  {#77 seta direita}
 
			#57:teclas4:='9'; {pause - num 9}
			#126:teclas4:='1'; {tiro '~'}
			#93:teclas4:='2';   {especial nave2 ']'}
			#8:teclas4:='8'; {backspace para sair}
			#55:multiplayer:=true; {tecla num 7 para iniciar modo multiplayer}
		end;           
	end; 
     
     case teclas of
     'A':if x>1 then x:=x-1;
     'D':if x<largura then x:=x+1;
     'N':;	{Nula nao faz nada}
     end;
     
     case teclas2 of
     'O':begin gotoxy(23,12); writeln('Jogo Pausado');  gotoxy(80,24); readln; gotoxy(23,12);writeln('             '); gotoxy(80,24); end;
     'H':; {ARRUMA AKI - tiromeu}
     'B':fim;
     'J':; {Especial nave1}
     'N':;	{Nula nao faz nada}
     end;
     
     if multiplayer then
     begin
     	case teclas3 of
	     '4':if x2>1 then x2:=x2-1;
	     '6':if x2<largura then x2:=x2+1;
	     'N':; {nula nao faz nada}
	     end;
	     
	     case teclas4 of
	     '9':begin gotoxy(23,12); writeln('Jogo Pausado');  gotoxy(80,24); readln; gotoxy(23,12);writeln('             '); gotoxy(80,24); end;
	     '1':; { Tiro nave 2}
	     '8':fim;
	     '2':; {especial nave 2}
	     'N':; {nula nao faz nada}
	     end;
     end;
     
     movimentoinimigo;
	
	delay(velocidade);
	
	{tiro meu}
	if not tiro1 then
	if teclas2='H' then
	begin
		xt:=x+3;
		tiromeu;
		tiro1:=true;
	end;
	
	{tiro nave2}
	if multiplayer then
	if not tiro2 then
	if teclas4='1' then
	begin
		xt2:=x2+3;
		tironave2;
		tiro2:=true;
	end;
	
	{especial}
	if not especial1 then
	if (teclas2='J') and (num_especial1>0) then
	begin
		xs:=x+3;
		num_especial1:=num_especial1-1;
		especialnave1;
		especial1:=true;
	end;
	
	if multiplayer then
	if not especial2 then
	if (teclas4='2') and (num_especial2>0) then
	begin
		xs2:=x2+3;
		num_especial2:=num_especial2-1;
		especialnave2;
		especial2:=true;
	end;
	
	apagatiromeu;
	apagatironave2;
	apagarespecialnave1;
	apagarespecialnave2;	
	
	inimigomorre;
	
	apagatiromeu;
	apagatironave2;
	apagarespecialnave1;
	apagarespecialnave2;
	
	inimigomorre;
	
	{fim tiro meu e especial nave 1}
	
	{apagar tiro qndo acertar inimigo ou qndo chegar no topo}	
	if (yt=yi) or (yt<=1) then
	begin
		gotoxy(xt,yt);
		write(' ');
		tiro1:=false;
		yt:=24;
	end;
	if (ys=yi) or (ys<=1) then
	begin
		gotoxy(xs-1,ys);
		write('   ');
		especial1:=false;
		ys:=24;
	end;
	{nave 2}
	if (yt2=yi) or (yt2<=1) then
	begin
		gotoxy(xt2,yt2);
		write(' ');
		tiro2:=false;
		yt2:=24;
	end;
	if (ys2=yi) or (ys2<=1) then
	begin
		gotoxy(xs2-1,ys2);
		write('   ');
		especial2:=false;
		ys2:=24;
	end;
     
     {tiro do inimigo}
	if not tiroinimigo1 then
	begin
		xti:=xi+3;
		tiroinimigo;
		tiroinimigo1:=true;
	end;
	
	{apagar tiro inimigo qndo me acerta ou acerta a parte de baixo}
	if (yti=y) or (yti>=24) then
	begin
		gotoxy(xti,yti);
		write(' ');
		tiroinimigo1:=false;
		yti:=2;
	end;
	
	apagartiroinimigo;
	
	nave1morre;
	nave2morre;
	apagartiroinimigo;
	nave1morre;
	nave2morre;
     
     delay(velocidade);
     
     if (vidas1<=0) and (vidas2<=0) then
     begin
     	morreu:=true;
     	fim;
     end;
until (morreu) or ((vidas1<=0) and (vidas2<=0)) or ((not multiplayer) and (vidas1<=0));
	clrscr;
	fim;
end.
