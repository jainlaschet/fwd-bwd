#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <assert.h>

#include "myscanner.h"

#define MAX_SIZE 10000

typedef struct predicate_info{
	// if flag is 1, then it's negated
	int flag;
	char* predicate;
} predicate_info;

extern int yylex();
extern int yylineno;
extern char* yytext;

char* parameter_info;
char* action_prefix;
char* precondition_prefix;
char* effect_prefix;

predicate_info* pre_predicates;
predicate_info* eff_predicates;
predicate_info** act_predicates;

int pre_count;
int eff_count;
int norm_count;
int new_count;


bool pre_and_flag = false;
bool eff_and_flag = false;

void print(char* str)
{
	printf("%s", str);
}

char* append(char* dest, char* source)
{
	// if empty string then copy otherwise append
	if(dest == NULL)
	{
		dest = malloc(MAX_SIZE);
		strcpy(dest, source);
	}
	else
		strcat(dest, source);
	return dest;
}

int scan_predicates(predicate_info* predicates, int rbcount)
{
	bool neg_flag = false;
	int count = 0;

	int ntoken;
	ntoken = yylex();

	
	while(true)
	{
		if(ntoken == NEGATION)
		{
			rbcount++;
			neg_flag = true;
		}
		else if(ntoken == PREDICATE)
		{
			predicates[count].flag = neg_flag;
			predicates[count].predicate = append(predicates[count].predicate, yytext);
			count++;
		}
		else if(ntoken == RIGHT_BRACKET)
		{
			rbcount--;
			neg_flag = false;
		}

		if(rbcount == 0)
			break;
		ntoken = yylex();	
	}
	return count;
}

void normalise_predicates()
{
	// to all in pre not in eff, add directly to eff
	bool flag;
	norm_count = eff_count;

	for (int i = 0; i < pre_count; ++i)
	{
		flag = false;
		for (int j = 0; j < eff_count; ++j)
			if(strcmp(pre_predicates[i].predicate, eff_predicates[j].predicate) == 0)
				flag = true;
		if(!flag)
		{
			eff_predicates[norm_count].predicate = append(eff_predicates[norm_count].predicate, pre_predicates[i].predicate);
			eff_predicates[norm_count].flag = pre_predicates[i].flag;
			norm_count++;
		}
	}
	// to all in eff not in pre, prepare exp generation
	act_predicates = malloc(MAX_SIZE * sizeof(predicate_info**));
	new_count = 0;
	int temp_count = 0;

	for (int i = 0; i < eff_count; ++i)
	{
		flag = false;
		for (int j = 0; j < pre_count; ++j)
			if(strcmp(eff_predicates[i].predicate, pre_predicates[j].predicate) == 0)
				flag = true;

		if(!flag)
		{
			// only copy predicates to action_elements which are distinct
			if(new_count == 0)
			{
				act_predicates[new_count] = malloc(MAX_SIZE * sizeof(predicate_info*));
				act_predicates[new_count][temp_count].flag = 1;
				act_predicates[new_count][temp_count].predicate = append(act_predicates[new_count][temp_count].predicate, eff_predicates[i].predicate);
				new_count++;
				act_predicates[new_count] = malloc(MAX_SIZE * sizeof(predicate_info*));
				act_predicates[new_count][temp_count].flag = 0;
				act_predicates[new_count][temp_count].predicate = append(act_predicates[new_count][temp_count].predicate, eff_predicates[i].predicate);
				new_count++;
			}
			else{
				for (int k = 0; k < new_count; ++k)
				{
					act_predicates[k][temp_count].flag = 1;
					act_predicates[k][temp_count].predicate = append(act_predicates[k][temp_count].predicate, eff_predicates[i].predicate);
					act_predicates[k + new_count] = malloc(MAX_SIZE * sizeof(predicate_info*));
					for (int l = 0; l < temp_count; ++l)
					{
						act_predicates[k + new_count][l].flag = act_predicates[k][l].flag;
						act_predicates[k + new_count][l].predicate = append(act_predicates[k + new_count][l].predicate, act_predicates[k][l].predicate);
					}
					act_predicates[k + new_count][temp_count].predicate = append(act_predicates[k + new_count][temp_count].predicate, eff_predicates[i].predicate);
					act_predicates[k + new_count][temp_count].flag = 0;
				}

				new_count*=2;
			}
			temp_count++;
		}
	}
	assert((temp_count + pre_count) == norm_count);
}

