require('spec_helper')

describe(Artwork) do
  describe('initialize') do
    it('initializes artwork with a name') do
      test_artwork = Artwork.new({:name => 'Painting', :id => nil})
      expect(test_artwork).to(be_an_instance_of(Artwork))
    end
    it('initializes artwork with a database ID') do
      test_artwork = Artwork.new({:name => 'Painting', :id => 1})
      expect(test_artwork.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Artwork.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('adds artwork to the database') do
      test_artwork = Artwork.new({:name => 'Portland Musuem', :id => nil})
      test_artwork.save()
      expect(Artwork.all()).to(eq([test_artwork]))
    end
  end

  describe('#==') do
    it('recognizes that two artworks with the same name and ID are equal') do
      test_artwork = Artwork.new({:name => 'Painting', :id => nil})
      test_artwork2 = Artwork.new({:name => 'Painting', :id => nil})
      expect(test_artwork).to(eq(test_artwork2))
    end
  end

  describe('.find') do
    it('returns artwork by its ID') do
      test_artwork = Artwork.new({:name => 'Painting', :id => nil})
      test_artwork.save()
      test_artwork2 = Artwork.new({:name => 'Sculpture', :id => nil})
      test_artwork2.save()
      expect(Artwork.find(test_artwork.id())).to(eq(test_artwork))
    end
  end

  describe('#update') do
    it('updates artwork in the database') do
      test_artwork = Artwork.new({:name => 'Painting', :id => nil})
      test_artwork.save()
      test_artwork.update({:name => 'Sculpture'})
      expect(test_artwork.name()).to(eq('Sculpture'))
    end
  end
end
