(* Main (and single) entry point of the program. It defines the `ono` command. *)

open Cmdliner
open Ono_cli

let doc = ""
let man = []
let info = Cmd.info "ono" ~version ~doc ~sdocs ~man ~exits

let default =
  let open Term in
  let default = const (`Help (`Auto, None)) in
  ret default

let cmd = Cmd.group info ~default [ Cmd_concrete.cmd; Cmd_symbolic.cmd ]

let exit_code_of_result = function
  | Ok () -> Cmd.Exit.ok
  | Error e -> (
      match e with
      | `Term | `Parse -> Cmd.Exit.cli_error
      | `Exn -> Cmd.Exit.internal_error
      | #Ono.Error.t as e -> error_to_exit_code e)

let print_outcome = function
  | Ok () -> Logs.app (fun m -> m "OK!")
  | Error e -> (
      match e with
      | `Msg msg -> Logs.err (fun m -> m "%s" msg)
      | `Exn -> Logs.err (fun m -> m "unhandled exception")
      | `Term | `Parse -> Logs.err (fun m -> m "command line parsing error")
      | `Call_stack_exhausted -> Logs.err (fun m -> m "call stack exhausted")
      | `Conversion_to_integer -> Logs.err (fun m -> m "conversion to integer")
      | `Integer_divide_by_zero ->
          Logs.err (fun m -> m "integer divide by zero")
      | `Integer_overflow -> Logs.err (fun m -> m "integer overflow")
      | `Out_of_bounds_memory_access ->
          Logs.err (fun m -> m "out of bounds memory access")
      | `Unreachable -> Logs.err (fun m -> m "unreachable"))

let outcome () =
  match Cmd.eval_value cmd with
  | Ok (`Help | `Version) -> Ok ()
  | Ok (`Ok result) -> (result :> outcome)
  | Error _ as result -> (result :> outcome)

let main () =
  let outcome = outcome () in
  print_outcome outcome;
  exit_code_of_result outcome

let () = if !Sys.interactive then () else exit (main ())
