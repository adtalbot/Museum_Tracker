class Artwork
  attr_reader(:name, :museum_id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @museum_id = attributes.fetch(:museum_id)
  end

  define_singleton_method(:all) do
    returned_artwork = DB.exec("SELECT * FROM artworks;")
    artworks = []
    returned_artwork.each() do |artwork|
      name = artwork.fetch('name')
      museum_id = artwork.fetch('museum_id').to_i()
      artworks.push(Artwork.new({:name => name, :museum_id => museum_id}))
    end
    artworks
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO artworks (name) VALUES ('#{@name}') RETURNING museum_id;")
    @museum_id = result.first.fetch('museum_id').to_i()
  end

  define_method(:==) do |another_artwork|
    self.name().==(another_artwork.name()).&(self.museum_id().==(another_artwork.museum_id()))
  end

  define_singleton_method(:find) do |museum_id|
    result = DB.exec("SELECT * FROM artworks WHERE museum_id = #{museum_id};")
    name = result.fetch('name')
    Artwork.new({:name => name, :museum_id => museum_id})
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @museum_id = self.museum_id()
    DB.exec("UPDATE artworks SET name = '#{@name}' WHERE museum_id = #{@museum_id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM artworks WHERE museum_id = #{self.museum_id()};")
  end
end
