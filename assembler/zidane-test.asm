.org 0                      # Memory begins at location 0x00000000
Main:                                                     
    addi $v0, $zero, 10     # $v0 = 10                     ; 2002000a
    addi $v1, $zero, 15     # $v1 = 15                     ; 2003000f
    sub $v0, $v0, $v1       # $v0 = $v0 - $v1              ; 00431022
End:  .end                  