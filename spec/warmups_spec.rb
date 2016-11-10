require 'warmups'
require 'rspec'

describe Tag do
  describe '#parse' do
    let(:string) { "<p class='foo bar' id='baz' name='fozzie'>" }
    let(:hash) { {type:'p', class:['foo', 'bar'], id:'baz', name:'fozzie'} }
    it 'turns a string into a hash of attributes and values' do
      expect(Tag.new.parse(string)).to eq(hash)
    end
  end
end
