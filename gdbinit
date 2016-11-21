set history save
set history filename ~/.gdb_history
set startup-with-shell off

define ruby_eval
  call(rb_p(rb_eval_string_protect($arg0,(int*)0)))
end
