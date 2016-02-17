require 'spec_helper'

describe Jekyll::ContentBlocks do
  puts "jekyll #{jekyll_version}"

  context "against jekyll #{jekyll_version}" do
    before(:all) do
      expect(generate_test_site).to be true
    end

    let(:index) { load_html('index.html') }

    describe 'index.html' do
      let(:sidebar) { index.css('body > div > h2#sidebar').first }

      it 'does not render the css block' do
        expect(index.css('style')).to be_empty
      end

      it 'renders the custom sidebar' do
        expect(index.css('div.custom-sidebar')).not_to be_empty
        expect(index.css('div.sidebar-default')).to be_empty
      end

      it 'renders the sidebar content block' do
        expect(sidebar).not_to be_nil
        expect(sidebar.text).to eq 'SIDEBAR'
      end

      it 'renders Liquid within a content block' do
        rendered_liquid = sidebar.css('+ p')
        expect(rendered_liquid).not_to be_nil
        expect(rendered_liquid.text).to eq '3'
      end

      it 'does not render a block without content' do
        expect(index.css('head > style')).to be_empty
      end
    end

    describe 'page.html' do
      let(:page) { load_html('page.html') }

      it 'renders the css block' do
        expect(page.css('style')).not_to be_empty
      end

      it 'does not process Markdown in the CSS block' do
        styles = page.css('style').text.gsub(/\s/, '')
        expect(styles).to eq 'div{font-weight:bold;}'
      end

      it 'renders the custom footer' do
        expect(page.css('div#footer')).to be_empty
        expect(page.css('div#custom-footer')).not_to be_empty
      end

      it 'renders the default sidebar' do
        expect(page.css('div.sidebar-default')).not_to be_empty
        expect(page.css('div.custom-sidebar')).to be_empty
      end
    end

    describe 'page2.html' do
      let(:page) { load_html('page2.html') }

      it 'renders only the page2 sidebar' do
        sidebar = page.css('div.custom-sidebar')
        expect(sidebar).not_to be_empty
        expect(sidebar.text.strip).to eq 'A pretty simple sidebar.'
      end
    end

    describe 'ifnothascontent' do
      it 'renders defaults when content is not supplied' do
        expect(index.css('div#footer')).not_to be_empty
      end

      it 'does not render when there is content' do
        expect(index.css('div[class=sidebar-default]')).to be_empty
      end
    end

    if Jekyll.supports_collections?
      describe 'content blocks in a collection' do
        let(:item_one) { load_item_html('one') }
        let(:item_two) { load_item_html('two') }

        it 'should render the content block' do
          expect(item_one.css('div[class=sidebar-default]')).to be_empty
          expect(item_one.css('div[class=custom-sidebar]')).not_to be_empty
        end

        it 'should skip a content block that was not defined' do
          expect(item_two.css('div[class=sidebar-default]')).not_to be_empty
          expect(item_two.css('div[class=custom-sidebar]')).to be_empty
        end

        it 'should process Markdown inside the content block' do
          expect(item_one.css('div[class=custom-sidebar] ul li')).not_to be_empty
        end
      end
    end
  end
end
