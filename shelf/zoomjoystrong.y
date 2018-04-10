%{
    #include <stdlib.h>
    #include <error.h>
    #include "zoomjoystrong.h"
    #include "zoomjoystrong.tab.h"
    void yyerror(const char* msg);
    int yylex();

%}

%error-verbose
%start script

%union { float f; int i; char* str; }

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token ERR
%token INT
%token FLOAT

%type<f> FLOAT
%type<i> INT 

%%
script:     body end;
body:       statement END_STATEMENT | body statement END_STATEMENT;
point:      POINT INT INT
    {

        point($2, $3);
    };
line:       LINE INT INT INT INT
    {


        line($2, $3, $4, $5);
    };
circle:     CIRCLE INT INT INT
    {



        circle($2, $3, $4);
    };
rectangle:  RECTANGLE INT INT INT INT
    {


        rectangle($2, $3, $4, $5);
    };
set_color:  SET_COLOR INT INT INT
    {
        if (0 < $2 && 256 > $2 &&
            0 < $3 && 256 > $3 &&
            0 < $4 && 256 > $4) {
            set_color($2, $3, $4);
        } else {
            error(1, 1, "Color value out of range!");
            exit(EXIT_FAILURE);
        }      
    };
statement:  point | line | circle | rectangle | set_color
    {}
end:        END END_STATEMENT 
   {return 0;};


