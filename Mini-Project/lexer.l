%{
#include "parser.tab.h"
int newline_count = 0;
%}

%%

"while"     { newline_count = 0; return WHILE; }

"("         { newline_count = 0; return LPAREN; }
")"         { newline_count = 0; return RPAREN; }

"{"         { newline_count = 0; return LBRACE; }
"}"         { newline_count = 0; return RBRACE; }

";"         { newline_count = 0; return SEMICOLON; }
"="         { newline_count = 0; return ASSIGN; }

"=="|"<"|">"|"!="   { newline_count = 0; return RELOP; }

[a-zA-Z][a-zA-Z0-9]*   { newline_count = 0; return ID; }

\n {
        newline_count++;

        if(newline_count == 3) {
            return 0;   // stop parsing ONLY on 3 continuous blank lines
        }
    }

[ \t]   ;   // ignore spaces

. {
    newline_count = 0;   // reset if any other character appears
    return yytext[0];
}

%%

int yywrap() {
    return 1;
}