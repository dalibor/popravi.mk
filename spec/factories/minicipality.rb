Factory.define :municipality do |municipality|
  municipality.name "Butel"
end

Factory.define :municipality1, :class => Municipality do |municipality|
  municipality.name "Municipality 1"
end

Factory.define :municipality2, :class => Municipality do |municipality|
  municipality.name "Municipality 2"
end

Factory.define :municipality3, :class => Municipality do |municipality|
  municipality.name "Municipality 3"
end
