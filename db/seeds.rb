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

# countries
country = Country.find_or_create_by_name('Македонија')

# regions
regions = ["Вардарски", "Источен", "Југозападен", "Југоисточен", "Пелагониски", "Полошки", "Североисточен", "Скопски"]
regions.each do |region|
  Region.find_or_create_by_name(region)
end

# municipalities
municipalities = [[1,"Аеродром"], [1,"Арачиново"], [3,"Берово"], [5,"Битола"], [7,"Богданци"], [6,"Боговиње"], [7,"Босилово"], [6,"Брвеница"], [1,"Бутел"], [7,"Валандово"], [7,"Василево"], [2,"Вевчани"], [8,"Велес"], [3,"Виница"], [2,"Вранештица"], [6,"Врапчиште"], [1,"Гази Баба"], [7,"Гевгелија"], [6,"Гостивар"], [8,"Градско"], [2,"Дебар"], [2,"Дебарца"], [3,"Делчево"], [8,"Демир Капија"], [5,"Демир Хисар"], [7,"Дојран"], [5,"Долнени"], [2,"Другово"], [1,"Ѓорче Петров"], [6,"Желино"], [2,"Зајас"], [1,"Зелениково"], [3,"Зрновци"], [1,"Илинден"], [6,"Јегуновце"], [8,"Кавадарци"], [3,"Карбинци"], [1,"Карпош"], [1,"Кисела Вода"], [2,"Кичево"], [7,"Конче"], [3,"Кочани"], [4,"Кратово"], [4,"Крива Паланка"], [5,"Кривогаштани"], [5,"Крушево"], [4,"Куманово"], [4,"Липково"], [3,"Лозово"], [6,"Маврово и Ростуша"], [3,"Македонска Каменица"], [2,"Македонски Брод"], [5,"Могила"], [8,"Неготино"], [5,"Новаци"], [7,"Ново Село"], [2,"Осломеј"], [2,"Охрид"], [1,"Петровец"], [3,"Пехчево"], [2,"Пласница"], [5,"Прилеп"], [3,"Пробиштип"], [7,"Радовиш"], [4,"Ранковце"], [5,"Ресен"], [8,"Росоман"], [1,"Сарај"], [3,"Свети Николе"], [1,"Сопиште"], [4,"Старо Нагоричане"], [2,"Струга"], [7,"Струмица"], [1,"Студеничани"], [6,"Теарце"], [6,"Тетово"], [1,"Центар"], [2,"Центар Жупа"], [1,"Чаир"], [8,"Чашка"], [3,"Чешиново-Облешево"], [1,"Чучер Сандево"], [3,"Штип"], [1,"Шуто Оризари"]]
municipalities.each do |municipality|
  Municipality.find_or_create_by_region_id_and_name(municipality[0], municipality[1])
end

# categories
categories = ["Автобуска станица", "Графит", "Ѓубре", "Зелена површина", "Јавен превоз", "Парк", "Паркинг простор", "Сообраќаен знак", "Улица", "Друго"]
categories.each do |category|
  Category.find_or_create_by_name(category)
end
