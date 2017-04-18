class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  enum role: [:standard, :premium, :admin]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100#", large: "1200x500#"}, default_url: "http://istc-pc-test-media.cs.washington.edu/images/default-profile-pic.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  has_many :comments, dependent: :destroy
  has_many :logs, dependent: :destroy do
    def today
      where(:created_at => (Time.zone.now.beginning_of_day..Time.zone.now))
    end
  end
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
