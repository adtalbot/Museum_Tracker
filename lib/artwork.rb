class Artwork
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_artwork = DB.exec("SELECT * FROM artworks;")
    artworks = []
    returned_artwork.each() do |artwork|
      name = artwork.fetch('name')
      id = artwork.fetch('id').to_i()
      artworks.push(Artwork.new({:name => name, :id => id}))
    end
    artworks
  end
end
