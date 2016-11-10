describe Tag do
  
  describe "#initialize" do
    it "sets the void flag to true if Tag has a void type" do 
      expect(Tag.new("<input>").void).to be true
      expect(Tag.new("<div>").void).to be false
    end
  end
end