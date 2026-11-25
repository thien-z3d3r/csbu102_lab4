# Name: Huynh Khanh Thien
# Student ID: 26560059
# Purpose: Extension - Recursive sum_to(n) = 1 + 2 + ... + n using stack frames

.text
.globl main
main:
    li   $v0, 5
    syscall
    add  $a0, $v0, $zero
    jal  sum_to
    add  $a0, $v0, $zero
    li   $v0, 1
    syscall
    li   $v0, 10
    syscall

sum_to:
    bne  $a0, $zero, st_rec
    addi $v0, $zero, 0
    jr   $ra
st_rec:
    addi $sp, $sp, -8
    sw   $ra, 4($sp)
    sw   $a0, 0($sp)
    addi $a0, $a0, -1
    jal  sum_to
    lw   $a0, 0($sp)
    add  $v0, $v0, $a0
    lw   $ra, 4($sp)
    addi $sp, $sp, 8
    jr   $ra
