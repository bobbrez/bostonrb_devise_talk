class EncodedTokenStrategy < Warden::Strategies::Base
  def valid?
    not authorization.blank?
  end

  def authenticate!
    raise_invalid_token if authorization.blank?

    success! User.find_by_encoded_token! authorization
  rescue Error => e
    fail! e.message
  end

  private

  def raise_invalid_token

  end

  def authorization
    @authorization ||= params[:auth_token] || request.headers['HTTP_AUTHORIZATION']
  end
end
