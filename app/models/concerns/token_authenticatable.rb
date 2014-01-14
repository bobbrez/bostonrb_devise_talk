module TokenAuthenticatable
  extend ActiveSupport::Concern

  def create_encoded_token
    raw, digested = Devise.token_generator.generate self.class, :token

    [ Base64.urlsafe_encode64([id, raw].join(':')), digested ]
  end

  def create_encoded_token!
    encoded, digested = create_encoded_token

    update_attribute :token, digested

    encoded
  end

  module ClassMethods
    def find_by_encoded_token!(encoded)
      token = Base64.urlsafe_decode64 encoded
      id, raw = token.split ':', 2

      raise 'Invalid token format!' if id.blank? || raw.blank?

      digested = Devise.token_generator.digest self.class, :token, raw
      record = self.find_by! id: id

      raise "Token mismatch for #{ self.class } with ID #{ id }!" unless Devise.secure_compare record.token, digested

      record
    end
  end
end
