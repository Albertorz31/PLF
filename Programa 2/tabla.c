#include<string.h>
#include<stdlib.h>
#include<stdio.h>

void diagramaTabla();

int main(){
	diagramaTabla();
	return 0;
}


void diagramaTabla(){
	int i,j;
	int tabla[2][11];
	for(i=0;i<2;i++){
		for(j=0;j<11;j++){
			if((i==0 && j==0) || (i==0 && j==10)){
				tabla[i][j]=0;      //Sero indica que en esa posicion marca error 
			}else if(i==1 && j==10){
				tabla[i][j]=7;     // 7 indica la frase "aceptar", es decir indicara que la palabra es aceptada
			}else{
				tabla[i][j]=2;    //Indica que para culaquier otra posicion irá al estado 2
			}
		}
	}
	char val[100000];
	int entrada;
	int estado=1; //Comienza del estado 1
	printf("Ingrese Palabra:");
	scanf("%s",val);
	for(i=0;i<strlen(val);i++){
		if(val[i]=='0' && estado!=1){
			entrada=0;
		}else if(val[i]=='1'){
			entrada=1;
		}else if(val[i]=='2'){
			entrada=2;
		}else if(val[i]=='3'){
			entrada=3;
		}else if(val[i]=='4'){
			entrada=4;
		}else if(val[i]=='5'){
			entrada=5;
		}else if(val[i]=='6'){
			entrada=6;
		}else if(val[i]=='7'){
			entrada=7;
		}else if(val[i]=='8'){
			entrada=8;
		}else if(val[i]=='9'){
			entrada=9;
		}else{
			printf("Error\n");
			estado=0;
			break;
		}
		estado=tabla[estado-1][entrada];
		if(estado==0){
			printf("Error\n");
			break;
		}	
	}
	if(estado==2){
		printf("Aceptar\n");
	}		
}








