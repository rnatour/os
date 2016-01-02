#include "io.h"

int write_cell(cell c, int row, int col) {

	if (row < 0 || row >= NUM_ROWS) {
		return -1;
	}

	else if (col < 0 || col >= NUM_COLS) {
		return -1;
	}

	cell* buffer = (cell*) VGA_FRAMEBUFFER_BASE;
	int index = row*NUM_COLS + col;
	buffer[index] = c;
	return 0;
}