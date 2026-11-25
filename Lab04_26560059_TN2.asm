# Name: Huynh Khanh Thien
# Student ID: 26560059
# Purpose: Experiment 2 - Compute score spread keeping largest in $s0 across calls

.data
classA: .word 72, 55, 90, 48, 63, 85, 39, 77, 60, 94
classB: .word 45, 81, 66, 50, 92, 38, 70, 59
msgA:   .asciiz "Class A spread: "
msgB:   .asciiz "Class B spread: "
nl:     .asciiz "\n"
.text
.globl main
main:
    la   $a0, classA
    addi $a1, $zero, 10
    jal  spread
    la   $a0, msgA
    add  $a1, $v0, $zero
    jal  show
    la   $a0, classB
    addi $a1, $zero, 8
    jal  spread
    la   $a0, msgB
    add  $a1, $v0, $zero
    jal  show
    li   $v0, 10
    syscall

spread:
    addi $sp, $sp, -16
    sw   $ra, 12($sp)
    sw   $s0, 8($sp)
    sw   $a0, 4($sp)
    sw   $a1, 0($sp)
    jal  max_array
    add  $s0, $v0, $zero
    lw   $a0, 4($sp)
    lw   $a1, 0($sp)
    jal  min_array
    sub  $v0, $s0, $v0
    lw   $s0, 8($sp)
    lw   $ra, 12($sp)
    addi $sp, $sp, 16
    jr   $ra

max_array:
    lw   $v0, 0($a0)
    addi $t0, $zero, 1
max_loop:
    slt  $t1, $t0, $a1
    beq  $t1, $zero, max_end
    sll  $t2, $t0, 2
    add  $t2, $t2, $a0
    lw   $t3, 0($t2)
    slt  $t1, $v0, $t3
    beq  $t1, $zero, max_next
    add  $v0, $t3, $zero
max_next:
    addi $t0, $t0, 1
    j    max_loop
max_end:
    jr   $ra

min_array:
    lw   $v0, 0($a0)
    addi $t0, $zero, 1
min_loop:
    slt  $t1, $t0, $a1
    beq  $t1, $zero, min_end
    sll  $t2, $t0, 2
    add  $t2, $t2, $a0
    lw   $t3, 0($t2)
    slt  $t1, $t3, $v0
    beq  $t1, $zero, min_next
    add  $v0, $t3, $zero
min_next:
    addi $t0, $t0, 1
    j    min_loop
min_end:
    jr   $ra

show:
    li   $v0, 4
    syscall
    li   $v0, 1
    add  $a0, $a1, $zero
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall
    jr   $ra
