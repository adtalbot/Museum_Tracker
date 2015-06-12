require('spec_helper')

describe(Museum) do
  describe('initialize') do
    it('initializes an instance of museum with a name') do
      test_museum = Museum.new({:name => 'Portland Museum', :id => nil})
      expect(test_museum.name()).to(eq('Portland Museum'))
    end
  end
end
