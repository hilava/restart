class Company < ActiveRecord::Base
  belongs_to :user
  has_many :jobs

  validates :name, presence: true
  validates :description, presence: true
  validates :name, uniqueness: true

  def self.search(search)
    # The search methos is called in the search method in the companies controller
    # It searches for a word (search) in title / description / category and it is case
    # insensitive
    where("LOWER(name) LIKE ?", "%#{search.downcase}%")
  end

end
