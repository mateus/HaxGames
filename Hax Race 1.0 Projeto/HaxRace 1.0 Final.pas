program HaxRace;

uses crt;

var x,i,aux,velocidade , velocidade_troca:integer;
    x_descendo, y_descendo : integer;
    num_carros,carro_random : integer;
    carroA: boolean;
    xA_descendo,r,b,c,contfase,fase,contvida: integer ;
    boo:boolean;
    velocidadetexto,pontos,cor:integer;
    continuar,cod:char;


{----------------------- Precedimento de creditos -----------------------------}
procedure creditos();
begin
  textbackground(2);
    clrscr;
    textcolor(15);
for i := 1 to 80 do
    begin
        gotoxy(i,1); write(chr(205));
        gotoxy(i,24);write(chr(205));
        gotoxy(1,1);write(chr(201));
        gotoxy(80,1);write(chr(187));
    end;
for i:= 1 to 23 do
    begin
        gotoxy(1,i+1);write(chr(186));
        gotoxy(80,i+1);write(chr(186));
        gotoxy(1,24);write(chr(200));
        gotoxy(80,24);write(chr(188));
     end;
     gotoxy(33,1);write(' C R E D I T O S ');
     gotoxy(22,24);write(' 1',chr(248),' Periodo TSI - IFET Campus Barbacena ');

//Escrevendo HaxRace
// Letra H
     delay(100);
     gotoxy(3,9);write(chr(177));
     delay(100);
     gotoxy(3,10);write(chr(177));
     delay(100);
     gotoxy(3,11);write(chr(177));
     delay(100);
     gotoxy(4,11);write(chr(177));
     delay(100);
     gotoxy(3,12);write(chr(177));
     delay(100);
     gotoxy(5,10);write(chr(177));
     delay(100);
     gotoxy(5,11);write(chr(177));
     delay(100);
     gotoxy(5,12);write(chr(177));
     delay(100);
     gotoxy(5,13);write(chr(177));
     delay(100);
// Letra A
delay(100);
     gotoxy(7,11);write(chr(177));
     delay(100);
     gotoxy(7,12);write(chr(177));
      delay(100);
     gotoxy(8,10);write(chr(177));
     delay(100);
     gotoxy(9,11);write(chr(177));
     delay(100);
     gotoxy(9,12);write(chr(177));
     delay(100);
     gotoxy(8,11);write(chr(177));
     delay(100);
// Letra X
     gotoxy(11,10);write(chr(177));
     delay(100);
     gotoxy(12,11);write(chr(177));
     delay(100);
     gotoxy(11,12);write(chr(177));
     delay(100);
     gotoxy(13,10);write(chr(177));
     delay(100);
     gotoxy(13,12);write(chr(177));
     delay(100);
// Letra R
     gotoxy(15,9);write(chr(177));
     delay(100);
     gotoxy(15,10);write(chr(177));
     delay(100);
     gotoxy(15,11);write(chr(177));
     delay(100);
     gotoxy(15,12);write(chr(177));
     delay(100);
     gotoxy(16,9);write(chr(177));
     delay(100);
     gotoxy(17,10);write(chr(177));
     delay(100);
     gotoxy(16,11);write(chr(177));
     delay(100);
     gotoxy(17,12);write(chr(177));
     delay(100);
// Letra A
     gotoxy(19,11);write(chr(177));
     delay(100);
     gotoxy(19,12);write(chr(177));
      delay(100);
     gotoxy(20,10);write(chr(177));
     delay(100);
     gotoxy(21,11);write(chr(177));
     delay(100);
     gotoxy(21,12);write(chr(177));
     delay(100);
     gotoxy(20,11);write(chr(177));
     delay(100);
// Letra C
     gotoxy(23,10);write(chr(177));
     delay(100);
     gotoxy(23,11);write(chr(177));
      delay(100);
     gotoxy(23,12);write(chr(177));
     delay(100);
     gotoxy(24,10);write(chr(177));
     delay(100);
     gotoxy(24,12);write(chr(177));
     delay(100);
// Letra E
     gotoxy(27,9);write(chr(177));
     delay(100);
     gotoxy(28,9);write(chr(177));
     delay(100);
     gotoxy(26,10);write(chr(177));
     delay(100);
     gotoxy(27,11);write(chr(177));
     delay(100);
     gotoxy(28,11);write(chr(177));
     delay(100);
     gotoxy(26,12);write(chr(177));
     delay(100);
     gotoxy(27,13);write(chr(177));
      delay(100);
     gotoxy(28,13);write(chr(177));
      delay(100);
