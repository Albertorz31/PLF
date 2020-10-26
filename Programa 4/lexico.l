%option yylineno
%option noyywrap

%{

#include <stdio.h>
#include <string.h>
#include "sintactico.tab.h"
extern int yyparse();
%}
%%
digito [0-9]
letra [a-zA-Z]
simbolo [ #$%&()*+-./:!;<=>?@[\],_{}]
identificador _?{letra}(_?({letra}|{digito}))*
numero_entero {digito}+
exponente "E"{numero_entero} | "E+"{numero_entero} | "E-"{numero_entero}
numero_real {numero_entero}"."{numero_entero} | {numero_entero}"."{exponente} | {numero_entero}"."
caracter {letra}|{digito}|{simbolo}
nopalabra [^{identificador}]
%%

"." {return '.';}
"," {return ',';}
";" {return ';';}
":" {return ':';}
"{" {return '{';}
"}" {return '}';}
"*" {return '*';}
"=" {return '=';}
"(" {return '(';}
")" {return ')';}

"&" {return '&';}
"-" {return '-';}
"~" {return '~';}
"|" {return '|';}
"++" {return '++';}
"--" {return '--';}
"==" {return '==';}
"!=" {return '!=';}
"<" {return '<';}
">" {return '>';}
"<=" {return '<=';}
">=" {return '>=';}
"&&" {return '&&';}
"||" {return '||';}
"!" {return '!';}

"+" {return '+';}
"/" {return '/';}
"%" {return '%';}
"^" {return '^';}
"<<" {return '<<';}
">>" {return '>>';}
"?" {return '?';}

"main" {return MAIN;}
"auto" {return AUTO;}
"extern" {return EXTERN;}
"register" return REGISTER;}
"static" {return STATIC;}
"short" {return SHORT;}
"unsigned" {return UNSIGNED;}
"long" {return LONG;}
"int" {return INT;}
"float" {return FLOAT;}
"char" {return CHAR;}
"double" {return DOUBLE;}

"break" {return BREAK;}
"continue" {return CONTINUE;}
"default" {return DEFAULT;}
"do" {return DO;}
"while" {return WHILE;}
"for" {return FOR;}
"goto" {return GOTO;}
"if" {return IF;}
"else" {return ELSE;}
"return" {return RETURN;}
"sizeof" {return SIZEOF;}

{identificador} {return IDENTIFICADOR;}
{numero_entero} {return NUMERO_ENTERO;}
{numero_real} {return NUMERO_REAL;}
{caracter} {return CARACTER;}
<<EOF>> {yyterminate();}
{digito} {}
{nopalabra} {}

%%

void yyerror(char *s){
  printf("Error sint%cctico en la l%cnea: %d\n",160,161,yylineno);
}

int existeArchivo(char* nombre){
   FILE* archivo =NULL;
   archivo = fopen(nombre,"r");
   if(archivo==NULL)
      return 0; 
   else{
      fclose(archivo);
      return 1;
   } 
   return 0;
}

int main(int argc,char** argv){
	int i=0;
  if(argc ==1){
    printf("Error: Falta par%cmetro en la l%cnea de comandos.\nUso: sintactico.exe archivo\n",160,161);
    return 1;
  }
  else if(argc > 2){
    printf("Error: Demasiados par%cmetros en la l%cnea de comandos.\nUso: sintactico.exe archivo\n",160,161);
    return 1;
  }
  else if(existeArchivo(argv[1])==0){
      printf("Error: El archivo de entrada no existe.\n");
      return 0;
  }
	yyin = fopen(argv[1],"r");
	i = yyparse();
  fclose(yyin);
	if(i==0){
    printf("An%clisis sint%cctico concluido.\n",160,160);
  }
  return 0;
  
}