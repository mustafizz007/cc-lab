#define UNDEF_TYPE 0
#define INT_TYPE 1
#define REAL_TYPE 2
#define CHAR_TYPE 3
#define FUNCTION_TYPE 4
#define ARRAY_TYPE 5

extern char *typename[];

typedef struct param_list {
    int type;
    struct param_list *next;
} param_list;

typedef struct list_t
{
    char st_name[40];
    int st_type;
    int is_function;
    int param_count;
    param_list *params;
    int array_size;

    struct list_t *next;    
}list_t;

void insert(char* name, int type);
void insert_function(char* name, int return_type, param_list* params, int param_count);
void insert_array(char* name, int type, int size);
list_t* search(char *name);
int idcheck(char* name);
int gettype(char *name);
int typecheck(int type1, int type2);
int check_function_call(char* name, param_list* args, int arg_count);
void enter_scope();
void exit_scope();
param_list* create_param(int type);
void add_param(param_list** head, int type);