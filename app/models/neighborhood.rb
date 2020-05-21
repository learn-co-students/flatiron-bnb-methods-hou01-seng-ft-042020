class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings
  has_many :reservations, through: :listings

  def ratio_reservations_to_listings
    if listings.count > 0
      reservations.count.to_f / listings.count.to_f
    end
  end

  def res_to_listings
    all.reject { |n| n.reservations.empty? || n.listings.empty? }.max_by {|n| (n.reservations.count / n.listings.count) }
  end


  def neighborhood_openings(start_date, end_date)
    self.listings.select do |listing|
      listing.reservations.none? do |res|
        res.checkin <= Date.parse(end_date) && res.checkout >= Date.parse(start_date)
      end
    end
  end

  def self.highest_ratio_res_to_listings
    sorted  = self.all.sort_by do |neighborhood|
      if neighborhood.reservations.count * neighborhood.listings.count != 0
        neighborhood.reservations.count.to_f / neighborhood.listings.count.to_f
      else
        0
      end
    end
    highestratio = sorted.reverse.first
  end

  def self.most_res
    all.max_by do |neigh|
      neigh.reservations.count
    end
  end

end
