%{
    #include <stdlib.h>
    #include "zoomjoystrong.tab.h"
%}

%option noyywrap

%%

[0-9]+\.[0-9]+          { yylval.f = atof(yytext); return FLOAT; }
[0-9]                   { }
end;                    { return END; }
;                       { return END_STATEMENT; }
point                   { return POINT; }
circle                  { return CIRCLE; }
rectangle               { return RECTANGLE; }
[ \t\n]                 ;
.                       { return ERROR;}
%%
