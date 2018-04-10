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
script:     body end;

int:        INT SEPARATOR | INT END_STATEMENT
    { $1; };
float:      FLOAT SEPARATOR | INT END_STATEMENT
    { $1; };

body:       statement | statement body;

end:        END
    { printf("the end\n");
    return 0; };

statement:  command end_statement
    {printf( "statement");};

end_statement:  END_STATEMENT
    {};

command:    point | line | circle | rectangle | set_color
    {printf( "command");};

point:      POINT int int
    { point($2, $3); };

line:       LINE int int int int
    { line($2, $3, $4, $5); };

circle:     CIRCLE int int int
    { circle($2, $3, $4); };

rectangle:  RECTANGLE int int int int
    { rectangle($2, $3, $4, $5); };

set_color:  SET_COLOR int int int
    { set_color($2, $3, $4); };

%%

int main(int argc, char **argv) {
    yyparse();
}

void yyerror(const char* msg) {
    error(1, 1, "%s\n", msg);
}
