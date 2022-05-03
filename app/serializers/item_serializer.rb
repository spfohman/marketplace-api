class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :desc, :price, :status 
  belongs_to :seller
  has_many :categories
  # instance methods 
  def price 
    "$#{'%.2f' % self.object.price}"
  end
  def status 
    if self.object.sold === false 
      return "Buy now!"
    else
      return "Sold"
    end
  end
end
