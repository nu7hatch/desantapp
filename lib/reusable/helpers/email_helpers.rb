module Reusable
  # Public: Collection of email related helpers.
  module EmailHelpers
    extend self

    # Public: Returns anonimized version of the email. It truncates
    # username to 3 first characters with the dots.
    #
    # email - A String email to be escaped
    #
    # Example
    #
    #   include Reusable::EmailHelpers
    #   anonimize_email("marty@macfly.com") # => "mar...@macfly.com"
    #
    # Returns an anonizmized email.
    def anonimize_email(email)
      name, domain = email.split('@')
      name = name.size > 3 ? name.to(2) + '...' : name.first + '...'
      name.gsub!(/\.{4,}/, '...')
      return [ name, domain ].join('@')
    end
  end
end