// Numero 1.0
    gotoxy(12,14);write(chr(177));
    delay(100);
    gotoxy(12,15);write(chr(177));
    delay(100);
    gotoxy(12,16);write(chr(177));
    delay(100);

    gotoxy(14,16);write(chr(177));
    delay(100);
    gotoxy(17,14);write(chr(177));
    delay(100);
    gotoxy(16,14);write(chr(177));
     delay(100);
    gotoxy(18,14);write(chr(177));
     delay(100);
    gotoxy(16,15);write(chr(177));
    delay(100);
    gotoxy(18,15);write(chr(177));
    delay(100);
    gotoxy(17,16);write(chr(177));
    delay(100);
    gotoxy(16,16);write(chr(177));
    delay(100);
    gotoxy(18,16);write(chr(177));



     delay(1000);
     gotoxy(40,5);write('Mateus Ferreira ');
     delay(1500);
     gotoxy(57,8);write('Joao Almeida');
     delay(1500);
     gotoxy(37,11);write('Arthur Assun‡ao');
     delay(1500);
     gotoxy(58,14);write('Edgar Ferreira');
     delay(1500);
     gotoxy(40,17);write('Vinicius Lehmann');
     delay(1500);
     gotoxy(55,21);write('Professor: Wender Cota');

    readkey;
end;





{------------------------------------------------------------------------------}

begin
repeat

highvideo;
pontos:=0;


{----------Borda Principal-------------}
// Inicio
    textbackground(2);
    clrscr;
    textcolor(15);
    for i := 1 to 30 do
    begin
        gotoxy(i,1); write(chr(205));
        gotoxy(1,1);write(chr(201));
        gotoxy(i,24);write(chr(205));
        gotoxy(30,1);write(chr(203));

    end;
      for i := 31 to 79 do
    begin
        gotoxy(i,1); write(chr(205));
        gotoxy(i,24);write(chr(205));
        gotoxy(80,24);write(chr(188));

    end;
    for i:= 2 to 24 do
    begin
        gotoxy(1,i);write(chr(186));
        gotoxy(1,24);write(chr(200));
        gotoxy(30,i);write(chr(186));
        gotoxy(30,24);write(chr(202));
    end;
    for i:= 2 to 24 do
    begin
        gotoxy(80,1);write(chr(187));
        gotoxy(80,i);write(chr(186));
        gotoxy(80,24);write(chr(188));
    end;


{----------------------------Fim da Borda Principal---------------------------}



{----------------------------------menu de niveis-----------------------------}
    repeat
     gotoxy(51,3); textcolor(7);
     write('HaxRace 1.0');
     gotoxy(32,6);  textcolor(15);
     writeln('Escolha o nivel em que deseja come‡ar:');
     gotoxy(32,9);
     writeln('1: Facil ');
     gotoxy(32,11);
     writeln('2: Medio ');
     gotoxy(32,13);
     writeln('3: Dificil ');
     gotoxy(32,15);
     writeln('4: Extremo ');
     cod:=readkey;

    until (cod='1') or (cod='2') or(cod='3') or(cod='4');
{---------------------------fim do meu de niveis------------------------------}

     clrscr;
{--------------------------recriação Borda Principal--------------------------}
     textbackground(2);
     clrscr;
     textcolor(15);
     for i := 1 to 30 do
     begin
        gotoxy(i,1); write(chr(205));
        gotoxy(1,1);write(chr(201));
        gotoxy(i,24);write(chr(205));
        gotoxy(30,1);write(chr(203));

     end;
       for i := 31 to 79 do
     begin
        gotoxy(i,1); write(chr(205));
        gotoxy(i,24);write(chr(205));
        gotoxy(80,24);write(chr(188));

     end;
     for i:= 2 to 24 do
     begin
        gotoxy(1,i);write(chr(186));
        gotoxy(1,24);write(chr(200));
        gotoxy(30,i);write(chr(186));
        gotoxy(30,24);write(chr(202));
     end;
     for i:= 2 to 24 do
     begin
        gotoxy(80,1);write(chr(187));
        gotoxy(80,i);write(chr(186));
        gotoxy(80,24);write(chr(188));
     end;
{----------------------------Fim da Borda Principal----------------------------}



