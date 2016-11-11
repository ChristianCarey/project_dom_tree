describe DomSearcher do 

    let(:simple) { 
    %q(
      <html>
        <head>
          <meta charset="UTF-8">
          <title>title</title>
        </head>
        <body>
          <div class="outer big">
            <div class="inner small">
            </div>
          </div>
        </body>
      </html>
    )
  }
  let(:dom){ DomBuilder.new }
  let(:searcher){ DomSearcher.new }
  before do 
    dom.parse(simple)
  end

  
  describe "#find_by_attribute" do 
    it "returns an array of nodes with specified attributes" do 
      tag = searcher.find_by_attribute(dom.root, :class, "big")[0]
      expect(tag.type).to eq("div")
      expect(tag.klass).to eq(["outer", "big"])
    end
  end

  describe "#find_by_type" do 
    it "returns and array of nodes of a specified type" do 
      expect(searcher.find_by_type(dom.root, "div").length).to eq(2)
    end
  end

  describe '#search_parents' do

    it "searches a node's parents for attributes" do 
      inner_div = dom.root.first_child.child(1).first_child
      outer_div = searcher.search_parents(inner_div, :class, "outer")[0]
      expect(outer_div.type).to eq("div")
      expect(outer_div.klass).to eq(["outer", "big"])
    end
    
  end
end 