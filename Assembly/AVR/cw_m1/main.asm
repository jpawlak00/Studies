 /*
 * cw_m1 .asm
 *
 *  Created: 10/6/2021 3:43:31 PM
 *   Author: student
 */ 

.macro LOAD_CONST
ldi @0, high(@2)
ldi @1, low(@2)
.endmacro

LOAD_CONST R17, R16, 1234
