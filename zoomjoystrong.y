%{
    #include <stdlib.h>
    #include <error.h>
    #include "zoomjoystrong.h"
    void yyerror(const char* msg);
    int yylex();
    void check_bounds(int x, int y);
    void check_bounds(int x, int y) {
        if ($2 > WIDTH || $2 < 0 || $3 > HEIGHT || $3 < 0) {
            error("Given coordinates are out of bounds!");
            exit(EXIT_FAILURE);
        }
    }
%}

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
        check_bounds($2, $3);
        point($2, $3);
    };
line:       LINE INT INT INT INT
    {
        check_bounds($2, $3);
        check_bounds($2+$4, $3+$5);
        line($2, $3, $4, $5);
    };
circle:     CIRCLE INT INT INT
    {
        check_bounds($2, $3);
        check_bounds($2+$4, $3+$4);
        check_bounds($2-$4, $3-$4);
        circle($2, $3, $4);
    };
rectangle:  RECTANGLE INT INT INT INT
    {
        check_bounds($2, $3);
        check_bounds($2+$4, $3+$5);
        rectangle($2, $3, $4, $5);
    };
set_color:  SET_COLOR INT INT INT
    {
        if (0 < $2 < 256 &&
            0 < $3 < 256 &&
            0 < $4 < 256) {
            set_color($2, $3, $4);
        } else {
            error("Color value out of range!");
            exit(EXIT_FAILURE);
        }      
    };
statement:  point | line | circle | rectangle | set_color
    {}
end:        END END_STATEMENT 
   {return 0;};


