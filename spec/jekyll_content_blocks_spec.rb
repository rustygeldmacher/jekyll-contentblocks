require 'spec_helper'

describe Jekyll::ContentBlocks do
  jekyll_version = `jekyll --version`.strip
  puts jekyll_version

  context "against #{jekyll_version}" do
    before(:all) do
      expect(generate_test_site).to be true
    end

    let(:page) { load_index_html.html }
    let(:sidebar) { page.css('body > div > h2#sidebar').first }

    it 'renders the sidebar content block' do
      expect(sidebar).not_to be_nil
      expect(sidebar.text).to eq 'SIDEBAR'
    end

    it 'renders Liquid within a content block' do
      rendered_liquid = sidebar.css('+ p')
      expect(rendered_liquid).not_to be_nil
      expect(rendered_liquid.text).to eq '3'
    end
  end
end
