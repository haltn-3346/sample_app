class User < ApplicationRecord
  attr_accessor :remember_token

  validates :name, presence: true,
                  length: {maximum: Settings.user.name_max,
                           minimum: Settings.user.name_min}
  validates :email, presence: true,
                    length: {maximum: Settings.user.email_max},
                    format: {with: Settings.user.email_pattern},
                    uniqueness: true
  validates :password, presence: true,
                       length: {minimum: Settings.user.password_min,
                                maximum: Settings.user.password_max}

  has_secure_password

  before_save :downcase_email

<<<<<<< HEAD
=======

>>>>>>> 15988b96 (chapter 9)
  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
<<<<<<< HEAD
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated? remember_token
    return false unless remember_digest

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
=======

    def remember
      self.remember_token = User.new_token
      update_attribute :remember_digest, User.digest(remember_token)
    end

    def authenticated? remember_token
      return false if remember_digest.nil?

      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    def forget
      update_attribute(:remember_digest, nil)
    end
>>>>>>> 15988b96 (chapter 9)
  end

  private

  def downcase_email
    email.downcase!
  end

end
