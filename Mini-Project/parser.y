%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();

int valid = 1;
%}

%token WHILE ID RELOP ASSIGN SEMICOLON LPAREN RPAREN LBRACE RBRACE

%%

S : WHILE LPAREN E RPAREN S
  | LBRACE S RBRACE
  | ID ASSIGN ID SEMICOLON
  ;

E : ID RELOP ID
  ;

%%

void yyerror(const char *s) {
    valid = 0;
}

int main() {
    printf("Paste While Loop Code (Press ENTER 3 times to finish):\n");

    yyparse();

    if(valid)
        printf("\nValid While Loop\n");
    else
        printf("\nInvalid While Loop\n");

    printf("\nPress Enter to exit...");
    getchar(); getchar(); // keep screen open

    return 0;
}