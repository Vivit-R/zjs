%{
    #include "zoomjoystrong.h"
    #include <stdlib.h>
    #include "zoomjoystrong.tab.h"
%}

%option noyywrap

%%
;               { return END_STATEMENT; }
end             { return END; }
point           { return POINT; } 
line            { return LINE; }
circle          { return CIRCLE; }
rectangle       { return RECTANGLE; }
set_color       { return SET_COLOR; }
[0-9]+\.[0-9]+  { yylval.f = atof(yytext, NULL); return FLOAT; }
[0-9]+          { yyval.i = atoi(yytext); return INT; }
[ \t\n]+        ;
.+              { return ERR; }
%%
