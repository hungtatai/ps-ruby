
# PS-Ruby

PS-Ruby is a simple ps wrapper with ruby. You can see [example.rb](example/example.rb) to learn more...

# installation

```
  gem install ps-ruby
```

# Usage

## Display all processes

```ruby
  > require 'ps-ruby'
  > PS.simple_display
```

```
  PID   %CPU  %MEM  COMMAND
  36484 21.1  0.6   /Applications/Google Chrome.app...
  36140 19.0  1.0   /Applications/Google Chrome.app...
  67812 14.7  0.2   /Applications/Sublime Text.app/...
  67813 13.7  0.1   ruby example.rb
  ...
```

## Display special processes by name

```ruby
  > PS.simple_display("zsh")
```

or 

```ruby
  > PS.simple_display(/.*zsh.*/i)
```

or 

```ruby
  PS.find_processes("zsh").simple_display
```

```
  PID   %CPU  %MEM  COMMAND
  59395 0.4   0.0   -zsh
  67468 0.0   0.0   -zsh
  83005 0.0   0.0   -zsh
```

## Get special processes by name


```ruby
  > PS.find_processes("zsh")
```

```ruby
  [{
    "USER" => "HondaDai", 
    "PID" => "59395", 
    "%CPU" => "0.4", 
    "%MEM" => "0.0", 
    "VSZ" => "2462760", 
    "RSS" => "3308", 
    "TT" => "s002", 
    "STAT" => "S", 
    "STARTED" => "2:21PM", 
    "TIME" => "0:00.75", 
    "COMMAND" => "-zsh"
  }, {
    "USER" => "HondaDai", 
    "PID" => "83005", 
    "%CPU" => "0.0", 
    "%MEM" => "0.0", 
    "VSZ" => "2462760", 
    "RSS" => "776", 
    "TT" => "s001", 
    "STAT" => "S+", 
    "STARTED" => "10:10PM", 
    "TIME" => "0:01.07", 
    "COMMAND" => "-zsh"
  }, {
    "USER" => "HondaDai", 
    "PID" => "67468", 
    "%CPU" => "0.0", 
    "%MEM" => "0.0", 
    "VSZ" => "2462760", 
    "RSS" => "196", 
    "TT" => "s000", 
    "STAT" => "S", 
    "STARTED" => "Fri03PM", 
    "TIME" => "0:00.78", 
    "COMMAND" => "-zsh"
  }]
```

## Chaining

```ruby
  > PS.find_processes("zsh").find_process_by("PID", "67468")
```

```ruby
  [{
    "USER" => "HondaDai", 
    "PID" => "67468", 
    "%CPU" => "0.0", 
    "%MEM" => "0.0", 
    "VSZ" => "2462760", 
    "RSS" => "196", 
    "TT" => "s000", 
    "STAT" => "S", 
    "STARTED" => "Fri03PM", 
    "TIME" => "0:00.78", 
    "COMMAND" => "-zsh"
  }]
```

```ruby
  ms = PS.find_processes("Microsoft")
  word = ms.find_processes("Word")
  ppt = ms.find_processes("PowerPoint")
```

## Get special attribute

```ruby
  commands = PS.find_processes("Microsoft").pick_by_attr("COMMAND")
```

## Kill process

```ruby
  > PS.find_processes("chrome").kill! # kill all processes named '.*chrome.*'
```

or 

```ruby
  > chrome = PS.find_processes("chrome")[0]
  > chrome.kill!
```


## Check a process alive or not

```ruby
  > chrome = PS.find_processes("chrome")[0]
  > chrome.alive?
```

## Get all processes

```ruby
  > PS.get_all_processes
```
