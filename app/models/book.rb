class Book < ApplicationRecord
    before_save { self.name[0] = name[0].upcase}

    validates :name, presence: true, length:{minimum:6, maximum:50}
    validates :author, presence: true, length:{minimum:6, maximum:50}


    has_many :user_books
    has_many :users, through: :user_books

    has_many :book_categories
    has_many :categories, through: :book_categories
    
end
