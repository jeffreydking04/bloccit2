class User < ActiveRecord::Base
  before_save { self.email = email.downcase if email.present? }
  before_save do
    if name.present?
      name_array = self.name.split(" ")
      name_array[0].capitalize!
      name_array[1].capitalize!
      self.name = name_array.join(" ")
    end
  end
  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :password, presence: true, length: { minimum: 6 }, unless: :password_digest
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }
  has_secure_password
end
