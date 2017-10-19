class House < ApplicationRecord
  has_many :gardeners,
    class_name: 'Gardener',
    foreign_key: :house_id,
    primary_key: :id

  has_many :plants,
    through: :gardeners,
    source: :plants

  def n_plus_one_seeds
    plants = self.plants
    seeds = []
    plants.each do |plant|
      seeds << plant.seeds
    end

    seeds
  end

  def better_seeds_query
    plants = self.plants.includes(:seeds)

    seeds = []
    plants.each do |plant|
      seeds << plant.seeds
    end
    seeds 
    # seeds = Plants
    #   .count('plants.*')
    #   .join(:seeds)
    #
    # all_seeds = []
    # seeds.each do |seed|
    #   all_seeds << seed
    # end
    # all_seeds
  end
end
