%{
#include "myscanner.h"
%}

%START SC_ACNAME SC_PARAMETERS SC_RBRACKET IG_LBREAK

NAME								[a-zA-Z\-]+
TEXT								[a-zA-Z?\-() \t\n]+
TEXTBREAK							[ \t\n]+

	int lb_flag=0;

%%

\(:action													{lb_flag++; BEGIN SC_ACNAME; return ACTION;}
:parameters													{BEGIN SC_PARAMETERS; return PARAMETER;}
<SC_PARAMETERS>{TEXT}										{BEGIN SC_RBRACKET; return PARAMETERS;}	
:precondition												return PRECONDITION;
:effect														return EFFECT;
\(and														{lb_flag++; BEGIN SC_RBRACKET; return CONJUNCTION;}
\(not														{lb_flag++; BEGIN SC_RBRACKET; return NEGATION;}
\({NAME}({TEXTBREAK}\?{NAME})+\)							return PREDICATE;
<SC_ACNAME>.*												{BEGIN IG_LBREAK; return ACTION_NAME;}
<SC_RBRACKET>\)												{if(lb_flag) lb_flag--; if(!lb_flag) BEGIN 0; return RIGHT_BRACKET;}
<SC_PARAMETERS,SC_RBRACKET,SC_ACNAME,IG_LBREAK>{TEXTBREAK}	;	

%%

int yywrap(void)
{
	return 1;
}
