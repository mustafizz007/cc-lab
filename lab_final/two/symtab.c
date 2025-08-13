#include "symtab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *typename[] = {"UNDEF_TYPE", "INT_TYPE", "REAL_TYPE", "CHAR_TYPE", "FUNCTION_TYPE", "ARRAY_TYPE"};

list_t *head = NULL;
extern int lineno; 
int current_scope = 0;

void enter_scope()
{
    current_scope++;
}

void exit_scope()
{
    current_scope--;
} 

param_list* create_param(int type)
{
    param_list* param = (param_list*)malloc(sizeof(param_list));
    param->type = type;
    param->next = NULL;
    return param;
}

void add_param(param_list** head, int type)
{
    param_list* new_param = create_param(type);
    if (*head == NULL) {
        *head = new_param;
    } else {
        param_list* temp = *head;
        while (temp->next != NULL) {
            temp = temp->next;
        }
        temp->next = new_param;
    }
}

void insert(char* name, int type)
{
    if(search(name)==NULL)
    {
        list_t* temp = (list_t*)malloc(sizeof(list_t));

        strcpy(temp->st_name, name);
        temp->st_type = type;
        temp->is_function = 0;
        temp->param_count = 0;
        temp->params = NULL;
        temp->array_size = 0;

        printf("In line no %d, Inserting %s with type %s in symbol table.\n", lineno, name, typename[type]);

        temp->next = head;
        head = temp;
    }
    else
    {
        printf("In line no %d, Same variable %s is declared more than once.\n", lineno, name);
    }
}

void insert_function(char* name, int return_type, param_list* params, int param_count)
{
    if(search(name)==NULL)
    {
        list_t* temp = (list_t*)malloc(sizeof(list_t));

        strcpy(temp->st_name, name);
        temp->st_type = return_type;
        temp->is_function = 1;
        temp->param_count = param_count;
        temp->params = params;
        temp->array_size = 0;

        printf("In line no %d, Inserting function %s with return type %s and %d parameters.\n", 
               lineno, name, typename[return_type], param_count);

        temp->next = head;
        head = temp;
    }
    else
    {
        printf("In line no %d, Function %s is declared more than once.\n", lineno, name);
    }
}

void insert_array(char* name, int type, int size)
{
    if(search(name)==NULL)
    {
        list_t* temp = (list_t*)malloc(sizeof(list_t));

        strcpy(temp->st_name, name);
        temp->st_type = type;
        temp->is_function = 0;
        temp->param_count = 0;
        temp->params = NULL;
        temp->array_size = size;

        printf("In line no %d, Inserting array %s with type %s and size %d.\n", 
               lineno, name, typename[type], size);

        temp->next = head;
        head = temp;
    }
    else
    {
        printf("In line no %d, Array %s is declared more than once.\n", lineno, name);
    }
}

list_t* search(char *name)
{
    list_t* current = head;

    while(current!=NULL)
    {
       if(strcmp(name, current->st_name)!=0)
        current = current->next;
       else
        break;
    }

    return current;
}

int idcheck(char* name)
{
    if(search(name)==NULL)
    {
        printf("In line no %d, ID %s is not declared.\n", lineno, name);
        return 0;
    }
    else
    {
        return 1;
    }
}

int gettype(char *name)
{
    list_t* temp = search(name);

    if(temp==NULL)
    {
        printf("In line no %d, ID %s is not declared.\n", lineno, name);
        return UNDEF_TYPE;
    }
    else
        return temp->st_type;
}

int typecheck(int type1, int type2)
{
    if(type1==INT_TYPE && type2==INT_TYPE)
        return INT_TYPE;
    else if (type1==REAL_TYPE && type2==REAL_TYPE)
        return REAL_TYPE;
    else if (type1==CHAR_TYPE && type2==CHAR_TYPE)
        return CHAR_TYPE;
    else if ((type1==INT_TYPE && type2==REAL_TYPE) || (type1==REAL_TYPE && type2==INT_TYPE))
        return REAL_TYPE; // Type promotion
    else
    {
        if (type1 > 5 || type1 < 0) type1 = 0;
        if (type2 > 5 || type2 < 0) type2 = 0;

        printf("In line no %d, Data type %s is not compatible with Data type %s.\n", lineno, typename[type1], typename[type2]);
        return UNDEF_TYPE;
    }
}

int check_function_call(char* name, param_list* args, int arg_count)
{
    list_t* func = search(name);
    if (func == NULL) {
        printf("In line no %d, Function %s is not declared.\n", lineno, name);
        return UNDEF_TYPE;
    }
    
    if (!func->is_function) {
        printf("In line no %d, %s is not a function.\n", lineno, name);
        return UNDEF_TYPE;
    }
    
    if (func->param_count != arg_count) {
        printf("In line no %d, Function %s expects %d parameters but got %d.\n", 
               lineno, name, func->param_count, arg_count);
        return UNDEF_TYPE;
    }
    
    // Check parameter types
    param_list* expected = func->params;
    param_list* actual = args;
    int i = 0;
    
    while (expected != NULL && actual != NULL) {
        if (typecheck(expected->type, actual->type) == UNDEF_TYPE) {
            printf("In line no %d, Parameter %d type mismatch in function %s call.\n", 
                   lineno, i+1, name);
        }
        expected = expected->next;
        actual = actual->next;
        i++;
    }
    
    return func->st_type;
}

