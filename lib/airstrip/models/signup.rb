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
  #   referrer    :string(255)
  #   created_at  :timestamp,    not null
  #   
  class Signup < ActiveRecord::Base
    validates :email, :email => true, :uniqueness => true

    def set_client_info(ip, referrer)
      self.ip_address, self.referrer = ip, referrer
    end
  end
end
