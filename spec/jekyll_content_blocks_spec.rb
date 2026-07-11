require "spec_helper"

describe Jekyll::ContentBlocks do
  puts("jekyll #{jekyll_version}")

  context("against jekyll #{jekyll_version}") do
    before(:all) do
      expect(generate_test_site).to(be(true))
    end

    let(:index) { load_html("index.html") }

    describe "index.html" do
      let(:sidebar) { index.css("body > div > h2#sidebar").first }

      it "does not render the css block" do
        expect(index.css("style")).to(be_empty)
      end

      it "renders the custom sidebar" do
        expect(index.css("div.custom-sidebar")).not_to(be_empty)
        expect(index.css("div.sidebar-default")).to(be_empty)
      end

      it "renders the sidebar content block" do
        expect(sidebar).not_to(be_nil)
        expect(sidebar.text).to(eq("SIDEBAR"))
      end

      it "renders Liquid within a content block" do
        rendered_liquid = sidebar.css("+ p")
        expect(rendered_liquid).not_to(be_nil)
        expect(rendered_liquid.text).to(eq("3"))
      end

      it "does not render a block without content" do
        expect(index.css("head > style")).to(be_empty)
      end
    end

    describe "page.html" do
      let(:page) { load_html("page.html") }

      it "renders the css block" do
        expect(page.css("style")).not_to(be_empty)
      end

      it "does not process Markdown in the CSS block" do
        styles = page.css("style").text.gsub(/\s/, "")
        expect(styles).to(eq("div{font-weight:bold;}"))
      end

      it "renders the custom footer" do
        expect(page.css("div#footer")).to(be_empty)
        expect(page.css("div#custom-footer")).not_to(be_empty)
      end

      it "renders the default sidebar" do
        expect(page.css("div.sidebar-default")).not_to(be_empty)
        expect(page.css("div.custom-sidebar")).to(be_empty)
      end
    end

    describe "page2.html" do
      let(:page) { load_html("page2.html") }

      it "renders only the page2 sidebar" do
        sidebar = page.css("div.custom-sidebar")
        expect(sidebar).not_to(be_empty)
        expect(sidebar.text.strip).to(eq("A pretty simple sidebar."))
      end
    end

    describe "ifnothascontent" do
      it "renders defaults when content is not supplied" do
        expect(index.css("div#footer")).not_to(be_empty)
      end

      it "does not render when there is content" do
        expect(index.css("div[class=sidebar-default]")).to(be_empty)
      end
    end

    describe "content blocks in a collection" do
      let(:item_one) { load_item_html("one") }
      let(:item_two) { load_item_html("two") }

      it "should render the content block" do
        expect(item_one.css("div[class=sidebar-default]")).to(be_empty)
        expect(item_one.css("div[class=custom-sidebar]")).not_to(be_empty)
      end

      it "should skip a content block that was not defined" do
        expect(item_two.css("div[class=sidebar-default]")).not_to(be_empty)
        expect(item_two.css("div[class=custom-sidebar]")).to(be_empty)
      end

      it "should process Markdown inside the content block" do
        expect(item_one.css("div[class=custom-sidebar] ul li")).not_to(be_empty)
      end
    end

    describe "page3.html (repeated blocks and front matter)" do
      let(:page) { load_html("page3.html") }
      let(:testimonials) { page.css("div.testimonials div.testimonial") }

      it "collects each same-named block into contentblocks" do
        expect(testimonials.length).to(eq(3))
      end

      it "exposes each block's front matter under data" do
        expect(testimonials[0]["data-author"]).to(eq("Ada Lovelace"))
        expect(testimonials[1]["data-author"]).to(eq("Alan Turing"))
      end

      it "leaves data empty for a block without front matter" do
        expect(testimonials[2]["data-author"].to_s).to(eq(""))
      end

      it "converts each block's Markdown content" do
        expect(testimonials[0].css("strong").text).to(eq("delightful"))
      end

      it "does not render the section on pages without those blocks" do
        expect(index.css("div.testimonials")).to(be_empty)
      end
    end

    describe "contentblocks variable" do
      it "is present for a block that has content" do
        expect(index.css("span#cb-sidebar-present")).not_to(be_empty)
      end

      it "stays nil for a block referenced by tags but with no content" do
        # page.html renders {% ifhascontent sidebar %} but never defines a sidebar,
        # so contentblocks.sidebar must not have been created as an empty array.
        expect(load_html("page.html").css("span#cb-sidebar-present")).to(be_empty)
      end
    end

    describe "a block defined but left empty" do
      # `{% if contentblocks.x %}` tests whether the block was defined, while
      # `ifhascontent` tests for non-empty content — so they diverge here.
      let(:page) { load_html("emptyblock.html") }

      it "is present in contentblocks (the block was defined)" do
        expect(page.css("span#cb-sidebar-present")).not_to(be_empty)
      end

      it "counts as no content for ifhascontent / ifnothascontent" do
        expect(page.css("div.custom-sidebar")).to(be_empty)
        expect(page.css("div.sidebar-default")).not_to(be_empty)
      end
    end
  end
end
