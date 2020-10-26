#include<string.h>
#include<stdlib.h>
#include<stdio.h>

void diagrama();



int main(){
	diagrama();
	return 0;
}


void diagrama(){
	char val[1000000];
	int respuesta,i=0;
	int estado=1;   //Se comienza del estado inicial
	printf("Ingrese Palabra:");
	scanf("%s",val);
	for(i==0;i<strlen(val);i++){
		if(estado==1){
			if(val[i]=='1' || val[i] == '2' || val[i]=='3' || val[i]=='4' || val[i]=='5' || val[i]=='6' || val[i]=='7' || val[i]=='8' || val[i]=='9'){
				respuesta=0;
				estado=2;   //Paso al segundo estado si el estado inicial es correcto
			}else{
				respuesta=1;
				break;
			}
		}else if(estado==2){
			if(val[i]=='0' || val[i]=='1' || val[i] == '2' || val[i]=='3' || val[i]=='4' || val[i]=='5' || val[i]=='6' || val[i]=='7' || val[i]=='8' || val[i]=='9'){
				respuesta=0;
				estado=2;
			}else{
				respuesta=1;
				break;
			}
	    }
	}
	if(respuesta==0 && estado==2){    //Verifica tambien que este en el estado final
		printf("Aceptar\n");
	}else{
		printf("Error\n");
	}	
}




