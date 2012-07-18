module Airstrip
  # Signup entity represents single user signed up for the beta
  # access.
  #
  # Schema info
  #
  #   Table name: signups
  #
  #   id          :integer(11),  not null,  primary key
  #   email       :string(255),  not null
  #   ip_address  :string(255),  not null
  #   referer     :string(255)
  #   lat         :float
  #   lon         :float
  #   created_at  :timestamp,    not null
  #   
  class Signup < ActiveRecord::Base
    validates :email, :email => true, :uniqueness => true

    # Geocoding stuff.

    extend Geocoder::Model::ActiveRecord

    geocoded_by :ip_address, :latitude => :lat, :longitude => :lon
    reverse_geocoded_by :lat, :lon do |obj, results| 
      obj.set_reversed_location(results)
    end

    after_validation :full_geocode, :if => :run_geocoding?

    # Public: Scope returning latest signups ordered by date.
    def self.latest
      order('created_at DESC')
    end

    # Public: Returns list of refering websites with number of
    # users brought by each.
    def self.referers
      select('referer as url, count(id) as users_count')
        .where('referer IS NOT NULL')
        .group('referer')
    end

    # Public: Returns list of cities with number of users from there
    def self.cities
      select('city, country, count(id) as users_count')
        .where('city IS NOT NULL')
        .group('city')
    end

    # Public: Returns list of countries with number of users from there
    def self.countries
      select('country, count(id) as users_count')
        .where('country IS NOT NULL')
        .group('country')
    end

    # Public: Shorthand for setting up client information.
    #
    # ip      - A String IP address.
    # referer - A String HTTP referer address.
    #
    def set_client_info(ip, referer)
      self.ip_address, self.referer = ip, referer
    end
    
    # Internal: Tells if geocoding should be processed.
    def run_geocoding?
      RACK_ENV == 'production'
    end

    # Internal: Stores reversed geocode information from given results.
    #
    # results - A Geocoder info object with reversed location.
    #
    def set_reversed_location(results) 
      if geo = results.first
        self.city = geo.city
        self.country = geo.country
      end
    end

    # Internal: Runs geocoding for both ways.
    def full_geocode
      geocode
      reverse_geocode
    end
  end
end
