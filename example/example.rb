
require File.join(File.expand_path(File.dirname(__FILE__)), "../lib/ps-ruby.rb")

puts PS.attrs.to_s
puts PS.find_process("zsh").to_s


# PS.simple_display(/.*zsh.*/i)
# PS.simple_display("chrome")
# PS.simple_display
