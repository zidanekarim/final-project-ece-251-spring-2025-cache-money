addi $2,$0,187
addi $3,$0,204
add  $4,$2,$3
mult $2,$3
mflo $8
mfhi $9
sw   $8,84($0)
sw   $9,88($0)