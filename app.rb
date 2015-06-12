require('sinatra')
require('sinatra/reloader')
require('pg')
require('./lib/museum')
require('./lib/artwork')
also_reload('/lib/**/*.rb')

DB = PG.connect({:dbname => 'museum_tracker'})

get('/') do
  erb(:index)
end

get('/museums') do
  @museums = Museum.all()
  erb(:museums)
end

post('/museums') do
  name = params.fetch('name')
  @museum = Museum.new({:name => name, :id  => nil})
  @museum.save()
  redirect back
end

get('/artworks') do
  @artworks = Artwork.all()
  erb(:artworks)
end

post('/artworks') do
  name = params.fetch('name')
  @artwork = Artwork.new({:name => name, :id => nil})
  @artwork.save()
  redirect back
end

get('/museums/:id') do
  @museum = Museum.find(params.fetch('id').to_i())
  erb(:museum)
end
