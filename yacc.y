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
            printf("not recognized command.Use '--help' for getting help\n\n");
        } COMMAND;

exit: EXIT NEWLINE 
        {
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

ifCondition: IF WHITESPACE OBRACE CONDITION CBRACE WHITESPACE THEN WHITESPACE Expression1{
    if($3)
    {
        printf("%d\n",$7); 
    }
} COMMAND;

ifElseCondition: IF OBRACE CONDITION CBRACE WHITESPACE THEN WHITESPACE Expression1 WHITESPACE ELSE WHITESPACE Expression1 NEWLINE {
    if($3)
    {
        printf("After Evaluating TRUE CONDITION : %d\n",$9); 
    } 
    else 
    {
        printf("After Evaluating FALSE CONDITION : %d\n",$13);
    }
} COMMAND;

help: HELP NEWLINE
                { 
                    printf("print\t\t:\tprint string | print expression\n");
                    printf("expression\t:\tnum+num || num-num || num*num || num/num || num%cnum || num&num || num|num || num^num || (Expression)\n",'%');
                    printf("if\t\t:\tif (condition) then expression\n"); 
                    printf("if-else\t\t:\tif (condition) then expression else expression\n");
                    printf("help\t\t:\t--help\n");
                    printf("exit\t\t:\texit\n");
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
    printf("\nWelcome to the compiler\n\nSTART\n");
    yyparse();
    getch();
}

void yyerror()
{
   yyparse();
}
