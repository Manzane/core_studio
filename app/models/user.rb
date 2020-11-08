class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :bookings, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :travel_countries, through: :travels
  has_many :credits, dependent: :destroy
  has_one_attached :avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook]

  after_create :create_credits

  def self.from_omniauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, email: auth.info.email).first
    unless user
      user ||= User.create!(provider: auth.provider, uid: auth.uid, image: auth.info.image, first_name: auth.info.first_name, last_name: auth.info.last_name, email: auth.info.email, password: Devise.friendly_token[0,20])
      Cart.create(user: user)
    end
    user
  end

  def create_credits
    categories = Category.all
    categories.each do |category|
      Credit.create!(user: self, category: category, quantity: 0)
    end
  end

end
