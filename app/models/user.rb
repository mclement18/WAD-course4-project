class User < ApplicationRecord
  has_many :tips
  has_many :comments

  has_and_belongs_to_many :favourites, class_name: Tip.name

  has_secure_password

  validates :email, presence: true,
                    uniqueness: true
  validates :role, inclusion: { in: %w(admin registered)}

  after_initialize :default_role!
  before_validation :downcase_email

  mount_uploader :avatar, AvatarUploader
  
  private

  def downcase_email
    self.email = email.downcase
  end

  def default_role!
    self.role ||= 'registered'
  end
end
