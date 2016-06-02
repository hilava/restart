class Profile < ActiveRecord::Base
  belongs_to :user

  validates :email,uniqueness: true
  validates :country, presence: true
  validates :city, presence: true
  validates :resume, presence: true
  validates :occupation, presence: true

  def self.search(search)
    # The search methos is called in the index method
    # It searches for a word (search) in country / state / city / occupation
    # and it is case insensitive
    where("LOWER(country) LIKE ? OR LOWER(state) LIKE ? OR LOWER(city) LIKE ?
          OR LOWER(occupation) LIKE ?","%#{search.downcase}%","%#{search.downcase}%",
          "%#{search.downcase}%","%#{search.downcase}%")
  end

end
