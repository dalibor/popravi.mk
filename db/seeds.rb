# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

# admin user
admin_email = "admin@popravi.mk"
admin_password = "popr@vi"
unless User.exists?(:email => admin_email)
  user = User.new(:email => admin_email, :password => admin_password, :password_confirmation => admin_password)
  user.role = "admin"
  user.save!
  user.confirm!
end

# countries, regions, municipalities
['Македонија'].each do |country_name|
  country = Country.find_or_create_by_name(country_name)
  Dir.entries("db/data/#{country_name}/").each do |region_name|
    unless region_name[0].chr == "."
      region = country.regions.find_or_create_by_name(region_name.gsub(/_/, ' '))
      Dir.entries("db/data/#{country_name}/#{region_name}").each do |municipality_name|
        unless municipality_name[0].chr == "."
          region.municipalities.find_or_create_by_name(municipality_name.gsub(/\..*/, '').gsub(/_/, ' '))
        end
      end
    end
  end
end

# categories
categories = %w{Автобуска\ станица Графит Дрво Ѓубре Јавен\ тоалет Напуштено\ возило Паркинг\ простор Парк Сообраќаен\ знак Улица Друго}
categories.each do |category|
  Category.find_or_create_by_name(category)
end
