#
# This program is machine encoded in program.dat
#
.org 0                      # Memory begins at location 0x00000000
Main:                                                      # MIPS machine code
    addi $v0, $zero, 10     # $v0 = 10                     ; 2002000a
    addi $v1, $zero, 15     # $v1 = 15                     ; 2003000f
    mult $v0, $v1           # $HiLo = $v0 * $v1            ; 00620018
    mfhi $v0                # $v0 = HiLo[(n-1):0]          ; 00001010
    mflo $v1                # $v1 = HiLo[(2*n-1):n]        ; 00001110
    sw $v0, 84($zero)       # store sum in mem[84] = 0x96  ; ac020054
End:  .end                  # final sum in LSB of 4th word from top.