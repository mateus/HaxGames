program Nave_by_Arthur;

uses crt, graph, dos;

const largura=50;
      altura=25;
      dist=1; {dist=distancia da parede ate a nave}
      maximoInimigos=5;

var  xi, yi, xti, yti, cont, cor, corasa:array[1..maximoInimigos] of integer;
	cont2, inimigo_morreu1, inimigo_morreu2, tiroinimigo1:array[1..maximoInimigos] of boolean;
	
	x, y, x2, y2, xt, yt, xt2, yt2, xs, ys, xs2, ys2:integer; {x y= eu, xi yi= inimigo, xt yt= tiro}
	velocidade, inimigos_mortos, level, numeroinimigos:integer;
	i, j:integer;
	pontos1, vidas1, num_especial1:integer;
	pontos2, vidas2, num_especial2:integer;

	teclas, teclas2:char;
	teclas3, teclas4:char;
	morreu, nave1morreu, nave2morreu, multiplayer:boolean;
	tiro1,  tiro2, especial1, especial2:boolean;     {tiro1= nave1, tiro2=nave2}
	xrandom, aux_xrandom:integer; {randon para o xi do inimigo}
	
	menu:char;
	TelaInicialaux, saiu:boolean;
	
	{hora, min, seg, mili:integer;}

     {TeclasDosUsuarios: file of string;}

{----------------- Procedimentos ------------------}

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

procedure mudacor;
begin
	randomize;
	repeat
		randomize;
		cor[i]:=random(15);
	until cor[i]<>0;
	repeat
	
		randomize;
		corasa[i]:=random(15);
	until corasa[i]<>0;
end;

procedure fim;
begin
	clrscr;
	TelaInicialaux:=true;
	morreu:=true;
	repeat
		textcolor(cor[1]);
		gotoxy(20,5);
		writeln('Game Over');
		writeln;
		if not saiu then
		begin
			gotoxy(20,7);
			writeln('Pontuacao Nave 1 = ',pontos1);
			if (multiplayer) then
			begin
				gotoxy(20,9);
				writeln('Pontuacao Nave 2 = ',pontos2);
			end;
		end;
		randomize;
		cor[1]:=random(15);
		corasa[1]:=random(15);
		delay(200);
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
	{gotoxy(32,8);}
	for i:=1 to 80 do
	write('_');
	textcolor(lightred);
	gotoxy(32,2);
	writeln('Machine Space 1.0');
	textcolor(lightgreen);
	for i:=1 to 80 do
	write('_');
	
	gotoxy(32,5);
	writeln('1 - Single Player');
	gotoxy(32,7);
	writeln('2 - MultiPlayer');
	gotoxy(32,9);
	writeln('3 - Ver teclas');
	gotoxy(32,11);
	writeln('4 - Historia');
	gotoxy(32,13);
	writeln('5 - Creditos');
	gotoxy(32,15);
	writeln('6 - Sair');
	gotoxy(80,24);
	
	i:=0;
	j:=0;
	repeat
		repeat
			if i<40 then
			begin
				delay(120);
				i:=i+1;
				gotoxy(i,24);    {total na coluna 80}
				{textcolor(random(15)); }                           
				write(' Criado por Arthur Assuncao - 1 Periodo ');  {texto com 40 caracteres}
				if i>=40 then
					j:=0;
			end;
			if i>=40 then
			begin
				delay(120);
				j:=j+1;
				gotoxy(40-j,24);
				{textcolor(random(15)); }
				write(' Criado por Arthur Assuncao - 1 Periodo ');
				if j>=39 then
					i:=0;
			end;
		until keypressed;
		menu:=readkey;
	until (menu<>'1') or (menu<>'2') or (menu<>'3') or (menu<>'4') or (menu<>'5');
	case menu of
		'1':TelaInicialaux:=true;
		'2':begin multiplayer:=True; TelaInicialaux:=true; end;
		'3':TeclasUsadas;
		'4':Historia;
		'5':Creditos;
		'6':begin saiu:=true; fim; exit; end; {exit ou Halt}
	end;

	clrscr;
