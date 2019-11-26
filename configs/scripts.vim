if did_filetype()
  finish
endif

if getline(1) =~# '^#!.*bin/.*python'
  setfiletype python
endif
