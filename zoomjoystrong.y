%{
    #include <error.h>
    void yyerror(const char* msg);
    int yylex();
    int num_contacts = 0;
%}

%error-verbose
%start script

%union {int i; float f;}

%token END
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

body:       statement | statement body
    ;

end:        END END_STATEMENT
    { return 0 };

statement:  command END_STATEMENT | error
    ;

command:    point | line | circle | rectangle | set_color

point:      POINT INT INT
    { point($2, $3); };

line:       LINE INT INT INT INT
    { line($2, $3, $4, $5); };

circle:     CIRCLE INT INT INT
    { circle($2, $3, $4); };

rectangle:  RECTANGLE INT INT INT
    { rectangle($2, $3, $4); };

set_color:  SET_COLOR INT INT INT
    { set_color($2, $3, $4); };

%%

int main(int argc, char **argv) {
    yyparse();
}
