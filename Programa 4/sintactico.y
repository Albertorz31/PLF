%{
  #include <stdio.h>
  #include <stdlib.h>
  extern int yylex(void);
  extern char *yytext;
  void yyerror(char *s);
%}

%token IDENTIFICADOR 
%token NUMERO_ENTERO
%token NUMERO_REAL
%token CARACTER 
%token MAIN 
%token AUTO 
%token LONG
%token INT 
%token FLOAT
%token CHAR
%token DOUBLE 
%token EXTERN
%token REGISTER 
%token STATIC
%token SHORT
%token UNSIGNED

%token BREAK 
%token CONTINUE 
%token DEFAULT 
%token DO
%token WHILE 
%token FOR 
%token GOTO 
%token IF 
%token ELSE 
%token RETURN 
%token SIZEOF

%left '*'
%left '/'
%left '+'
%left '-'
%left '|'
%left '&'
%right '='
%start Programa  

%%
Programa: MAIN '(' D1 ')' D2 '{' D3 D4 '}'
D1: par_lin_ord | ;
D2: dec_lin_ord | ;
D3: dec_var_loc | ;
D4: D5 | ;
D5: sentencia | sentencia D5;


par_lin_ord: IDENTIFICADOR ',' IDENTIFICADOR ;
dec_lin_ord: declaracion declaracion ;
dec_var_loc: declaracion | declaracion dec_var_loc ;
declaracion: D6 D13 ;
D13: especificacion_declaracion D10 D11 ';' ;
D6: D7 | D8 ;
D7: D9 | D9 D8 ;
D8: tipo ;
D9: esp_alm_var | esp_alm_var D9 ;
D10: inicializacion_variable | ;
D11: D12 | ;
D12: '.' D13 ;

esp_alm_var: AUTO | EXTERN | REGISTER | STATIC ;
tipo: D14 | FLOAT | CHAR | DOUBLE
D14: INT | D15 | D16 | D17 ;
D15: SHORT | SHORT INT ;
D16: UNSIGNED | UNSIGNED INT ;
D17: LONG | LONG INT | LONG FLOAT ;

especificacion_declaracion: nombre_variable | declaracion_puntero | '(' especificacion_declaracion ')' ;
nombre_variable: IDENTIFICADOR ;
declaracion_puntero: '*' especificacion_declaracion ;
inicializacion_variable: '=' D18 ;
D18: valor_inicial | '{' D19 '}' ;
D19: valor_inicial | valor_inicial ',' D19 ;
valor_inicial: expresion ;
sentencia: sentencia_break | sentencia_continue | sentencia_default | bucle_do_while | expresion ';' | bucle_for | sentencia_goto | sentencia_if | etiqueta sentencia | sentencia_NULL | 
           sentencia_return | bucle_while ;
sentencia_break: BREAK ';' ;
sentencia_continue: CONTINUE ';' ;
sentencia_default: DEFAULT ':' sentencia ;
bucle_do_while: DO sentencia WHILE '(' expresion ')' ';' ;
bucle_for: FOR '(' D20 ';' D22 ';' D20 ')' sentencia ;
D20: D21 | ;
D21: expresion | expresion ',' D21 ;
D22: expresion | ;
sentencia_goto: GOTO etiqueta ';' ;
sentencia_if: IF '(' expresion ')' sentencia D23 ;
D23: D24 | ;
D24: ELSE sentencia | ELSE sentencia D24 ;
etiqueta: IDENTIFICADOR ':' ;
sentencia_NULL: ';' ;
sentencia_return: RETURN D25 ';' ;
D25: expresion | ;
bucle_while: WHILE '(' expresion ')' sentencia ;
expresion: expresion operador_binario expresion | operando_expresion | expresion_ternaria | operador_unario expresion | lvalor operador_asignacion expresion | 
           lvalor operador_incremento | lvalor operador_decremento | operador_incremento lvalor | operador_decremento lvalor ;
operador_binario: operador_unario | operador_relacional | operador_logico | operador_aritmetico | operador_nivel_bit ;
operador_unario: cast | operador_sizeof | operador_incremento | operador_decremento | '*' | '&' | '-' | '~' | '|' ;
cast: '(' tipo ')' ;
operador_sizeof: SIZEOF '(' objeto ')' ;
objeto: tipo | expresion ;
operador_incremento: '++' ;
operador_decremento: '--' ;
operador_relacional: '==' | '!=' | '>' | '<' | '<=' | '>=' ;
operador_logico: '&&' | '||' | '!' ;
operador_aritmetico: '*' | '-' | '+' | '/' | '%' ;
operador_nivel_bit: '&' | '|' | '^' | '<<' | '>>' ;
operando_expresion: nombre | constante_numerica | constante_caracter | constante_cadena | '(' expresion ')' ;
nombre: nombre_variable ;
constante_numerica: entero | real ;
constante_caracter:  ''' CARACTER ''' ;
constante_cadena: '"' D28 '"' ;
D28: CARACTER | CARACTER D28 ;
entero: NUMERO_ENTERO;
real: NUMERO_REAL;
expresion_ternaria: '(' expresion ')' '?' expresion ':' expresion ;
lvalor: nombre | ref_dir_ind | '(' lvalor ')' ;
ref_dir_ind: '*' expresion_puntero ;
expresion_puntero: expresion ;
operador_asignacion: D26 '=' ;
D26: D27 | ;
D27: operador_aritmetico | operador_nivel_bit ; 

%%








