set history save
set history filename ~/.gdb_history

define ruby_eval
  call(rb_p(rb_eval_string_protect($arg0,(int*)0)))
end
