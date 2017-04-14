class Log < ApplicationRecord
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>", index: "350x300#", large: "1500x650#"}, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  belongs_to :user
  belongs_to :category
  validates :title, presence: true
  validates :body, presence: true
  validates :description, presence: true
  validates :category, presence: true
end
