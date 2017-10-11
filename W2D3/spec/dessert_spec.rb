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
  let(:chef) { double("chef", name: "Guy") }
  subject(:dessert) {Dessert.new("cake", 138, chef) }

  describe "#initialize" do
    it "sets a type" do
      expect(dessert.type).to eq("cake")
    end

    it "sets a quantity" do
      expect(dessert.quantity).to eq(138)
    end

    it "starts ingredients as an empty array" do
      expect(dessert.ingredients).to eq([])
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new("cake", "one", "Guy") }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      dessert.add_ingredient("icing")
      expect(dessert.ingredients).to include("icing")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      # expect(dessert.mix!).to be(ingredients)
      ingredients = ["eggs", "flour", "vanilla", "baking soda", "salt"]

      ingredients.each do |ingredient|
        dessert.add_ingredient(ingredient)
      end

      expect(dessert.ingredients).to eq(ingredients)
      dessert.mix!
      expect(dessert.ingredients).not_to eq(ingredients)
      expect(dessert.ingredients.sort).to eq(ingredients.sort)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      dessert.eat(13)
      expect(dessert.quantity).to eq(125)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { dessert.eat(139) }.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Guy the Great Baker")
      expect(dessert.serve).to eq("Guy the Great Baker has made 138 cakes!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(dessert)
      dessert.make_more
    end
  end
end
