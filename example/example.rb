
require File.join(File.expand_path(File.dirname(__FILE__)), "../lib/ps-ruby.rb")

# list `ps aux` attrs
puts PS.attrs.to_s

# display a simple table
PS.find_processes("zsh").simple_display

# Kill all process named 'irb'
# PS.find_processes("irb").kill!

# check a process is alive or not
PS.find_processes("chrome").first.alive?

# chaining select
ms = PS.find_processes("Microsoft")
word = ms.find_processes("Word")
ppt = ms.find_processes("PowerPoint")

# find by special attrs
put PS.find_processes("PID", PROCESS_ID)