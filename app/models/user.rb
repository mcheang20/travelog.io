class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  enum role: [:standard, :premium, :admin]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :logs, dependent: :destroy do
    def today
      where(:created_at => (Time.zone.now.beginning_of_day..Time.zone.now))
    end
  end
end
