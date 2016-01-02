/* header file for io.c */

//VGA framebuffer base address
#define VGA_FRAMEBUFFER_BASE 0xB8000 

// constructs attribute header for VGA cell
#define MAKE_COLOR(blinking,bg,fg) ( ((blinking & 0x80) << 7) | \
									 ((bg & 0x07) << 4) | \
									 (fg & 0x0F) \
								   )

//number of rows and columns in this monitor setup
#define NUM_ROWS 25
#define NUM_COLS 80

/* packed struct representing a single cell on the VGA monitor
   cell is formatted as follows: 
   l b b b f f f f a a a a a a a a
   15    12      8               0
   where
   l - blinking or not bit
   b - background color
   f - foreground color
   a - ascii character */
struct __attribute__ ((__packed__)) cell_struct {
	unsigned char ascii;
	unsigned char color;
};
typedef struct cell_struct cell;

/* writes a single cell to the VGA monitor at row row and column col
   requires 0 <= NUM_ROWS < 25 and 0 <= col < NUM_COLS
   returns -1 on error, 0 otherwise */
int write_cell(cell c, int row, int col);