Program snake;

uses crt;

const linhas=20;
	 colunas=40;
	 dist=1; {dist=distancia a mais no gotoxy}
	
type campo=array[1..linhas,1..colunas] of char;

var  camp:campo;
	snakei:array[1..800] of integer;
	snakej:array[1..800] of integer;
	seta:char;
	teclas,aux_teclas:char;
	i,j,si,sj,aux_si,aux_sj:integer;     {i e j sao linha e coluna da matriz tela}
	bi,bj,aux_bi,aux_bj:integer;			{bi e bj sao da bolinha}
	contI, contJ, cont, pontos, f, k, k2, p, velocidade:integer; 	{contador e pontos}
	morreu, apagar:boolean;
	

Begin
	clrscr;
	textbackground(lightgray);
	for j:=1 to linhas+2 do
		begin
			gotoxy(1,j);
			write(' ');
			gotoxy(42,j);
			write(' ');
		end;
	for i:=1 to colunas+2 do
	     begin
			gotoxy(i,1);
			write(' ');
			gotoxy(i,22);
			write(' ');
		end;
	textbackground(black);
	{for i:=1 to linhas do
		for j:=1 to colunas do
			camp[i,j]:=' ';
	for i:=1 to linhas do
		for j:=1 to colunas do
			Begin
				gotoxy(1+j,1+i);
				write(camp[i,j]);
			end;}
	snakei[1]:=linhas - (linhas div 2);
	snakej[1]:=colunas - (colunas div 2);			
	morreu:=False;
	apagar:=true;
	pontos:=1;
	teclas:='D';
	cont:=0;
	k:=0;
	si:=0;
	sj:=0;
	
	camp[snakei[1],snakej[1]]:='x';
	gotoxy(snakej[1]+dist,snakei[1]+dist);
	write(camp[snakei[1],snakej[1]]);
	{onde esta a bolinha}
	repeat
		bi:=random(linhas);
	until (bi<>snakei[1])  and (bi<>0);
	repeat
		bj:=random(colunas);
	until (bj<>snakej[1]) and (bj<>0);
	
	camp[bi,bj]:='.';
	gotoxy(bj+dist,bi+dist);
	write(camp[bi,bj]);
	
