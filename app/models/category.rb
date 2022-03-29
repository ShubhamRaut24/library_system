class Category <ApplicationRecord

    has_many :book_categories
    has_many :books, through: :book_categories

    validates :name, presence: true, 
    uniqueness: { case_sensitive: false }, length: {minimum:3, maximum:25}
end