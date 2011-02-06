Factory.define :category do |f|
  f.name "Abandoned vehicles"
  f.position
end

Factory.define :category1, :class => Category do |f|
  f.name "Category 1"
end

Factory.define :category2, :class => Category do |f|
  f.name "Category 2"
end

Factory.define :category3, :class => Category do |f|
  f.name "Category 3"
end
