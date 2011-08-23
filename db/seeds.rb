# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

GuildMember.create(:name => 'Interslice')
User.create(:login => 'Interslice', :password => 'test', :password_confirmation => 'test', :is_admin => true)