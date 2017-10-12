require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

# I had to look at the solution specs for all other methods than initialize;
# I spent about 45 minutes on it, but with the new syntax, I ended up
# reading the solutions, then tying to write the tests, and eventually went
# back to check the solutions to get them all to pass

describe Dessert do
  # Here we set up our dummy object (mock) as an instance of the dessert class
  # above it, we also et up a dummy chef class so that we ca interact with
  # the chef class when calling interdependent methods
  let(:chef) { double("chef", name: "Guy") }
  subject(:dessert) {Dessert.new("cake", 138, chef) }

  # Here we are testing the initialize function; notice this syntax:
  # describe "string that describes action" do
  # expect(call method on mock instanct).to eq(result, matching data type)
  describe "#initialize" do
    it "sets a type" do
      expect(dessert.type).to eq("cake")
    end

    it "sets a quantity" do
      expect(dessert.quantity).to eq(138)
    end

    # A better way to do this would be to see if the ingredients is_a?(Array)
    # and then checking to see if it is also empty?

    it "starts ingredients as an empty array" do
      expect(dessert.ingredients).to eq([])
    end

    # Notice the block style {} for raising errors; also, have to actually
    # call the initialize method with the required arguments for this type
    # of test

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new("cake", "one", "Guy") }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      dessert.add_ingredient("icing") # here we call the method with the argument
      expect(dessert.ingredients).to include("icing") # and we check
    end
  end

  # The first comment within this test was my first attempt; we can think
  # of writing tests like writing methods--what we do within the test is
  # limited in scope to the  test in which it was defined

  describe "#mix!" do
    it "shuffles the ingredient array" do
      # expect(dessert.mix!).to be(ingredients)
      ingredients = ["eggs", "flour", "vanilla", "baking soda", "salt"]

      ingredients.each do |ingredient|
        dessert.add_ingredient(ingredient)
      end

      expect(dessert.ingredients).to eq(ingredients)
      dessert.mix! # since the method calls mix, we have to call it too;
      expect(dessert.ingredients).not_to eq(ingredients)
      expect(dessert.ingredients.sort).to eq(ingredients.sort)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      dessert.eat(13) # calling method on mock object with argument
      expect(dessert.quantity).to eq(125)
    end

    # again, notice the block style for raising errors

    it "raises an error if the amount is greater than the quantity" do
      expect { dessert.eat(139) }.to raise_error("not enough left!")
    end
  end

  # here is where we're testing the methods that are dependent on the
  # chef class; notice the allow(class instance).to receive(:method).and_return("result")
  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Guy the Great Baker")
      expect(dessert.serve).to eq("Guy the Great Baker has made 138 cakes!")
    end
  end

  # Notice how we do something similar here, but then after the interdependent
  # method call, we call the method #make_more, which calls chef to do some
  # baking;
   
  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(dessert)
      dessert.make_more
    end
  end
end
