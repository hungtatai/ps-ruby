
require File.join(File.expand_path(File.dirname(__FILE__)), "../lib/ps-ruby.rb")

# list `ps aux` attrs
puts PS.attrs.to_s

# display a simple table
PS.find_process("zsh").simple_display

# find by special attrs
put PS.find_process_by("PID", PROCESS_ID)

# Kill all process named 'irb'
PS.find_process("irb").kill!

# check a process is alive or not
PS.find_process("chrome").first.alive?

# chaining select
ms = PS.find_process("Microsoft")
word = ms.find_process("Word")
ppt = ms.find_process("PowerPoint")