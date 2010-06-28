Factory.define :category do |category|
  category.name "Abandoned vehicles"
end

Factory.define :category1, :class => Category do |category|
  category.name "Category 1"
end

Factory.define :category2, :class => Category do |category|
  category.name "Category 2"
end

Factory.define :category3, :class => Category do |category|
  category.name "Category 3"
end
