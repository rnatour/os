/* header file for utils.c */

/* parameters for testing writing a character to the VGA monitor */
#define TEST_CELL_ASCII 'c'
#define TEST_CELL_ROW 0
#define TEST_CELL_COL 0
#define TEST_CELL_FG 4
#define TEST_CELL_BG 3
#define TEST_CELL_BLINKING 0

/* test to sum 3 numbers and return the result */
int test_sum_three(int arg1, int arg2, int arg3);

/* test to write a character to the VGA monitor
   returns -1 on error, 0 otherwise */
int test_write_cell();