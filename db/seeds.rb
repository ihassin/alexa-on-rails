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

Worker.create(name: 'Andy', office_id: omaha_office.id)

Worker.create(name: 'Hap', office_id: denver_office.id)
Worker.create(name: 'Katie', office_id: denver_office.id)
Worker.create(name: 'Paul', office_id: denver_office.id)
Worker.create(name: 'Mike', office_id: denver_office.id)

Worker.create(name: 'Itamar', office_id: new_york_office.id)
Worker.create(name: 'Tiani', office_id: new_york_office.id)
Worker.create(name: 'Nicole', office_id: new_york_office.id)
Worker.create(name: 'Peter', office_id: new_york_office.id)
Worker.create(name: 'Zac', office_id: new_york_office.id)
Worker.create(name: 'David', office_id: new_york_office.id)
Worker.create(name: 'Alex', office_id: new_york_office.id)
Worker.create(name: 'Andrew', office_id: new_york_office.id)
Worker.create(name: 'George', office_id: new_york_office.id)
Worker.create(name: 'Chris', office_id: new_york_office.id)