{------------------------verificaçãoo do nivel escolhido-----------------------}
      case cod of
       '1':begin
             fase:=1;
             velocidade:= 60 ;
             velocidadetexto:=10;
             contfase:=0;
             contvida:=2;
           end;
       '2':begin
            fase:=2;
            velocidade:= 52 ;
             velocidadetexto:=55;
             contfase:=10;
             contvida:=3;
           end;
       '3':begin
            fase:=3;
            velocidade:= 44 ;
            velocidadetexto:=105;
            contfase:=21;
            contvida:=3;
           end;
       '4':begin
            fase:=4;
            velocidade:= 36 ;
            velocidadetexto:=155;
            contfase:=30;
            contvida:=3;
           end;
      end;
{----------------------------fim da verificaçãoo-------------------------------}






{------------------------------------Creditos---------------------------------}
// Inicio
   textcolor(11);
   gotoxy(35,20);
   writeln('Utilize as teclas A e D para movimentar');
   textcolor(15);
{-------------------------------Fim do Creditos--------------------------------}




{--------------------------------------HaxCarro--------------------------------}
// Incio
   x:=13;
   aux:=13;
   x_descendo:=3;
   y_descendo:=2;
   velocidade_troca:=5;




{------------------------ Começo do jogo randomico-----------------------------}
repeat
//Randomiza o número de carros que irão para a tela
     randomize;
     num_carros := random(4)+1;
//Randomiza a posição X do carro e verifica a quantidade que descerá

     if contfase mod 20 = 0 then
      contvida:=contvida+1;
      if contfase = 20 then
        begin
        textcolor(12);
            gotoxy(43,11);
          writeln('Voce ganhou mais uma vida');
          delay(1500);
          gotoxy(43,11);
          writeln('                         ');
        end;

     if (contfase > 40) and (contfase mod 15 = 0) then
      begin
          contvida:= contvida+1;
          textcolor(12);
          gotoxy(43,11);
          writeln('Voce ganhou mais uma vida');
          delay(1500);
          gotoxy(43,11);
          writeln('                         ');
        end;



        textcolor(15);

     contfase:=contfase+1;

     if contfase = 10 then
     fase:= 2
     else
     if contfase=20 then
     fase:=3
     else
     if contfase = 30 then
     fase:=4;

        boo:=true;

     for i:=1 to num_carros do
     begin
            randomize;
            carro_random := random(4)+1;

             case carro_random of
              1 :begin
                 x_descendo := 3;
                 r:=15;
                 b:=-10;
                 c:=15;
                 end;
              2 :begin
                 x_descendo := 8;
                 r:=10;
                 b:=-5;
                 c:=-10;
                 end;
              3 :begin
                 x_descendo := 13;
                 r:=-10;
                 b:=20;
                 c:=-15;
                 end;
              4 :begin
                 x_descendo := 18;
                 r:=5;
                 b:=-10;
                 c:=-10;
                 end;
              5 :begin
                 x_descendo := 23;
                 r:=-5;
                 b:=-10;
                 c:=-5;
                 end;
             end;



       {------condição para numero de carros----}
           case fase of
           1:begin
              r:=0; b:=0;c:=0;
             end;
           2:begin
               b:=0;c:=0;
             end;
           3: c:=0;
           end;
      {-------------fim da condiçãoo--------------}





      {----------condiçãoo para ver se tem carro para decer--------------}

            if i = 1 then
            begin
               carroA:= true; xA_descendo := x_descendo ;
            end;
      {----------------------------fim da condi‡ço----------------------}


     end;

     y_descendo:= 2 ;


{-------------Randomiza as cores---------}
     randomize;
     cor:=random(16);
     while (cor = 2) or (cor = 4) do
     begin
          randomize;
          cor:=random(16);
     end;
{----------------------------------------}





{--------------direciona o movimento do carro do jogador-----------------------}

  repeat  {Repeat que desce os carros randomizados}
   window(1,1,100,100);
     if keypressed then
     case readkey of
     #97,#65 : if x > 3 then begin aux:= x ; x:= x - 5; end;
     #68,#100 : if x < 23 then begin aux:= x; x:= x + 5; end;
     end;
          gotoxy(x,22);
     textcolor(red);writeln('  . ');
     textcolor(0);
          gotoxy(x,22);
     write(' ',chr(22));
     textcolor(red);

     write(chr(178));
     textcolor(0);

     writeln(chr(22));
     textcolor(0);
         gotoxy(x,23);
     write(' ',chr(22));
     textcolor(red);

     write(chr(178));
     textcolor(0);

     writeln(chr(22));
     delay(velocidade_troca);