repeat {------------aki comeca o jogo, de fato------------}
	gotoxy(44,2);
	write('Pontos ',pontos-1);	
	
	{velocidade da cobrinha}
	velocidade:=200-((pontos-1)*5);
	if (((pontos-1)*5)>=150) and (((pontos-1)*5)<180) then
		velocidade:=70-(((pontos-1-10))*5);
	if velocidade<=20 then
		velocidade:=20;
	
	delay(velocidade);
	
	
	gotoxy(44,4);
	write('velocidade ',200-velocidade);
	
	aux_teclas:=teclas;
	if keypressed then
	begin
		case readkey of
			#65,#97:teclas:='A';
			#68,#100:teclas:='D';
			#87,#119:teclas:='W';
			#83,#115:teclas:='S';
			#76,#108:teclas:='L';
		end;
	end;
	
	{nao pode escolher lado oposto se tiver tamanho>2}
	if pontos>1 then
	begin
		if ((aux_teclas='D') and (teclas='A')) or ((aux_teclas='A') and (teclas='D')) then
			teclas:=aux_teclas;
		if ((aux_teclas='W') and (teclas='S')) or ((aux_teclas='S') and (teclas='W')) then
			teclas:=aux_teclas;
	end;			
	aux_teclas:=teclas;
	
	{ se o cara bater na parede, ele perde}
	if (snakei[1]=1) and (teclas='W') then
		morreu:=true;
	if (snakei[1]=20) and (teclas='S') then
		morreu:=true;
	if (snakej[1]=1) and (teclas='A') then
		morreu:=true;
	if (snakej[1]=40) and (teclas='D') then
		morreu:=true;
	if morreu then
		Begin
			gotoxy(colunas+4,linhas-5);
			write('Voce morreu ');
			gotoxy(colunas+4,linhas-4);
			write('Sua pontuacao ',pontos-1,' pontos');
			readln;
			exit;
		end;
		
	{bateu perdeu}
	
	if apagar then
	begin
		aux_si:=si;
		aux_sj:=sj;
	end;
	
	si:=0;
	sj:=0;
	case teclas of
		'A':if snakej[1]>=2 then
			sj:=sj-1;
		'D':if snakej[1]<=(colunas-1) then
			sj:=sj+1;
		'W':if snakei[1]>=2 then
			si:=si-1;
		'S':if snakei[1]<=(linhas-1) then
			si:=si+1;
	end;

	{onde esta a bolinha}
	if (snakei[1]=bi) and (snakej[1]=bj) then
	Begin
		aux_bi:=bi;
		aux_bj:=bj;
		camp[bi,bj]:='x';
		pontos:=pontos+1;
		apagar:=false;
		for k:=1 to pontos do
			if (snakei[k]=bi) and (snakej[k]=bj) then
				camp[bi,bj]:='x';
		repeat
			bi:=random(linhas);
		until (bi<>snakei[1])  and (bi<>0) and (bi<>aux_bi);
		repeat
			bj:=random(colunas);
		until (bj<>snakej[1]) and (bj<>0) and (bj<>aux_bj);
		camp[bi,bj]:='.';
	end;
	
	gotoxy(bj+dist,bi+dist);
	write(camp[bi,bj]);
	
	{snakei[1]:=snakei[1]+si;
	snakej[1]:=snakej[1]+sj; }
	
	if not apagar then
	begin
		cont:=cont+1; {contador para arrumar o espaco depois q pega a bolinha}
		if cont=(pontos) then
		begin
			apagar:=true;
			cont:=0;
		end;
	end;
	
	if (not apagar) and (pontos>1) then
	begin
		camp[aux_bi-aux_si,aux_bj-aux_sj]:='x';
		gotoxy(aux_bj-aux_sj+dist,aux_bi-aux_si+dist);
		write(camp[aux_bi-aux_si,aux_bj-aux_sj]);
	end;
	
	if (apagar) and (pontos>1) and (aux_bi-aux_si>0) and (aux_bj-aux_sj>0) then
	begin
		camp[aux_bi-aux_si,aux_bj-aux_sj]:=' ';
		gotoxy(aux_bj-aux_sj+dist,aux_bi-aux_si+dist);
		write(camp[aux_bi-aux_si,aux_bj-aux_sj]);
	end;	
	
	{apagando rastro}
	if apagar then
	begin
		camp[snakei[1],snakej[1]]:=' ';
		gotoxy(snakej[1]+dist,snakei[1]+dist);
		write(camp[snakei[1],snakej[1]]);
	end;
	
	if (pontos>1) and (snakei[pontos]<>0) and (snakej[pontos]<>0) then
	begin
		camp[snakei[pontos],snakej[pontos]]:=' ';
		gotoxy(snakej[pontos]+dist,snakei[pontos]+dist);
		write(camp[snakei[pontos],snakej[pontos]]);
	end;

	snakei[1]:=snakei[1]+si;
	snakej[1]:=snakej[1]+sj;
	
	{a cobrinha}
	if (snakei[1]<>bi) or (snakej[1]<>bj) then
	begin
		{camp[snakei[1]-si,snakej[1]-sj]:=' ';	
		gotoxy(snakej[1]-sj+dist,snakei[1]-si+dist);
		write(camp[snakei[1]-si,snakej[1]-sj]);}

		if pontos>1 then
          for k:=(pontos) downto 2 do
		begin
			snakei[k]:=snakei[k-1];
			snakej[k]:=snakej[k-1];
			if k=2 then
			begin
			snakei[2]:=snakei[2]-si;
			snakej[2]:=snakej[2]-sj;
			end;
		end;
	
		for k:=pontos downto 1 do
		begin
			{camp[snakei[k],snakej[k]]:=' ';
			gotoxy(snakej[k]+dist,snakei[k]+dist);
			write(camp[snakei[k],snakej[k]]); }
			camp[snakei[k],snakej[k]]:='x';
			gotoxy(snakej[k]+dist,snakei[k]+dist);
			write(camp[snakei[k],snakej[k]]);
		end;
	end; {fim da cobrinha}

	{nao pode bater em si mesma}
	for k:=2 to pontos-1 do
		if (snakei[1]=snakei[k]) and (snakej[1]=snakej[k]) then
			Begin
				gotoxy(colunas+4,linhas-5);
				write('Voce morreu ');
				gotoxy(colunas+4,linhas-4);
				write('Sua pontuacao ',pontos-1,' pontos');
				readln;
				exit;
			end;
	
	gotoxy(colunas+4,linhas+2);
	write(cont,' ',si,' ',sj,' ',snakei[3],' ',snakej[3],' ',snakei[2],' ',snakej[2],' ',snakei[1],' ',snakej[1],' ',apagar,' ',aux_bi,' ',aux_bj);
	
until (morreu) or (teclas='L');
	gotoxy(colunas+4,linhas-4);
	write(' Voce conseguiu ',pontos-1,' pontos');
	readln;			
end.
