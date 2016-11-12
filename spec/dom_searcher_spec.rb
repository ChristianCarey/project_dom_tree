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
  let(:countable) {
    %q(
    <html>
      <head>
      </head>
      <body>
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
    it "returns an array of tags with specified attributes" do 
      tag = searcher.find_by_attribute(dom.root, :class, "big")[0]
      expect(tag.type).to eq("div")
      expect(tag.klass).to eq(["outer", "big"])
    end
  end

  describe "#find_by_type" do 
    it "returns and array of tags of a specified type" do 
      expect(searcher.find_by_type(dom.root, "div").length).to eq(2)
    end
  end

  describe '#search_parents' do

    it "searches a tag's parents for attributes" do 
      inner_div = dom.root.first_child.child(1).first_child
      outer_div = searcher.search_parents(inner_div, :class, "outer")[0]
      expect(outer_div.type).to eq("div")
      expect(outer_div.klass).to eq(["outer", "big"])
    end
  end

  describe "#count_children" do 

    it "returns the count of a tag's children" do
      
      expect(searcher.count_children(dom.root)).to eq(8)
    end
  end

  describe "#children_types" do 

    it "returns a hash with a count of each tag type" do 
      expect(searcher.children_types(dom.root)).to eq({"html"=>1, "head"=>1, "meta"=>1, "title"=>1, :text_node=>1, "body"=>1, "div"=>2})
    end
  end
end 