class SnackBox
  SNACK_BOX_DATA = {
    1 => {
      "bone" => {
        "info" => "Phoenician rawhide",
        "tastiness" => 20
      },
      "kibble" => {
        "info" => "Delicately braised hamhocks",
        "tastiness" => 33
      },
      "treat" => {
        "info" => "Chewy dental sticks",
        "tastiness" => 40
      }
    },
    2 => {
      "bone" => {
        "info" => "An old dirty bone",
        "tastiness" => 2
      },
      "kibble" => {
        "info" => "Kale clusters",
        "tastiness" => 1
      },
      "treat" => {
        "info" => "Bacon",
        "tastiness" => 80
      }
    },
    3 => {
      "bone" => {
        "info" => "A steak bone",
        "tastiness" => 64
      },
      "kibble" => {
        "info" => "Sweet Potato nibbles",
        "tastiness" => 45
      },
      "treat" => {
        "info" => "Chicken bits",
        "tastiness" => 75
      }
    }
  }
  def initialize(data = SNACK_BOX_DATA)
    @data = data
  end

  def get_bone_info(box_id)
    @data[box_id]["bone"]["info"]
  end

  def get_bone_tastiness(box_id)
    @data[box_id]["bone"]["tastiness"]
  end

  def get_kibble_info(box_id)
    @data[box_id]["kibble"]["info"]
  end

  def get_kibble_tastiness(box_id)
    @data[box_id]["kibble"]["tastiness"]
  end

  def get_treat_info(box_id)
    @data[box_id]["treat"]["info"]
  end

  def get_treat_tastiness(box_id)
    @data[box_id]["treat"]["tastiness"]
  end
end

class CorgiSnacks

  def initialize(snack_box, box_id)
    @snack_box = snack_box
    @box_id = box_id
  end

  def bone
    info = @snack_box.get_bone_info(@box_id)
    tastiness = @snack_box.get_bone_tastiness(@box_id)
    result = "Bone: #{info}: #{tastiness} "
    tastiness > 30 ? "* #{result}" : result
  end

  def kibble
    info = @snack_box.get_kibble_info(@box_id)
    tastiness = @snack_box.get_kibble_tastiness(@box_id)
    result = "Kibble: #{info}: #{tastiness} "
    tastiness > 30 ? "* #{result}" : result
  end

  def treat
    info = @snack_box.get_treat_info(@box_id)
    tastiness = @snack_box.get_treat_tastiness(@box_id)
    result = "Treat: #{info}: #{tastiness} "
    tastiness > 30 ? "* #{result}" : result
  end

end

def get_bone_info(box_id)
  @data[box_id]["bone"]["info"]
end

# I tried to do this based on the readings, but kept getting an error;
# I feel like I understood the basic concept of redefining method_missing
# to generate new methods, but right now, I'm not able to trouble shoot
# this problem. I'm going to read over the solutions and see where I'm
# going wrong.


# I forgot to use #send in my method; so, I didn't understand this well
# enough to be able to put the concepts behind #method_missing and #send
# to get this to work.


class MetaCorgiSnacks
  def initialize(snack_box, box_id)
    @snack_box = snack_box
    @box_id = box_id
    # Didn't get this first time around
    snack_box.methods.grep(/^get_(.*)_info$/) { MetaCorgiSnacks.define_snack $1 }
  end

  def method_missing(name, *args)
    method_name = name.to_s
    if method_name.start_with?("get_")
      attribute_string = method_name[("get_".length)..-1]

      attribute_names = attribute_string.split("_")

      unless attribute_names.length == args.length
        raise "unexpected # of arguments"
      end

      search_conditions = {}
      attribute_names.length.times do |i|
        search_conditions[attribute_names[i]] = args[i]
      end

      self.search(search_conditions)
    else
      super
    end
  end

  def respond_to_missing?
    super
  end

# The correct method is below;
# def method_missing(name, *args)
#   info = @snack_box.send("get_#{name}_info", @box_id)
#   tastiness = @snack_box.send("get_#{name}_tastiness", @box_id)
#   name = "#{name.to_s.split('_').map(&:capitalize).join(' ')}"
#   result = "#{name}: #{info}: #{tastiness} "
#   tastiness > 30 ? "* #{result}" : result
# end

  # After spending 30 minutes on the first part, I didn't get a chance
  # to tackled this second part. Need more work with this!
  # Solution is below:

  def self.define_snack(name)
    define_method(name) do
      info = @snack_box.send("get_#{name}_info", @box_id)
      tastiness = @snack_box.send("get_#{name}_tastiness", @box_id)
      display_name = "#{name.split('_').map(&:capitalize).join(' ')}"
      result = "#{display_name}: #{info}: #{tastiness}"
      tastiness > 30 ? "* #{result}" : result
  end
end
