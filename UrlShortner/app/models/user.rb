class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, omniauth_providers: %i[google_oauth2]

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    
    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(email: data['email'], name: data['name'])
    end
    user
  end
end
