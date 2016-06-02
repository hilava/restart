class Job < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  def self.search(search)
    # The search methos is called in the index method
    # It searches for a word (search) in title / description / category and it is case
    # insensitive
    where("LOWER(title) LIKE ? OR LOWER(description) LIKE ? OR LOWER(category) LIKE ?
      OR LOWER(country) LIKE ? OR LOWER(city) LIKE ? OR LOWER(state) LIKE ?",
          "%#{search.downcase}%","%#{search.downcase}%", "%#{search.downcase}%",
           "%#{search.downcase}%","%#{search.downcase}%", "%#{search.downcase}%")
  end
end