// Apagando o carro
   if x <> aux then
   begin
          gotoxy(aux,21);
     textcolor(red);writeln('   ');
     textcolor(0);
          gotoxy(aux,22);
     write(' ',chr(32));
     textcolor(red);

     write(chr(32));
     textcolor(0);

     writeln(chr(32));
     textcolor(0);
         gotoxy(aux,23);
     write(' ',chr(32));
     textcolor(red);

     write(chr(32));
     textcolor(0);

     writeln(chr(32));

     end;
// Fim

{-----------fim do codigo quer direicona o carro do jogador--------------------}



// Carros Descendo
// Inicio
// Carro A

{-----------faz a projeção do carro qe dece na tela---------------------------}

   if carroA then
   begin
     if y_descendo < 22 then
     begin

    {-------------ponto que indica frente--------}
     gotoxy(xA_descendo,y_descendo);
     textcolor(cor);writeln('  . ');
     textcolor(0);


     gotoxy(xA_descendo+r,y_descendo);
     textcolor(cor);writeln('  . ');
     textcolor(0);

      gotoxy(xA_descendo+r+b,y_descendo);
     textcolor(cor);writeln('  . ');
     textcolor(0);


     gotoxy(xA_descendo+r+b+c,y_descendo);
     textcolor(cor);writeln('  . ');
     textcolor(0);
    {--------------------------------------------}



    {------------primeira parte do carro-----}
     gotoxy(xA_descendo,y_descendo+1);
     write(' ',chr(22));
     textcolor(cor);

     write(chr(178));
     textcolor(0);

     writeln(chr(22));
     textcolor(0);


     gotoxy(xA_descendo+r,y_descendo+1);
     write(' ',chr(22));
     textcolor(cor);

     write(chr(178));
     textcolor(0);

     writeln(chr(22));
     textcolor(0);


     gotoxy(xA_descendo+r+b,y_descendo+1);
     write(' ',chr(22));
     textcolor(cor);

     write(chr(178));
     textcolor(0);

     writeln(chr(22));
     textcolor(0);


     gotoxy(xA_descendo+r+b+c,y_descendo+1);
     write(' ',chr(22));
     textcolor(cor);

     write(chr(178));
     textcolor(0);

     writeln(chr(22));
     textcolor(0);
    {-----------------------------------------}



   {------------segunda parte do carro---------}
     gotoxy(xA_descendo,y_descendo+2);
      begin
      write(' ',chr(22));
      textcolor(cor);

      write(chr(178));
      textcolor(0);
      writeln(chr(22));



      gotoxy(xA_descendo+R,y_descendo+2);
      write(' ',chr(22));
      textcolor(cor);

      write(chr(178));
      textcolor(0);
      writeln(chr(22));


      gotoxy(xA_descendo+R+b,y_descendo+2);
      write(' ',chr(22));
      textcolor(cor);

      write(chr(178));
      textcolor(0);
      writeln(chr(22));



      gotoxy(xA_descendo+R+b+c,y_descendo+2);
      write(' ',chr(22));
      textcolor(cor);

      write(chr(178));
      textcolor(0);
      writeln(chr(22));


      y_descendo:=y_descendo + 1 ;
      delay(velocidade);

     end;
   {---------------------------------------}




    {-------terceira parte do carro--------}
     gotoxy(xA_descendo,y_descendo-1);
     textcolor(red);writeln('    ');



     gotoxy(xA_descendo+r,y_descendo-1);
     textcolor(red);writeln('    ');


     gotoxy(xA_descendo+r+b,y_descendo-1);
     textcolor(red);writeln('    ');


     gotoxy(xA_descendo+r+b+c,y_descendo-1);
     textcolor(red);writeln('    ');
    {---------------------------------------}

     end;
{----------------------------fim da criação do carro--------------------------}






   {------------apagando o carro para movimentação decendo-----------------}
    if y_descendo = 22 then
       begin

     gotoxy(xA_descendo,y_descendo);
     textcolor(red);write('     ');
     textcolor(0);

     gotoxy(xA_descendo+r,y_descendo);
     textcolor(red);write('     ');
     textcolor(0);

     gotoxy(xA_descendo+r+b,y_descendo);
     textcolor(red);write('     ');
     textcolor(0);

     gotoxy(xA_descendo+r+b+c,y_descendo);
     textcolor(red);write('     ');
     textcolor(0);
   {-----------------------------------------------------}


         gotoxy(xA_descendo,y_descendo+1);
     write(' ',chr(32));
     textcolor(red);

     write(chr(32));
     textcolor(0);

     writeln(chr(32));
     textcolor(0);


     gotoxy(xA_descendo+r,y_descendo+1);
     write(' ',chr(32));
     textcolor(red);

     write(chr(32));
     textcolor(0);

     writeln(chr(32));
     textcolor(0);

         gotoxy(xA_descendo+r+b,y_descendo+1);
     write(' ',chr(32));
     textcolor(red);

     write(chr(32));
     textcolor(0);

     writeln(chr(32));
     textcolor(0);


          gotoxy(xA_descendo+r+b+c,y_descendo+1);
     write(' ',chr(32));
     textcolor(red);

     write(chr(32));
     textcolor(0);

     writeln(chr(32));
     textcolor(0);
   {---------------------------------------------------}



       end;
   end;


      gotoxy(48,12);
      writeln('              ');
      gotoxy(42,13);
      writeln('                            ');





     textcolor(15);
   gotoxy(32,5); writeln('Vidas: ');

         for i:=1 to contvida do
             begin
             textcolor(12);
             gotoxy(37+2*i,5);
             writeln(chr(3));
             end;

      textcolor(15);
    gotoxy(32,3);
   writeln('Estagio: ',fase);

     gotoxy(32,7);
   writeln ('Velocidade: ',velocidadetexto,' km/h ');

     gotoxy(32,9);
   writeln ('Pontos: ',pontos );

       // Fim

