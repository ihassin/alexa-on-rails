# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Office.delete_all
Worker.delete_all

denver_office = Office.create(name: 'Denver')
new_york_office = Office.create(name: 'New York')
omaha_office = Office.create(name: 'Omaha')
london_office = Office.create(name: 'London')
dublin_office = Office.create(name: 'Dublin')
bangalore_office = Office.create(name: 'Bangalore')

omaha_office.workers << Worker.create(name: 'Andy')

denver_office.workers << Worker.create(name: 'Lizzie')
denver_office.workers << Worker.create(name: 'Ben')
denver_office.workers << Worker.create(name: 'Hap')
denver_office.workers << Worker.create(name: 'Emily')
denver_office.workers << Worker.create(name: 'Katie')
denver_office.workers << Worker.create(name: 'Paul')
denver_office.workers << Worker.create(name: 'Mike')
denver_office.workers << Worker.create(name: 'Dirk')
denver_office.workers << Worker.create(name: 'Robyn')

new_york_office.workers << Worker.create(name: 'Itamar')
new_york_office.workers << Worker.create(name: 'Tiani')
new_york_office.workers << Worker.create(name: 'Peter')
new_york_office.workers << Worker.create(name: 'Zac')
new_york_office.workers << Worker.create(name: 'David')
new_york_office.workers << Worker.create(name: 'Alex')
new_york_office.workers << Worker.create(name: 'Andrew')
new_york_office.workers << Worker.create(name: 'George')
new_york_office.workers << Worker.create(name: 'Chris')
