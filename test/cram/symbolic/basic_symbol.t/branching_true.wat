(module
  (func $i32_symbol (import "ono" "i32_symbol") (result i32))
  (func $print_i32  (import "ono" "print_i32") (param i32))
  (func $main
    (local $n i32)

    call $i32_symbol
    local.tee $n
    i32.const 42
    i32.lt_s

    (if (then
      unreachable
    ) (else
      return
    ))
  )
  (start $main)
)
