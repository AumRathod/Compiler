%{
/* Definition section */
#include<stdio.h>
#include "y.tab.h"
extern int yylval;
%}

HELP "--madad"
PRINT "chhapi mar"
WHITESPACE " "
IF "jo"
THEN "to"
ELSE "baki"
GT	">"
LT	"<"
EQ	"=="
GE	">="
LE	"<="
NE	"!="
NEWLINE "\n"
EXIT "END"
ADD "+"
SUB	"-"
MUL	"*"
DIV	"/"
MOD	"%"
AND	"&"
ANDAND	"ane"
OROR	"kato"
OR	"|"
EXOR "^"
OBRACE "("
CBRACE ")"
NUMBER [0-9]+
STRING [A-Za-z0-9]*
/* Rule Section */
%%



{HELP} {
	return HELP;
}

{ADD} {
	return ADD;
}

{SUB} {
	return SUB;
}

{MUL} {
	return MUL;
}

{DIV} {
	return DIV;
}

{MOD} {
	return MOD;
}

{AND} {
	return AND;
}

{OR} {
	return OR;
}

{ANDAND} {
	return ANDAND;
}

{OROR} {
	return OROR;
}

{EXOR} {
	return EXOR;
}

{PRINT} {
	return PRINT;
}

{WHITESPACE} {
	return WHITESPACE;
}

{NEWLINE} {
	return NEWLINE;
}

{EXIT} {
	return EXIT;
}

{IF} {
	return IF;
}

{THEN} {
	return THEN;
}

{ELSE} {
	return ELSE;
}

{GT}	{
	return GT;
}

{LT}	{
	return LT;
}

{EQ}	{
	return EQ;
}

{GE}	{
	return GE;
}

{LE}	{
	return LE;
}

{NE}	{
	return NE;
}

{OBRACE} {
	return OBRACE; 
}

{CBRACE} {
	return CBRACE;
}

{NUMBER} {
	yylval=atoi(yytext);
	return NUMBER;
}
[\t] ;

{STRING} {
	yylval=yytext;
	return STRING;
}

. return yytext[0];

%%

int yywrap()
{
return 1;
}
