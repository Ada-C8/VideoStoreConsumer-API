customer_data = JSON.parse(File.read('db/seeds/customers.json'))

customer_data.each do |customer|
  Customer.create!(customer)
end

JSON.parse(File.read('db/seeds/movies.json')).each do |movie_data|
  movies = MovieWrapper.search(movie_data["title"])

  movies.first.inventory = movie_data["inventory"]

  rating = ['G', 'PG', 'PG-13', 'R', 'NC-17']
  movies.first.rating = rating.sample

  movies.first.save unless movies.empty?
end
