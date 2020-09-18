require 'nokogiri'
require 'open-uri'
require 'database_cleaner'

DatabaseCleaner.clean_with(:truncation)

airlines = [
	'Alaska Airlines',
	'American Airlines',
	'United Airlines',
	'Delta Air Lines',
	'Island Air Service',
	'Spirit Airlines',
	'JetBlue Airways',
	'Cape Air',
	'Allegiant Air LLC',
	'Frontier Airlines',
	'New Axis Airways',
	'Boutique Air'
]

# scraping image urls
doc = Nokogiri.HTML(URI.open('https://www.wego.com/airlines'))

doc.css('airlines', 'div.airline lazy-image').each_with_index do |url, index|
	Airline.create(name: airlines[index], image_url: url.attr('src'))
end

reviews =
	Review.create(
		[
			{
				title: 'Greate airline',
				description: 'I really enjoyed my time flying with them',
				score: 5,
				airline: Airline.first
			},
			{
				title: 'Loved it!',
				description: 'Had a great time on the flight!',
				score: 4,
				airline: Airline.last
			}
		]
	)
