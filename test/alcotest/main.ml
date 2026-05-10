let () =
  Alcotest.run "ono"
    (Test_lib.suite @ Test_tool.suite @ Test_config_parser.suite)
