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

  let(:void_html) {
    %q(
      <html>
        <input>
        <div>
        </div>
      </html>
    )
  }

  let(:dom){ DomBuilder.new }
  let(:searcher) { DomSearcher.new }

  describe "#build" do

    it "makes a tree replicating simple html structure" do
      dom.parse(html_shell)
      expect(dom.root.type).to eq("document")
      expect(dom.root.children[0].type).to eq("html")
    end

    it "doesn't allow void elements to have children" do 
      dom.parse(void_html)
      input = searcher.find_by_type(dom.root, "input")[0]
      expect(input.children).to be_empty
    end
  end
end
