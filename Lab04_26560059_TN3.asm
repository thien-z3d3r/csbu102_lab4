# Name: Huynh Khanh Thien
# Student ID: 26560059
# Purpose: Experiment 3 - Three-level nested class report (total, passed with M=91, spread)

.data
classA: .word 72, 55, 90, 48, 63, 85, 39, 77, 60, 94
classB: .word 45, 81, 66, 50, 92, 38, 70, 59
hdrA:   .asciiz "== Class A ==\n"
hdrB:   .asciiz "== Class B ==\n"
mTot:   .asciiz "Total:  "
mPass:  .asciiz "Passed: "
mSpr:   .asciiz "Spread: "
nl:     .asciiz "\n"
.text
.globl main
main:
    li   $v0, 4
    la   $a0, hdrA
    syscall
    la   $a0, classA
    addi $a1, $zero, 10
    addi $a2, $zero, 91
    jal  report
    li   $v0, 4
    la   $a0, hdrB
    syscall
    la   $a0, classB
    addi $a1, $zero, 8
    addi $a2, $zero, 91
    jal  report
    li   $v0, 10
    syscall

report:
    addi $sp, $sp, -16
    sw   $ra, 12($sp)
    sw   $s0, 8($sp)
    sw   $s1, 4($sp)
    sw   $s2, 0($sp)
    add  $s0, $a0, $zero
    add  $s1, $a1, $zero
    add  $s2, $a2, $zero
    jal  sum_array
    la   $a0, mTot
    add  $a1, $v0, $zero
    jal  show
    add  $a0, $s0, $zero
    add  $a1, $s1, $zero
    add  $a2, $s2, $zero
    jal  count_pass
    la   $a0, mPass
    add  $a1, $v0, $zero
    jal  show
    add  $a0, $s0, $zero
    add  $a1, $s1, $zero
    jal  spread
    la   $a0, mSpr
    add  $a1, $v0, $zero
    jal  show
    lw   $s2, 0($sp)
    lw   $s1, 4($sp)
    lw   $s0, 8($sp)
    lw   $ra, 12($sp)
    addi $sp, $sp, 16
    jr   $ra

sum_array:
    addi $v0, $zero, 0
    addi $t0, $zero, 0
sum_loop:
    slt  $t1, $t0, $a1
    beq  $t1, $zero, sum_end
    sll  $t2, $t0, 2
    add  $t2, $t2, $a0
    lw   $t3, 0($t2)
    add  $v0, $v0, $t3
    addi $t0, $t0, 1
    j    sum_loop
sum_end:
    jr   $ra

count_pass:
    addi $v0, $zero, 0
    addi $t0, $zero, 0
cp_loop:
    slt  $t1, $t0, $a1
    beq  $t1, $zero, cp_end
    sll  $t2, $t0, 2
    add  $t2, $t2, $a0
    lw   $t3, 0($t2)
    slt  $t1, $t3, $a2
    bne  $t1, $zero, cp_next
    addi $v0, $v0, 1
cp_next:
    addi $t0, $t0, 1
    j    cp_loop
cp_end:
    jr   $ra

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
