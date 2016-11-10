describe TagAttributes do
  describe '#parse' do
    let(:string) { "<p class='foo bar' id='baz' name='fozzie'>" }
    let(:hash) { {type:'p', class:['foo', 'bar'], id:'baz', name:'fozzie'} }
    it 'turns a string into a hash of attributes and values' do
      expect(TagAttributes.new(string).hash).to eq(hash)
    end
  end
end
