class Foo
  def get_foo
    foo = []
    x_max = 0
    y_max = 0

    File.open("data.txt").each do |f|
      x = []
      f.split("").each_with_index do |c,index|
        c = c.to_i
        if c == 1 or c == 0
          x.push(c)
        end
      end
      x_max = x.count
      foo.push(x) unless x.empty?
    end

    y_max = foo.count

    return foo, x_max, y_max
  end

  #Thx http://www.ruby-forum.com/topic/184567
  def fill(x, y, target_color, replacement_color, foo_cpy)
    return unless foo_cpy and foo_cpy[y] and foo_cpy[y][x]

     return if foo_cpy[y][x] != target_color
     return if foo_cpy[y][x] == replacement_color
                    
     foo_cpy[y][x] = replacement_color
     fill(x+1, y, target_color, replacement_color, foo_cpy)
     fill(x-1, y, target_color, replacement_color, foo_cpy)
     fill(x, y+1, target_color, replacement_color, foo_cpy)
     fill(x, y-1, target_color, replacement_color, foo_cpy)
  end

  def fill_foo
    alpha = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
    foo, x_max, y_max = get_foo
    return if y_max > alpha.count

    foo.each_with_index do |y, y_idx|
      area_counter = 0
      y.each_with_index do |x, x_idx|
        fill(y_idx, x_idx, 0, alpha[area_counter], foo)
        area_counter += 1
      end
    end

    foo.each do |y|
      y.each do |x|
        print x
      end
      puts ""
    end

    valid_areas = {}
    invalid_areas = {}

    alpha.each do |c|
      foo.each_with_index do |y, y_idx|
        y.each_with_index do |x, x_idx|
          if foo[y_idx][x_idx] == c
            if x_idx == x_max or x_idx == 0
              invalid_areas[c] = true
            else
              valid_areas[c] = valid_areas.has_key?(c) ? valid_areas[c]+1 : 1
            end
          end
        end
      end
    end

    valid_area_keys = valid_areas.keys - invalid_areas.keys
    puts "Valid areas found #{valid_area_keys.count}"
    largest_area_size = 0
    largest_area = ""
    valid_area_keys.each do |k|
      if valid_areas[k] > largest_area_size
        largest_area_size = valid_areas[k]
        largest_area = k
      end
    end
    puts "The largest area is area #{largest_area} with a size of #{largest_area_size} units."
  end
end

foo_class = Foo.new
foo_class.fill_foo
