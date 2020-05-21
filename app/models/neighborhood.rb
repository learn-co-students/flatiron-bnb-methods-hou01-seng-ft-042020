class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings
  has_many :reservations, through: :listings

  def neighborhood_openings(start_date, end_date)
    self.listings.select do |listing|
      listing.reservations.none? do |res|
        res.checkin <= Date.parse(end_date) && res.checkout >= Date.parse(start_date)
      end
    end
  end

  def self.highest_ratio_res_to_listings
    all.max_by {|neigh| neigh.reservations.count.to_f / neigh.listings.count.to_f }
  end

  def self.most_res
    all.max_by do |neigh|
      neigh.reservations.count
    end
  end

end
