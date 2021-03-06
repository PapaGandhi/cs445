%{
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "tree.h"
#include "y.tab.h"

%}

number      [0-9]+
whitespace  [ \t]+
ident       [A-Za-z][A-Za-z0-9]*
comment     \{[^{]*\}
comment2    \(\*.*\*\)

%%

{whitespace}    ;

{comment}   { fprintf(stderr, "Comment"); }
{comment2}  { fprintf(stderr, "Comment"); }

"program"   { fprintf(stderr, "[PROGRAM]"); return PROGRAM; }
"var"       { fprintf(stderr, "[VAR]"); return VAR; }
"array"     { fprintf(stderr, "[ARRAY]"); return ARRAY; }
"of"        { fprintf(stderr, "[OF]"); return OF; }
"procedure" { fprintf(stderr, "[PROCEDURE]"); return PROCEDURE; }
"function"  { fprintf(stderr, "[FUNCTION]"); return FUNCTION; }
"begin"     { fprintf(stderr, "[BEGIN]"); return BBEGIN; }
"end"       { fprintf(stderr, "[END]"); return END; }
"integer"   { fprintf(stderr, "[INTEGER]"); return INTEGER; }
"real"      { fprintf(stderr, "[REAL]"); return REAL; }
"if"        { fprintf(stderr, "[IF]"); return IF; }
"then"      { fprintf(stderr, "[THEN]"); return THEN; }
"else"      { fprintf(stderr, "[ELSE]"); return ELSE; }
"while"     { fprintf(stderr, "[WHILE]"); return WHILE; }
"do"        { fprintf(stderr, "[DO]"); return DO; }
"for"       { fprintf(stderr, "[FOR]"); return FOR; }
"to"        { fprintf(stderr, "[TO]"); return TO; }
".."        { return DOTDOT; }

":="        { fprintf(stderr, "[ASSIGNOP]"); return ASSIGNOP; }

"="         { fprintf(stderr, "[RELOP:%d]", yylval.opval = EQ); return RELOP; }
"<>"        { fprintf(stderr, "[RELOP:%d]" , yylval.opval = NE); return RELOP; }
"<"         { fprintf(stderr, "[RELOP:%d]" , yylval.opval = LT); return RELOP; }
"<="        { fprintf(stderr, "[RELOP:%d]", yylval.opval = LE); return RELOP; }
">"         { fprintf(stderr, "[RELOP:%d]" , yylval.opval = GT); return RELOP; }
">="        { fprintf(stderr, "[RELOP:%d]" , yylval.opval = GE); return RELOP; }

"+"         { fprintf(stderr, "[ADDOP:%d]" , yylval.opval = PLUS); return ADDOP; }
"-"         { fprintf(stderr, "[ADDOP:%d]" , yylval.opval = MINUS); return ADDOP; }
"or"        { fprintf(stderr, "[ADDOP:%d]" , yylval.opval = OR); return ADDOP; }

"*"         { fprintf(stderr, "[MULOP:%d]" , yylval.opval = STAR); return MULOP; }
"/"         { fprintf(stderr, "[MULOP:%d]" , yylval.opval = SLASH); return MULOP; }
"and"       { fprintf(stderr, "[MULOP:%d]" , yylval.opval = AND); return MULOP; }

"^"         { fprintf(stderr, "[EXP:%d]", yylval.opval = CARROT);  return EXP; }

"not"       { fprintf(stderr, "[NOT:%d]" , NOT); return NOT; }

{number}    { fprintf(stderr, "[INUM:%d]", yylval.ival = atoi(yytext)); return INUM; }
{number}"."{number}  { fprintf(stderr, "[RNUM:%f]", yylval.rval = atof(yytext)); return RNUM; }

{ident}     { fprintf(stderr,"[ID:%s]", yylval.sval = strdup(yytext)); return ID; }

\n          { fprintf(stderr,"\n"); }
.           { fprintf(stderr,"{%c}", yytext[0]); return yytext[0]; }

%%

int yyerror( char *msg)
{
    fprintf(stderr, "Error: %s\n", msg);
}