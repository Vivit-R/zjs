%{
    #include <stdlib.h>
    #include <stdio.h>
    #include "zoomjoystrong.tab.h"
    #include "zoomjoystrong.h"
%}

%option noyywrap

%%
[0-9]+\.[0-9]+          { yylval.f = atof(yytext); return FLOAT; }
[0-9]+                  { yylval.i = atoi(yytext); return INT; }
;                       { return END_STATEMENT; }
point                   { return POINT; }
line                    { return LINE; }
set_color               { return SET_COLOR; }
circle                  { return CIRCLE; }
rectangle               { return RECTANGLE; }
foo                     { return FOO; }
[ \t\n]                  ;
<<EOF>>                  { return END; }
.                        ;
%%
