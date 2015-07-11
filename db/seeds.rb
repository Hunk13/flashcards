# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'nokogiri'
require 'open-uri'

url = "http://www.languagedaily.com/learn-german/vocabulary/common-german-words"
doc = Nokogiri::HTML(open(url))

words = doc.css("//tr").map do |word|
  { ger: word.css("td:nth-child(2)").text.capitalize, eng: word.css("td:nth-child(3)").text.capitalize }
end

words.slice!(0)
dat = Date.today + 3

words.each do |word|
  Card.create!(original_text: word[:ger], translated_text: word[:eng], review_date: dat)
end
