class Tip < ApplicationRecord
  belongs_to :user
  has_many   :comments
  
  has_and_belongs_to_many :users

  validates :title, presence: true,
                    length: { maximum: 100 }
  validates :body,  presence: true

  scope :most_recently_updated,   -> { order(updated_at: :desc).limit(4) }
  scope :title_contains,          -> (term) { where('title LIKE ?', "%#{term}%") }
  scope :body_contains,           -> (term) { where('body LIKE ?', "%#{term}%") }
  scope :search,                  -> (term) { title_contains(term).or(body_contains(term)) }
end
