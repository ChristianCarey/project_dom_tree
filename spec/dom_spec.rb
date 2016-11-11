describe Dom do


    let(:html) { %q(<div>
  div text before
  <p>
    p text
  </p>
  <div>
    more div text
  </div>
  div text after
</div>
  ) }

  let(:dom) { Dom.new }

  describe "#initialize" do
  end

  describe "#parse" do

  end

  describe "#build" do

    before do
      dom.parse(html)
      dom.build
    end

    it "builds an outer div" do
      div = dom.root.children[0]
      expect(div).to be_a(Tag)
      expect(div.attributes[:type]).to eq('div')
      expect(div.children[0].strip).to eq('div text before')
      expect(div.children[-1].strip).to eq('div text after')
    end

    it "builds an inner div" do
      outer_div = dom.root.children[0]
      inner_div = outer_div.children[2]
      expect(inner_div.attributes[:type]).to eq('div')
      expect(inner_div.children[0].strip).to eq('more div text')
    end
  end
end
