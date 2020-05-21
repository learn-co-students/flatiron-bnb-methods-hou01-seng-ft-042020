  
module Reservable
    extend ActiveSupport::Concern
 
   def openings(start_date, end_date)
     listings.merge(Listing.available(start_date, end_date))
   end
 
   class_methods do
     # use of 'class_methods' is good, but I think is something that the curriculum 
     # does not currently cover, so would need to be added.
     def highest_ratio_res_to_listings
        all.max_by {|a| a.reservations.count.to_f / a.listings.count.to_f }
     end
 
     def most_res
        all.max_by do |a|
            a.reservations.count
     end
   end

   def openings(start_date, end_date)
    self.listings.select do |listing|
      listing.reservations.none? do |res|
        res.checkin <= Date.parse(end_date) && res.checkout >= Date.parse(start_date)
      end
    end
  end

 end