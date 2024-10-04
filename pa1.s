.data
get_input_string: .asciz "Enter two decimal integers and an operator (+ - / *):\n"
invalid_operand_string: .asciz "Error: invalid operator \n"
divide_by_zero_string: .asciz "Error: divide by zero \n"
result_string: .asciz "Result: %d\n"
inputFormat: .asciz "%d %d %c"
int1: .word 0
int2: .word 0
sign: .byte 0
output: .space 8

.text
.global main

main:
             

    // Prompt user for input
    ldr x0, =get_input_string     
    bl printf                    

    // Read the input (two integers and an operator)
    ldr x0, =inputFormat          
    ldr x1, =int1                 
    ldr x2, =int2                 
    ldr x3, =sign                 
    bl scanf                      

    // Load the operands into registers
    ldr x4, =int1
    ldr w1, [x4]                  
    ldr x4, =int2
    ldr w2, [x4]                  
    ldr x4, =sign
    ldrb w3, [x4]                 

    // Check the operator and perform the calculation
    cmp w3, '+'                   
    beq add_operation
    cmp w3, '-'                   
    beq sub_operation
    cmp w3, '*'                   
    beq mul_operation
    cmp w3, '/'                   
    beq div_operation

    // Invalid operator
    ldr x0, =invalid_operand_string
    bl printf
    b exit

add_operation:
    add w0, w1, w2                
    b print_result

sub_operation:
    sub w0, w1, w2               
    b print_result

mul_operation:
    mul w0, w1, w2                
    b print_result

div_operation:
    cbz w2, divide_by_zero       
    sdiv w0, w1, w2               
    b print_result

divide_by_zero:
    ldr x0, =divide_by_zero_string
    bl printf
    b exit

print_result:
    mov w1, w0                   
    ldr x0, =result_string        
    bl printf                     

exit:
    ldp x29, x30, [sp], 16        
    mov w0, #0
    mov x8, #93
    svc #0                        