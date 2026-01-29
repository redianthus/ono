(module
    (func $print_i32 (import "ono" "print_i32") (param i32))
    (func $factorial (param $n i32) (result i32)
           ;; []
        local.get $n ;; [n]
        i32.const 0 ;; [n, 0]
        i32.eq ;; [n == 0]
        if (result i32) ;; [n == 0]
            i32.const 1 ;; [1]
        else
            local.get $n ;; [n]
            local.get $n  ;; [n, n]
            i32.const 1 ;; [1, n, n]
            i32.sub ;; [n-1, n]
            call $factorial ;; [factorial(n-1), n]
            i32.mul ;; [factorial(n-1) * n]
        end
    )
    (func $main
        i32.const 5
        call $factorial
        call $print_i32
    )
    (start $main)
)
