class Show < ActiveRecord::Base
    has_many :bookings
    acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng
end