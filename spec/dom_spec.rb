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

    it "creates an html root if there isn't one" do 
      dom.parse(html)
      dom.build
      expect(dom.root).to be_a(Tag)
      expect(dom.root.attributes[:type]).to eq("html")
    end
  end
end