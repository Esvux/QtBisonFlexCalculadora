%{

/*-----------------------------------
|        Declaraciones en C          |
------------------------------------*/
#include <stdio.h>
#include <stdlib.h>
#include <QString>
#include <math.h>
#include "scanner.h"
extern int yylex(void);
extern int linea;
void yyerror(char *s);
QString resultado;

%}

/*-----------------------------------
|      Declaraciones de Bison        |
------------------------------------*/
//Atributos
%union{
  double decimal;
  int entero;
  struct{
    char cadena[255];
    double valor;
  } atributos;
}

//Terminales
%token <decimal> numero 
%token suma resta multiplica divide pizq pder

//No terminales
%type <atributos> INICIO EXPRESION TERMINO FACTOR

%% //<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

/*-----------------------------------
|        Gramática no ambigua        |
|------------------------------------|
|             S -> E                 |
|             E -> E + T             |
|               |  E - T             |
|               |  T                 |
|             T -> T * F             |
|               |  T / F             |
|               |  F                 |
|             F -> ( E )             |
|               |  num               |
------------------------------------*/

INICIO 
: EXPRESION 
    { 
      $$ = $1; 
      sprintf($$.cadena, "%s = %.f\n", $1.cadena, $1.valor );
      resultado =  QString::fromUtf8($$.cadena);
    };

EXPRESION
: EXPRESION suma TERMINO 
    { 
      $$.valor = $1.valor + $3.valor; 
      sprintf($$.cadena, "%s+%s", $1.cadena, $3.cadena);
    }
| EXPRESION resta TERMINO 
    { 
      $$.valor = $1.valor - $3.valor; 
      sprintf($$.cadena, "%s-%s", $1.cadena, $3.cadena);
    }
|
  TERMINO
    {
      $$ = $1;
    };

TERMINO
: TERMINO multiplica FACTOR
    { 
      $$.valor = $1.valor * $3.valor; 
      sprintf($$.cadena, "%s*%s", $1.cadena, $3.cadena);
    }
| TERMINO divide FACTOR
    { 
      $$.valor = $1.valor / $3.valor; 
      sprintf($$.cadena, "%s/%s", $1.cadena, $3.cadena);
    }
| FACTOR 
    {
      $$ = $1;
    };

FACTOR
: pizq EXPRESION pder 
    { 
      $$.valor = $2.valor;
      sprintf($$.cadena, "(%s)", $2.cadena);
    }
| numero 
    { 
      $$.valor = $1; 
      sprintf($$.cadena, "%.f", $1); 
    };

%% //<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

/*-----------------------------------
|         Código C adicional         |
------------------------------------*/
void yyerror(char *s)
{
  printf("Error sintactico: %s",s);
}