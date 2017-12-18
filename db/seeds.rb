customer_data = JSON.parse(File.read('db/seeds/customers.json'))

customer_data.each do |customer|
  Customer.create!(customer)
end

JSON.parse(File.read('db/seeds/movies.json')).each do |movie_data|
  movies = MovieWrapper.search(movie_data["title"])
  movie = movies.first
  p movie
  movie.inventory = movie_data['inventory']
  movie.save unless movies.empty?
end
