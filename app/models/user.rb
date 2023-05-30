class User < ApplicationRecord
  has_many :images, dependent: :destroy

  devise :database_authenticatable, :rememberable, :omniauthable

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.uid + "@tyriens.fr"
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name
    end
  end
end
