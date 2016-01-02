/* contains utility functions to help develop and test the os kernel */

#include "utils.h"
#include "io.h"

int test_sum_three(int arg1, int arg2, int arg3) {
	return arg1 + arg2 + arg3;
}

int test_write_cell() {
	cell c;
	unsigned char bg = TEST_CELL_BG;
	unsigned char fg = TEST_CELL_FG;
	unsigned char blinking = TEST_CELL_BLINKING;
	c.ascii = TEST_CELL_ASCII;
	c.color = MAKE_COLOR(blinking,bg,fg);
	return write_cell(c,TEST_CELL_ROW,TEST_CELL_COL);
}