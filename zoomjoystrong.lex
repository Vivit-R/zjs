%{
    #include <stdlib.h>
    #include "zoomjoystrong.tab.h"
    #include "zoomjoystrong.h"
%}

%option noyywrap

%%
[0-9]+\.[0-9]+          { printf("float\n"); yylval.f = atof(yytext); return FLOAT; }
[0-9]\+                 { printf("int\n"); yylval.i = atoi(yytext); return INT; }
\;                      { return END_STATEMENT; }
point                   { return POINT; }
circle                  { return CIRCLE; }
rectangle               { return RECTANGLE; }
                      { return END; }
\                       { return SEPARATOR; }
[\t\n]                 ;
%%