void generate_actions()
{
	/*
	char* parameter_info;
	char* action_prefix;
	char* precondition_prefix;
	char* effect_prefix;
	*/
	bool flag = (norm_count > 1)? true: false;
	for(int i = 0; i < new_count; i++)
	{
		// print action_header
		print(action_prefix);
		printf("-%d\n", i + 1);
		// print parameters
		print(parameter_info);
		// print precondition
		print(precondition_prefix);
		if(flag)
			print("\n(and");
		for (int j = 0; j < norm_count; ++j)
		{
			if(j < pre_count)
			{
				if(pre_predicates[j].flag)
					print("(not");
				print(pre_predicates[j].predicate);
				if(pre_predicates[j].flag)
					print(")");
				print("\n");
			}
			else
			{
				if(act_predicates[i][j - pre_count].flag)
					print("(not");
				print(act_predicates[i][j - pre_count].predicate);
				if(act_predicates[i][j - pre_count].flag)
					print(")");
				print("\n");
			}
		}
		if(flag)
			print(")\n");
		// print effects
		print(effect_prefix);
		if(flag)
			print("\n(and");

		for (int j = 0; j < norm_count; ++j)
		{
			if(eff_predicates[j].flag)
				print("(not");
			print(eff_predicates[j].predicate);
			if(eff_predicates[j].flag)
					print(")");
			print("\n");
		}

		if(flag)
			print(")\n");
		// close action bracket
		print("\n)\n\n");
	}
}

int main(void)
{
	int ntoken, vtoken;

	ntoken = yylex();
	while(ntoken)
	{
		if(ntoken == ACTION)
		{
			// get action header
			action_prefix = append(NULL, yytext);
			append(action_prefix, " ");
			ntoken = yylex();
			assert(ntoken == ACTION_NAME);
			append(action_prefix, yytext);

			// get parameter info
			ntoken = yylex();
			assert(ntoken == PARAMETER);
			parameter_info = append(NULL, yytext);
			ntoken = yylex();
			assert(ntoken == PARAMETERS);
			append(parameter_info, yytext);

			// get precondition info
			ntoken = yylex();
			assert(ntoken == PRECONDITION);
			precondition_prefix = append(NULL, yytext);

			ntoken = yylex();
			if(ntoken == CONJUNCTION)
				pre_and_flag = true;

			pre_predicates = malloc(MAX_SIZE * sizeof(predicate_info*));
			pre_count = scan_predicates(pre_predicates, 2 - pre_and_flag);

			// print("Printing Preconditions: ");
			// for (int i = 0; i < pre_count; ++i)
			// {
			// 	print(pre_predicates[i].predicate);
			// 	printf("Is negated: %d\n", pre_predicates[i].flag);
			// }

			// get effects info
			ntoken = yylex();
			assert(ntoken == EFFECT);
			effect_prefix = append(NULL, yytext);

			ntoken = yylex();
			if(ntoken == CONJUNCTION)
				eff_and_flag = true;

			eff_predicates = malloc(MAX_SIZE * sizeof(predicate_info*));
			eff_count = scan_predicates(eff_predicates, 2 - eff_and_flag);

			// print("\nPrinting Effects: ");
			// for (int i = 0; i < eff_count; ++i)
			// {
			// 	print(eff_predicates[i].predicate);
			// 	printf("Is negated: %d\n", eff_predicates[i].flag);
			// }

			// generate child actions, add appropriate right brackets
			normalise_predicates();

			// print("\nPrinting Normalised Effects: ");
			// for (int i = 0; i < norm_count; ++i)
			// {
			// 	print(eff_predicates[i].predicate);
			// 	printf("Is negated: %d\n", eff_predicates[i].flag);
			// }

			// print("\nPrinting Normalised Preconditions: ");
			// for (int i = 0; i < new_count; ++i)
			// {
			// 	printf("Action #%d: \n", i + 1);
			// 	for (int j = 0; j < norm_count; ++j)
			// 	{
			// 		if(j < pre_count)
			// 		{
			// 			print(pre_predicates[j].predicate);
			// 			printf("Is negated: %d\n", pre_predicates[j].flag);
			// 		}
			// 		else
			// 		{
			// 			print(act_predicates[i][j - pre_count].predicate);
			// 			printf("Is negated: %d\n", act_predicates[i][j - pre_count].flag);
			// 		}
			// 	}
			// 	print("\n");
			// }
			generate_actions();
		}
		else if(ntoken != RIGHT_BRACKET){
			printf("%s", yytext);
		}
		ntoken = yylex();
	}
	return 0;
}
