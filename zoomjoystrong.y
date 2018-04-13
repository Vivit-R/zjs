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
    { return 0; };

statement:    point END_STATEMENT 
            | line END_STATEMENT
            | circle END_STATEMENT
            | rectangle END_STATEMENT
            | set_color END_STATEMENT
            | foo END_STATEMENT
    ;

point:      POINT INT INT
    {
        if ($2 > WIDTH || $3 > HEIGHT || $2 < 0 || $3 < 0) {
            printf("Coordinates out of bounds!\n");                                                                        
        } else {
            point($2, $3); 
        }
    }
    ;

line:       LINE INT INT INT INT
    {
        if ($2 > WIDTH || $3 > HEIGHT || $2 < 0 || $3 < 0 || $3 > WIDTH || $4 > HEIGHT || $3 < 0 || $4 < 0) {
                printf("Coordinates out of bounds!\n");                                                                        
        } else {
            line($2, $3, $4, $5);
        }
    }
    ;

circle:     CIRCLE INT INT INT
    {
        if ($2 > WIDTH || $3 > HEIGHT) { // || $2 + $4 > WIDTH || $3 + $4 > HEIGHT || $2 + $4 < WIDTH || $3 + $4 < HEIGHT || $2 - $4 < 0 || $2 + $4 < 0 || $3 - $4 < 0 || $3 + $4 < 0 || $3 < 0 || $4 < 0) {
            printf("Coordinates out of bounds!\n");
        } else {
            circle($2, $3, $4);
        }
    }
    ;

rectangle:  RECTANGLE INT INT INT INT
    {
        if ($2 >= WIDTH || $3 >= HEIGHT || $4 >= WIDTH || $5 >= HEIGHT) {
            printf("Coordinates out of bounds!\n");                                                                        
        } else {
            rectangle($2, $3, $4, $5); 
        }
    }
    ;

set_color:  SET_COLOR INT INT INT
    {
        if ($2 < 0 || $2 >= 256 || $3 < 0 || $3 >= 256 || $4 < 0 || $4 >= 256) {
            printf("Please name a valid 42-bit RGB color.\n");
        } else {
            set_color($2, $3, $4);
        }
    }
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
