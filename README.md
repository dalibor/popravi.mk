![Travis status](https://travis-ci.org/dalibor/popravi.mk.png)

# popravi.mk

* http://github.com/dalibor/popravi.mk

## DESCRIPTION:

[Popravi.mk](http://popravi.mk/) is a web application built with Ruby on Rails that allows people to help in detecting urban issue on public area. It comes up with a web service used by [PopraviMK](https://github.com/dalibor/PopraviMK) Android mobile application. [PopraviMK](https://github.com/dalibor/PopraviMK) mobile application won the first [Android contest in Macedonia](http://android.vip.mk/winners) organized by Vip mobile operator in 2010.

## INSTALL:

- Clone repository

```
git clone git://github.com/dalibor/popravi.mk.git
cd popravi.mk
```

- Config database

```
cp config/database.yml.template config/database.yml
vi config/database.yml
```

- Config secret keys

```
cp config/config.yml.template config/config.yml
vim config/config.yml # edit config.yml file
```

- Install gems

```
gem install bundler
  bundle install
```

- Setup database

```
rake db:create
rake db:migrate
```

- Seed database

```
rake db:seed
```

- Run tests

```
rspec spec
```

## DEPLOY

  - Setup production

```
gitploy production setup
```

  - Deploy to production

```
gitploy production
```

## Contributors

  * See CONTRIBUTORS file

## License

GNU GENERAL PUBLIC LICENSE Version 2, see LICENSE.txt

Copyright (C) 2011 Dalibor Nasevic <dalibor.nasevic@gmail.com>

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
