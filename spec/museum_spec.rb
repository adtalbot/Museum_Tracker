require('spec_helper')

describe(Museum) do
  describe('initialize') do
    it('initializes an instance of museum with a name') do
      test_museum = Museum.new({:name => 'Portland Museum', :id => nil})
      expect(test_museum.name()).to(eq('Portland Museum'))
    end
    it('can be initialized with a database ID') do
      test_museum = Museum.new({:name => 'Portland Museum', :id => 1})
      expect(test_museum.id()).to(eq(1))
    end
  end
end
