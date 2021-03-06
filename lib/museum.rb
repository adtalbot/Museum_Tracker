class Museum
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_museums = DB.exec("SELECT * FROM museums;")
    museums = []
    returned_museums.each() do |museum|
      name = museum.fetch('name')
      id = museum.fetch('id').to_i()
      museums.push(Museum.new({:name => name, :id => id}))
    end
    museums
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO museums VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch('id').to_i()
  end

  define_method(:==) do |another_museum|
    self.name().==(another_museum.name()).&(self.id().==(another_museum.id()))
  end

  define_singleton_method(:find) do |id|
    result = DB.exec("SELECT * FROM museums WHERE id = #{id};")
    name = result.first.fetch('name')
    Museum.new({:name => name, :id => id})
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE museums SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM museums WHERE id = #{self.id()};")
  end

  define_method(:artworks) do
    museum_artworks = []
    artworks = DB.exec("SELECT * FROM artworks WHERE museum_id = #{self.id()};")
    artworks.each() do |artwork|
      name = artwork.fetch('name')
      museum_id = artwork.fetch('museum_id').to_i()
      museum_artworks.push(Artwork.new({:name => name, :museum_id => museum_id}))
    end
    museum_artworks
  end
end
