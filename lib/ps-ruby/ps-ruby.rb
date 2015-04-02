
module PS
  module_function

  def simple_display(name = "", limit_process_name_len=30)
    result = find_process(name)
    picks = ["PID", "%CPU", "%MEM", "COMMAND"]
    if result.size > 0
      puts picks.join("\t")+"\n"
      result.each{|x|
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
    regex = if name.class != Regexp then Regexp.new(".*#{name}.*", Regexp::IGNORECASE) else name end
    aux.select{|x| x["COMMAND"] =~ regex }
  end

  def processes
    pick_attr("COMMAND").uniq.sort
  end

  def attrs
    return @ps_attrs if @ps_attrs
    @ps_attrs = raw_aux.split("\n").map{|x| x.split(/\s+/) }.shift
  end

  def pick_attr(attr_name)
    return aux.map{|x| x[attr_name]} if attrs.include?(attr_name)
  end

  def aux
    table = raw_aux.split("\n").map{|x| x.split(/\s+/) }
    attrs =  table.shift
    table = table.reduce([]) {|s, x|
      if x.size > attrs.size
        x = x[0..(attrs.size-2)] + [x[(attrs.size-1)..-1].join(" ")]
      end
      s << Hash[attrs.zip(x)]
    }
    table
  end

  def raw_aux
    %x{ps aux}
  end

end

