require('spec_helper')

describe(Museum) do
  describe('initialize') do
    it('initializes an instance of museum with a name') do
      test_museum = Museum.new({:name => 'Portland Museum', :id => nil})
      expect(test_museum).to(be_an_instance_of(Museum))
    end
    it('can be initialized with a database ID') do
      test_museum = Museum.new({:name => 'Portland Museum', :id => 1})
      expect(test_museum.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Museum.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('adds a museum to the database') do
      test_museum = Museum.new({:name => 'Portland Museum', :id => nil})
      test_museum.save()
      expect(Museum.all()).to(eq([test_museum]))
    end
  end

  describe('#==') do
    it('recognizes that two museums with the same name and id are equal') do
      test_museum = Museum.new({:name => 'Portland Museum', :id => nil})
      test_museum2 = Museum.new({:name => 'Portland Museum', :id => nil})
      expect(test_museum).to(eq(test_museum2))
    end
  end

  describe('.find') do
    it('returns a museum by its ID') do
      test_museum = Museum.new({:name => 'Portland Museum', :id => nil})
      test_museum.save()
      test_museum2 = Museum.new({:name => 'Atland Museum', :id => nil})
      test_museum2.save()
      expect(Museum.find(test_museum.id())).to(eq(test_museum))
    end
  end

  describe('#update') do
    it('updates a museum in the database') do
      test_museum = Museum.new({:name => 'Portland Museum', :id => nil})
      test_museum.save()
      test_museum.update(({:name => 'Atlanta Museum'}))
      expect(test_museum.name()).to(eq('Atlanta Museum'))
    end
  end

  describe('#delete') do
    it('deletes a museum from the database') do
      test_museum = Museum.new({:name => 'Portland Museum', :id => nil})
      test_museum.save()
      test_museum2 = Museum.new({:name => 'Atlanta Museum', :id => nil})
      test_museum2.save()
      test_museum2.delete()
      expect(Museum.all()).to(eq([test_museum]))
    end
  end

  describe('#artworks') do
    it('returns all of the artwork at a particular museum') do
      test_museum = Museum.new({:name => 'Portland museum', :id => nil})
      test_museum.save()
      test_artwork = Artwork.new({:name => 'Painting', :museum_id => nil})
      test_artwork.save()
      test_artwork2 = Artwork.new({:name => 'Sculpture', :museum_id => nil})
      test_artwork2.save()
      expect(test_museum.artworks()).to(eq([test_artwork, test_artwork2]))
    end
  end
end
