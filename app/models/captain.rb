class Captain < ActiveRecord::Base
  has_many :boats

# returns all captains of catamarans
  def self.catamaran_operators
    self.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

# returns all unique captains of sailboats
  def self.sailors
    self.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

# invokes two class methods defined above
# in order to return captains of motorboats and sailboats (just their ids)
  def self.talented_seafarers
    self.where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

# invokes the .sailors method to return all
# captains of all boats that are not sailboats
  def self.non_sailors
    self.where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
