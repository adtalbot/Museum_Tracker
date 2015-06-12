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

  define_method(:save) do
    result = DB.exec("INSERT INTO artworks (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch('id').to_i()
  end

  define_method(:==) do |another_artwork|
    self.name().==(another_artwork.name()).&(self.id().==(another_artwork.id()))
  end
end
