class Category < ApplicationRecord
  has_many :logs, dependent: :destroy
end