{------------------------------------------------------------------------------}



    {----------------condição para ver se o carro bateu----------------------}

     if ((x = xA_descendo)and(y_descendo > 19)) or ((x = (xA_descendo+r))and
     (y_descendo > 19))or ((x = (xA_descendo+r+b))and(y_descendo > 19))or
     ((x = (xA_descendo+r+b+c))and(y_descendo > 19))and boo then
    begin
      gotoxy(48,12);
      textcolor(12);
      writeln('* Voce bateu *');
      gotoxy(42,13);
      writeln('Pressione P para continuar');
      gotoxy(33,20);


      if boo then
      begin
      contvida:=contvida-1;
      gotoxy(39,5);
      writeln('                        ');
      repeat
        boo:=false;
      until readkey = 'p';
      end;
     end;
   {-----------------------------fim da condição---------------------------}



   until y_descendo = 22;
{-------------------fim da criação de movimentos do carro--------------------}





{-------------------Controle de velocidade------------------------}

   if velocidade <> 18 then
   begin
   velocidade:= velocidade - 1 ;
   velocidadetexto:=velocidadetexto +5;
   end;
   if (fase = 1) and (contvida <> 0) and  boo then
   pontos:=pontos + 1
   else
   if (fase = 2) and (contvida <> 0) and  boo then
   pontos:=pontos +2
   else
   if (fase = 3) and (contvida <> 0) and  boo then
   pontos:=pontos +4
   else
   if (fase = 4) and (contvida <> 0) and  boo then
   pontos:=pontos + 6;



until contvida = 0 ; {repeat do random carros}
     textcolor(11);
     gotoxy(9,8);
   writeln ('Fim de jogo');
     gotoxy(6,10);
   writeln ('Voce fez ',pontos,' pontos');
     gotoxy(3,12);
   writeln ('Velocidade Maxima: ',velocidadetexto-5,' km/h');

   repeat
     gotoxy(7,14);
     writeln('Q para sair ');
     gotoxy(7,16);
     writeln('C para continuar');
     continuar:=readkey;
     continuar:=upcase(continuar);
   until (continuar = 'Q') or (continuar = 'C');


until continuar = 'Q'; {repeat do sair}

// Apagando tela de fim de jogo
    gotoxy(9,10);
   writeln ('                 ');
     gotoxy(6,12);
   writeln ('                       ');
     gotoxy(3,14);
   writeln ('                           ');
     gotoxy(5,16);
   writeln('                            ');
     gotoxy(7,18) ;
   writeln('                           ');

   creditos();
end.

{Finalizado no dia 16 de maio de 2011, por alunos do 1º periodo de TSI-IFET.
Agradecimentos extendidos a todos empenhados em sua construção,desde os projetos
feitos em sala de aula, até os mais complicados erros de lógica encontrados. Um
forte abraço.

Mateus Ferreira Silva 1º Periodo TSI - IFET Campus Barbacena }

