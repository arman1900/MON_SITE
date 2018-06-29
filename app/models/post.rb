class Post < ApplicationRecord
    #belongs_to :category, dependent: :destroy
    #belongs_to :user, dependent: :destroy
    #validates_presence_of :user_id, :category_id, :title, :expense
end
