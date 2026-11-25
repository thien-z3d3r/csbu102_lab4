# Name: Huynh Khanh Thien
# Student ID: 26560059
# Purpose: Experiment 1 - Compute 4 * x using nested calls with $ra saved on the stack

.data
msg:    .asciiz "Score out of 100: "
.text
.globl main
main:
    addi $a0, $zero, 18
    jal  times4
    add  $s0, $v0, $zero
    li   $v0, 4
    la   $a0, msg
    syscall
    li   $v0, 1
    add  $a0, $s0, $zero
    syscall
    li   $v0, 10
    syscall

times4:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)
    jal  twice
    add  $a0, $v0, $zero
    jal  twice
    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra

twice:
    add  $v0, $a0, $a0
    jr   $ra
