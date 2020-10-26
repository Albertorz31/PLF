%option noyywrap
digito [0-9]
letra [a-zA-Z]
identificador _?{letra}(_?({letra}|{digito}))*
puntuacion "."|","|"{"|"}"|"*"|"="|"("|")"
nopalabra [^{identificador}]
%%
"main" {fprintf(yyout,"MAIN\n");}
"auto" {fprintf(yyout,"AUTO\n");}
"extern" {fprintf(yyout, "EXTERN\n");}
"register" {fprintf(yyout,"REGISTER\n");}
"static" {fprintf(yyout,"STATIC\n");}
"short" {fprintf(yyout,"SHORT\n");}
"unsigned" {fprintf(yyout,"UNSIGNED\n");}
"long" {fprintf(yyout,"LONG\n");}
"int" {fprintf(yyout,"INT\n");}
"float" {fprintf(yyout,"FLOAT\n");}
"char" {fprintf(yyout,"CHAR\n");}
"double" {fprintf(yyout,"DOUBLE\n");}
{identificador} {fprintf(yyout,"IDENTIFICADOR\n");}
{puntuacion} {fprintf(yyout, "%s\n",yytext);}
<<EOF>> {yyterminate();}
{digito} {}
{nopalabra} {}
%%

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
int validarEntradas(int argc,char** argv){
    //Caso 1
    if(argc == 1){
    	printf("Error: Faltan par%cmetros en la l%cnea de comandos.\n",160,161);
        printf("Uso: lexico.exe archivo_entrada archivo_salida\n");
        return 0;
    }
    //Caso 2
    if(argc==2){
    	printf("Error: Falta par%cmetro en la l%cnea de comandos.\n",160,161);
        printf("Uso: lexico.exe archivo_entrada archivo_salida\n");
        return 0;
    }
    //Caso 3
    if( argc > 3 ){
        printf("Error: Demasiados par%cmetros en la l%cnea de comandos.\n",160,161);
        printf("Uso: lexico.exe archivo_entrada archivo_salida\n");
        return 0;
    }
    //Caso 4
    if(existeArchivo(argv[1])==0){
    	printf("Error: El archivo de entrada no existe.\n");
        return 0;
    }
    //Caso 5
    if (existeArchivo(argv[2]) == 1)    {
        printf("Error: El archivo de salida ya existe.\n");
        return 0;
    }
    return 1;
}
int main(int argc,char** argv){
	if(!validarEntradas(argc,argv)){
		return 0;
	}
	yyin = fopen(argv[1],"r");
	yyout = fopen(argv[2],"w");
	yylex();
	return 1;
}