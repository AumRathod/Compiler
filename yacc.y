%{
#include<stdio.h>
#include<conio.h>
#include<stdlib.h>
int flag=0;
%}

%token NUMBER PRINT WHITESPACE NEWLINE EXIT HELP STRING OBRACE CBRACE
%token IF THEN ELSE GT LT EQ GE LE NE AND OR EXOR ADD SUB MUL DIV MOD 
%left ADD SUB
%left MUL DIV MOD
%left  OBRACE CBRACE
%%

COMMAND: {printf("$ ");} Expression1 ;

Expression1: errorPrint
            | exit
            | printString 
            | printNumber
            | help
            | ifCondition 
            | ifElseCondition 
            | E 
            ;

errorPrint: STRING NEWLINE 
        {
            printf("Amanya aadesh.Madad mate '--madad' vapro.\n\n");
        } COMMAND;

exit: EXIT NEWLINE 
        {
            printf("Pacha avjo.");
            exit(0);
        };

printString: PRINT WHITESPACE STRING NEWLINE 
                                        {
                                            printf("%s",$3);
                                        } COMMAND;

printNumber: PRINT WHITESPACE E NEWLINE 
                                        {
                                            printf("%d\n", $3); 
                                        } COMMAND;

ifCondition: IF OBRACE CONDITION CBRACE WHITESPACE THEN WHITESPACE Expression1 NEWLINE{
    if($3)
    {
        printf("%d\n",$8); 
    }
    else
    {
        printf("Sachu to nakh.\n");
    }
} COMMAND;

ifElseCondition: IF OBRACE CONDITION CBRACE WHITESPACE THEN WHITESPACE Expression1 WHITESPACE ELSE WHITESPACE Expression1 NEWLINE {
    if($3)
    {
        printf("Sachi sarat ganya baad : %d\n",$8); 
    } 
    else 
    {
        printf("Khoti sarat ganya baad : %d\n",$12);
    }
} COMMAND;

help: HELP NEWLINE
                { 
                    printf("chhapva mate\t:\tchhapi mar string | chhapi mar expression\n");
                    printf("expression\t:\tnum+num || num-num || num*num || num/num || num%cnum || num&num || num|num || num^num || (Expression)\n",'%');
                    printf("jo\t\t:\tjo(condition) to expression\n"); 
                    printf("jo-to-baki\t:\tjo(condition) to expression baki expression\n");
                    printf("madad\t\t:\t--madad\n");
                    printf("bandh krva mate\t:\tEND\n");
                } COMMAND;

E:E ADD E {$$=$1+$3;}
|E SUB E {$$=$1-$3;}
|E MUL E {$$=$1*$3;}
|E DIV E {$$=$1/$3;}
|E MOD E {$$=$1%$3;}
|OBRACE E CBRACE {$$=$2;}
|E AND E {$$=$1&$3;}
|E OR E {$$=$1|$3;}
|E EXOR E {$$=$1^$3;}
| NUMBER {$$=$1;}
;

CONDITION:E GT E {$$ = $1>$3;}
|   E LT E {$$ = $1<$3;}
|   E EQ E {$$ = ($1==$3);}
|   E GE E {$$ = ($1>=$3);}
|   E LE E {$$ = ($1<=$3);}
|   E NE E {$$ = ($1!=$3);}
|   E {$$=$1;}
;

%%

void main()
{
    printf("\nCompiler ma tamaru SWAGAT che.\n\nSTART\n");
    yyparse();
    getch();
}

void yyerror()
{
   yyparse();
}