end;

procedure nave1;
begin
if vidas1>0 then
begin
	{nave1 minha}
	textcolor(lightred);
     gotoxy(x+dist,y);
     write('  ');write(#30);write(' ');
     gotoxy(x+dist,y+1);
     textcolor(yellow);write(' /');textcolor(lightred);write(#219);textcolor(yellow);write('\ ');
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
     textcolor(yellow);write(' ',#17);textcolor(lightcyan);write(#176);textcolor(yellow);write(#16,' '); {#178}
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
for j:=1 to numeroinimigos do
begin
     delay(60-(numeroinimigos*10));
     textcolor(corasa[j]);
     gotoxy(dist+xi[j],yi[j]);
     write(' \');textcolor(cor[j]);write(#178);textcolor(corasa[j]);write('/ ');
     textcolor(cor[j]);
     gotoxy(dist+xi[j],yi[j]+1);
     write('  ');write(#179);write(' ');
     gotoxy(80,24);
end;
end;

procedure naveinimiga_apagar;
begin
     {apagando naveinimiga}
for j:=1 to numeroinimigos do
begin
     textcolor(cor[j]);
     gotoxy(dist+xi[j],yi[j]);
     write('  ');write(#32);write('  ');
     gotoxy(dist+xi[j],yi[j]+1);
     write('  ');write(#32);write(' ');

     gotoxy(80,24);
end;
end;

procedure posicoesinimigos;
begin
     case i of
		1:xi[i]:=25;
		2:xi[i]:=35;
		3:xi[i]:=15;
		4:xi[i]:=5;
		5:xi[i]:=45;
	end;
end;

procedure tiromeu;
begin
if vidas1>0 then
begin
	textcolor(darkgray);
	gotoxy(xt,yt);
	write(#127);
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
	write(#124);  {#124}
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
	write(#127);write(#127);write(#127);
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
	write(#124);write(#124);write(#124);  {#124}
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
for i:=1 to numeroinimigos do
begin
	textcolor(darkgray);
	gotoxy(xti[i],yti[i]);
	write(#124);
	gotoxy(80,24);
end;
end;

procedure apagartiroinimigo;
begin
for i:=1 to numeroinimigos do
begin
if tiroinimigo1[i] then
	begin
		gotoxy(xti[i],yti[i]);
		write(' ');
		yti[i]:=yti[i]+1;
		tiroinimigo;
	end;
end;
end;

procedure nave1morre;
begin
	if (((xti[i]=x+1+dist) or (xti[i]=x+3+dist)) and (yti[i]=y)) or ((xti[i]=x+2+dist) and (yti[i]=y-1)) then
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
	if (((xti[i]=x2+1+dist) or (xti[i]=x2+3+dist)) and (yti[i]=y2)) or ((xti[i]=x2+2+dist) and (yti[i]=y2-1)) then
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
	for i:=1 to maximoinimigos do
	begin
		inimigo_morreu1[i]:=false;
	     inimigo_morreu2[i]:=false;                    
	end;
for i:=1 to numeroinimigos do
begin
	{tiro meu - nave1}
	if ((xt=dist+xi[i]+1) and (yt<=1)) or ((xt=dist+xi[i]+3) and (yt<=1)) then
	inimigo_morreu1[i]:=true
	
	else
	if (xt=dist+xi[i]+2) and (yt=2) then   {tiro acertar meio do inimigo}
	inimigo_morreu1[i]:=true
	
	else {evita q o tiro e o especial qndo acertarem ao mesmo tempo valham como 2 pontos}
	{especial}
	if ((xs-1=xi[i]+2+dist) or (xs=xi[i]+2+dist) or (xs+1=xi[i]+2+dist)) and (ys=yi[i]+1) then
	inimigo_morreu1[i]:=true
	
	else {especial da esquerda acerta inimigo}
		if (xs-1=xi[i]+3+dist) and (ys=yi[i]) then
	     inimigo_morreu1[i]:=true
		 
		else {especial da direita acerta inimigo}
			if (xs+1=xi[i]+1+dist) and (ys=yi[i]) then
			inimigo_morreu1[i]:=true;
			
	{fim tiro e especial meu - nave 1}

	{tiro e especial nave 2}
	if ((xt2=dist+xi[i]+1) and (yt2<=1)) or ((xt2=dist+xi[i]+3) and (yt2<=1)) then
	inimigo_morreu2[i]:=true
	
	else
	if (xt2=dist+xi[i]+2) and (yt2=2) then  {tiro acertar meio do inimigo}
	inimigo_morreu2[i]:=true
	
	else {evita q o tiro e o especial qndo acertarem ao mesmo tempo valham como 2 pontos}
	{especial}
	if ((xs2-1=xi[i]+2+dist) or (xs2=xi[i]+2+dist) or (xs2+1=xi[i]+2+dist)) and (ys2=yi[i]+1) then
	inimigo_morreu2[i]:=true
	
	else {especial da esquerda acerta inimigo}
		if (xs2-1=xi[i]+3+dist) and (ys2=yi[i]) then
	     inimigo_morreu2[i]:=true
		 
		else {especial da direita acerta inimigo}
			if (xs2+1=xi[i]+1+dist) and (ys2=yi[i]) then
			inimigo_morreu2[i]:=true;
	
	{fim tiro e especial nave 2}
	
	{se inimgo morreu}
	if inimigo_morreu1[i] then
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
		posicoesinimigos;
		yi[i]:=1;
		gotoxy(60,22);
		write(i);
		mudacor;
		naveinimiga;
		inc(inimigos_mortos);  {aumenta 1 na variavel inimigos_mortos}
		inimigo_morreu1[i]:=false;

	end;
	{else}
		if inimigo_morreu2[i] then
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
			posicoesinimigos;
			yi[i]:=1;
			mudacor;
			naveinimiga;
			inc(inimigos_mortos);  {aumenta 1 na variavel inimigos_mortos}
			inimigo_morreu2[i]:=false;
		end;
end;
end;

procedure movimentoinimigo;
begin
	{Movimento do inimigo}
     {gettime(hora, min, seg, mili);
     if mili mod 5<>0 then
     begin}
for i:=1 to numeroinimigos do
begin
	     randomize;
	     xrandom:=random(61);
	     if not cont2[i] then
	     	aux_xrandom:=xrandom;
	     {case xrandom of
	    		0:xrandom:=1;
	     	1:xrandom:=2;
	     end; }
	{end; }
	if not cont2[i] then
	if x+1<>xi[i]+1 then
	case xrandom of
		0..5:if xi[i]<largura then
				xi[i]:=xi[i]+1;
		6..10:if xi[i]>1 then
				xi[i]:=xi[i]-1;
		11..15:if xi[i]<largura then
				xi[i]:=xi[i]+1;
		16..35:if xi[i]>1 then
				xi[i]:=xi[i]-1;
		36..55:if xi[i]<largura then
				xi[i]:=xi[i]+1;
		56..61:if xi[i]>1 then
				xi[i]:=xi[i]-1;
	end
	else
	begin
		cont2[i]:=true;
	end;    
	if (cont2[i]) and (xi[i]<largura) and (xi[i]>1) then
	case aux_xrandom of
		0..30:xi[i]:=xi[i]+1;
		31..61:xi[i]:=xi[i]-1;
	end;	
	cont[i]:=cont[i]+1;	
	if (cont[i]<>0) and (not cont2[i]) then
		cont[i]:=0;
	if cont[i]>=5 then
	begin
		cont[i]:=0;
		cont2[i]:=false;
	end;
end;
	{fim movimento inimigo}
end;


{ -------------------FIM DOS PROCEDIMENTOS--------------------- }	

Begin
	{HighVideo;}
	exec('cmd.exe','/c title Machine Space 1.0                                             by Arthur Assuncao');
	
				{Iniciando variaveis}
	i:=0;
	j:=0;
	x:=15;
	y:=24;
	x2:=35;
	y2:=24;
	for i:=1 to maximoinimigos do
	begin
		posicoesinimigos;
		yi[i]:=1;
		xti[i]:=1;
		yti[i]:=2;
		inimigo_morreu1[i]:=false;
		inimigo_morreu2[i]:=false;
		tiroinimigo1[i]:=false;
	end;
	
	xt:=1;
	yt:=24;
	xt2:=1;
	yt2:=24;
	
	xs:=1;
	ys:=24;
	xs2:=1;
	ys2:=24;
	numeroinimigos:=1;
	velocidade:=30;
	level:=1;
	TelaInicialaux:=false;
	saiu:=false;
	
	multiplayer:=false;
	
	tiro1:=false;
	tiro2:=false;
	especial1:=false;
	especial2:=false;
	num_especial1:=3;
	num_especial2:=3;
	inimigos_mortos:=0;
	pontos1:=0;
	pontos2:=0;
	vidas1:=3;
	vidas2:=3;
	for i:=1 to maximoinimigos do
	begin
		cont[i]:=0;
		mudacor
	end;
			
			{fim Iniciando Variaveis}

	clrscr;

	textcolor(lightgreen);
	
	repeat
		TelaInicial;
	until TelaInicialaux;
	
	if not saiu then
	begin
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
	end;
	{for i:=1 to 50 do
	begin
		gotoxy(i,1);
		writeln(#220);
		gotoxy(i,25);
		writeln(#220);
	end; }
	
	
	
	textcolor(lightgreen);
	
if not saiu then	
repeat
	case level of
		{1:numeroinimigos:=1;}
		1,2:numeroinimigos:=2;
		3:numeroinimigos:=3;
		4:numeroinimigos:=4;
		5:numeroinimigos:=5;
	end;

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
	
	{chefe}
	{if chefe then
	begin
		textcolor(lightgreen);
		if not multiplayer then
		begin
			gotoxy(60,20);
			write('Chefe');
			gotoxy(60,21);
		     for j:=1 to vida_chefe do
		     	write(#220);
		end;
		if multiplayer then
		begin
			gotoxy(60,22);
			write('Chefe');
			gotoxy(60,23);
		     for j:=1 to vida_chefe do
		     	write(#220);
		end;
	end; }
	
	if not multiplayer then
	begin
		gotoxy(60,17);
		write('Nave 2 press 7');
		gotoxy(60,20);
		write(cor[1],' ',cor[2],' ',cor[3],' ',cor[4],' ',cor[5]);
		gotoxy(60,21);
		write(numeroinimigos);
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
     
     {movimentoinimigo; }
	
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
	
	for i:=1 to numeroinimigos do
	begin
	{apagar tiro qndo acertar inimigo ou qndo chegar no topo}	
	if (yt=yi[i]) or (yt<=1) then
	begin
		gotoxy(xt,yt);
		write(' ');
		tiro1:=false;
		yt:=24;
	end;
	if (ys=yi[i]) or (ys<=1) then
	begin
		gotoxy(xs-1,ys);
		write('   ');
		especial1:=false;
		ys:=24;
	end;
	{nave 2}
	if (yt2=yi[i]) or (yt2<=1) then
	begin
		gotoxy(xt2,yt2);
		write(' ');
		tiro2:=false;
		yt2:=24;
	end;
	if (ys2=yi[i]) or (ys2<=1) then
	begin
		gotoxy(xs2-1,ys2);
		write('   ');
		especial2:=false;
		ys2:=24;
	end;
     
     {tiro do inimigo}
     {for i:=1 to numeroinimigos do
     begin}
	if not tiroinimigo1[i] then
	begin
		xti[i]:=xi[i]+3;
		tiroinimigo;
		tiroinimigo1[i]:=true;
	end;
	
	{apagar tiro inimigo qndo me acerta ou acerta a parte de baixo}
	if (yti[i]=y) or (yti[i]>=24) then
	begin
		gotoxy(xti[i],yti[i]);
		write(' ');
		tiroinimigo1[i]:=false;
		yti[i]:=2;
	end;
	end;
	{end;}
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
	{clrscr;
	fim;}
end.
