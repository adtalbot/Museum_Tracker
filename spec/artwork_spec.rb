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
end
