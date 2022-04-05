require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

    def setup
        @category = categories(:one)
    end

    test "catergory should be valid" do
    assert @category.valid?
    end

    test "name should be present" do
        @category.name = " "
        assert_not @category.valid?
    end

    test "category name should be unique" do

        @category.save
        @category2 = Category.new(name:"Sports")
        @category2.save
        assert_not @category2.valid?

    end

    test "name should not long than 25 characters" do
        @category.name = "a"*26
        assert_not @category.valid?
    end

    test "name should not small than 3 characters" do
        @category.name = "aa"
        assert_not @category.valid?
    end

end