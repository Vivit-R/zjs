%{
    #include <error.h>
    #include <stdio.h> // delet this
    #include "zoomjoystrong.h"
    #include "zoomjoystrong.tab.h"
    void yyerror(const char* msg);
    int yylex();
    int num_contacts = 0;
%}

%error-verbose
%start script

%union {int i; float f; }

%token FOO
%token END
%token SEPARATOR
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT
%token ERROR

%type<i> INT
%type<f> FLOAT

%%
script:     body end
    ;

body:       statement | body statement
    ;

end:        END
    { printf("the end\n");
    return 0; };

statement:    point END_STATEMENT 
            | line END_STATEMENT
            | circle END_STATEMENT
            | rectangle END_STATEMENT
            | set_color END_STATEMENT
            | foo END_STATEMENT
    {printf( "statement\n");}
    ;

point:      POINT INT INT
    { point($2, $3); }
    ;

line:       LINE INT INT INT INT
    { line($2, $3, $4, $5); }
    ;

circle:     CIRCLE INT INT INT
    { circle($2, $3, $4); }
    ;

rectangle:  RECTANGLE INT INT INT INT
    { rectangle($2, $3, $4, $5); }
    ;

set_color:  SET_COLOR INT INT INT
    { set_color($2, $3, $4); }
    ;

foo:        FOO
    { printf("foo!\n"); }
    ;

%%

int main(int argc, char **argv) {
    yyparse();
}

void yyerror(const char* msg) {
    error(1, 1, "%s\n", msg);
}
