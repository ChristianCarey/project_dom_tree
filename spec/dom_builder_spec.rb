describe DomBuilder do


  let(:html_shell) { 
    %q(
      <html>
        <head>
          <meta charset="UTF-8">
          <title>title</title>
        </head>
        <body>
        </body>
      </html>
    )
  }

  describe "#initialize" do
  end

  describe "#build" do

    it "makes a tree replicating simple html structure" do
      dom = DomBuilder.new
      dom.parse(html_shell)
      dom.build
      expect(dom.root.type).to eq("document")
      expect(dom.root.children[0].type).to eq("html")
    end

    it "builds an inner div" do
      outer_div = dom.root.children[0]
      inner_div = outer_div.children[2]
      expect(inner_div.attributes[:type]).to eq('div')
      expect(inner_div.children[0].strip).to eq('more div text')
    end
  end
end
