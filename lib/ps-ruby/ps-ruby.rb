

class PsProcess < Hash
  def kill!
    `kill #{self["PID"]}`
  end

  def alive?
    PS.get_all_processes.pick_by_attr("PID").include?(self["PID"])
  end
end

class PsProcessList < Array
  def kill!
    self.each(&:kill!)
  end

  def simple_display(limit_process_name_len=30)
    picks = ["PID", "%CPU", "%MEM", "COMMAND"]
    if self.size > 0
      puts picks.join("\t")+"\n"
      self.each{|x|
        puts picks.reduce(""){|s, k| 
          s += if k == "COMMAND" and x[k].size > limit_process_name_len then 
            "#{x[k][0..limit_process_name_len]}...\t" 
          else 
            "#{x[k]}\t" 
          end 
        }
      }
    else
      puts "Not found any process called `#{name}`"
    end
    nil
  end

  def find_process(name)
    find_process_by("COMMAND", name)
  end

  def find_process_by(attr_name, value)
    regex = if value.class != Regexp then Regexp.new(".*#{value}.*", Regexp::IGNORECASE) else value end
    PsProcessList.new(self.select{|x| x[attr_name] =~ regex })
  end

  def pick_by_attr(attr_name)
    self.map{|x| x[attr_name] } if PS.attrs.include?(attr_name)
  end

end




module PS
  module_function

  def simple_display(name = "", limit_process_name_len=30)
    find_process(name).simple_display(limit_process_name_len)
  end

  def find_process(name)
    find_process_by("COMMAND", name)
  end

  def find_process_by(attr_name, value)
    get_all_processes.find_process_by(attr_name, value)
  end

  def attrs
    # ["USER", "PID", "%CPU", "%MEM", "VSZ", "RSS", "TT", "STAT", "STARTED", "TIME", "COMMAND"]
    return @ps_attrs if @ps_attrs
    @ps_attrs = raw_aux.split("\n").map{|x| x.split(/\s+/) }.shift
  end

  def get_all_processes
    table = raw_aux.split("\n").map{|x| x.split(/\s+/) }
    attrs =  table.shift
    table = table.reduce(PsProcessList.new) {|s, x|
      if x.size > attrs.size
        x = x[0..(attrs.size-2)] + [x[(attrs.size-1)..-1].join(" ")]
      end
      s << PsProcess[attrs.zip(x)]
    }
    table
  end

  def raw_aux
    %x{ps aux}
  end

end

