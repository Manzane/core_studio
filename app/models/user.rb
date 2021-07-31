class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :bookings, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :credits, dependent: :destroy
  accepts_nested_attributes_for :credits
  has_one_attached :avatar

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook]

  validates :first_name, presence: true
  validates :last_name, presence: true

  after_create :create_credits

  def self.from_omniauth(auth, signed_in_resource=nil)
    user = User.where(email: auth.info.email).first
    if !user
        user ||= User.create!(provider: auth.provider, uid: auth.uid, image: auth.info.image, first_name: auth.info.first_name, last_name: auth.info.last_name, email: auth.info.email, password: Devise.friendly_token[0,20])
        Cart.create(user: user)
    elsif user && user.provider != auth.provider
          user.update!(provider: auth.provider, uid: auth.uid, image: auth.info.image, first_name: auth.info.first_name, last_name: auth.info.last_name)
    end
    user
  end

  def create_credits
    categories = Category.all
    categories.each do |category|
      Credit.create!(user: self, category: category, quantity: 0)
    end
  end

  def pending?
    invitation_accepted_at.blank?
  end

  def signed_in?
    sign_in_count > 0
  end

end
