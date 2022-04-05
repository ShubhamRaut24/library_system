class Book < ApplicationRecord
    before_save { self.name[0] = name[0].upcase}
     

    validates :name, presence: true, uniqueness: { case_sensitive: false },length:{minimum:6, maximum:100}
    validates :author, presence: true, length:{minimum:6, maximum:50}
    validates :total, presence: true
    validates :quantity, presence: true

    has_many :user_books
    has_many :users, through: :user_books

    has_many :book_categories
    has_many :categories, through: :book_categories
    
end
