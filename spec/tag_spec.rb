describe Tag do
  
  let(:div_tag) { Tag.new("<div>") }
  let(:h1_tag) { Tag.new("<h1 class='bold'>") }
  let(:ul_tag) { Tag.new("<ul>") }
  before do 
    div_tag.children <<  "div text before"
    h1_tag.children << "HELLO WORLD"
    4.times { ul_tag.add_child(Tag.new("<li>")) }
  end

  describe "#initialize" do

    it "sets the void flag to true if Tag has a void type" do 
      expect(Tag.new("<input>").void).to be true
      expect(Tag.new("<div>").void).to be false
    end
  end

  describe "#add_child" do 

    it "adds another node to its children" do 
      div_tag.add_child(Tag.new("<a>"))
      expect(div_tag.children[1].attributes[:type]).to eq("a")
    end
  end
end