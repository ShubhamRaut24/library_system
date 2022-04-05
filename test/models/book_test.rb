require 'test_helper'

class BookTest < ActiveSupport::TestCase
def setup
    @book = books(:one)
end


test "book should be valid" do  
   assert @book.valid?
  end

test "name for book should be present" do
    @book.name = " "
    assert_not @book.valid?
end
test "quantity for book should be present" do
  @book.quantity = nil
  assert_not @book.valid?
end

test "name of book should be unique" do
  @book.save
  @book2 = Book.new(name:"The Great Big Lion")
  @book2.save
  assert_not @book2.valid?
end

test "book name should not long than 100 characters" do
  @book.name = "a"*1000
  assert_not @book.valid?
end

test " book name should not small than 6 characters" do
  @book.name = "aa"
  assert_not @book.valid?
end

test " book status should true by default" do 
  @book.save
  assert @book.status
end

test "Authors name for book should be present" do
  @book.author = " "
  assert_not @book.valid?
end

test "Total for book should be present" do
  @book.total = nil
  assert_not @book.valid?
end

end
