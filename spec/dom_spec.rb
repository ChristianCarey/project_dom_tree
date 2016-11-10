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

    it "creates an html root if there isn't one" do
      expect(dom.root).to be_a(Tag)
      expect(dom.root.attributes[:type]).to eq("html")
    end

    it "builds an outer div" do
      div = dom.root.children[0]
      expect(div).to be_a(Tag)
      expect(div.attributes[:type]).to eq('div')
      expect(div.text.strip).to eq('div text before')
    end
  end
end
