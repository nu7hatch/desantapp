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
  #   created_at  :timestamp,    not null
  #   
  class Signup < ActiveRecord::Base
    validates :email, :email => true, :uniqueness => true

    # Public: Scope returning latest signups ordered by date.
    def self.latest
      order('created_at DESC')
    end

    # Public: Shorthand for setting up client information.
    #
    # ip      - A String IP address.
    # referer - A String HTTP referer address.
    #
    def set_client_info(ip, referer)
      self.ip_address, self.referer = ip, referer
    end
  end
end
