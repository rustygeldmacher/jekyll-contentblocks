# jekyll-contentblocks

Gives you a mechanism in Jekyll to pass content up from pages into their parent
layouts. It's kind of like having Rails' content_for available for Jekyll.

## Installation

### Bundler (recommended)

Add this line to your Jekyll project's `Gemfile`:
```ruby
 group :jekyll_plugins do
   gem 'jekyll-contentblocks'
 end
```

Then execute:
```bash
$ bundle install
```

### Standalone

Execute:
```bash
$ gem install jekyll-contentblocks
```

And initialize it in a plugin:
```ruby
# _plugins/ext.rb
require "rubygems"
require "jekyll-contentblocks"
```

## Usage

In your layout files, define `contentblock` blocks that say where content will
end up. For example, say the file `_layouts/default.html` looks like this:

```html
<html>
  <head>
    {% contentblock scripts %}
  </head>
  <body>
    <div class="main">
      {{ content }}
    </div>
    <div class="sidebar">
      {% contentblock sidebar %}
    </div>
  </body>
</html>
```

Now to add content to the sidebar from a post, you'd just need to do something like:

```html
---
layout: default
---

Here is my post content.

{% contentfor sidebar %}
* Some content
* in a markdown list
* with some {{ 'liquid' }} tags too!
{% endcontentfor %}
```

Note that we didn't add anything to the `scripts` block in the post. That's OK,
content blocks without any content will be ignored.

### Skipping content conversion in a block

By default, a content block will be run through the converter for the current
file (Markdown, for instance). Sometimes this is not desirable, such as for
blocks containing code that shouldn't be modified. In the example above, content
in the `scripts` block will be converted by default. To prevent this, add the
`no-convert` option to the block, like this:

```
{% contentblock scripts no-convert %}
```

Now any content added to `scripts` will be placed in the block without any
formatting applied.

### Checking if a block has content

We might want to check if the particular contentblock has content before using
it in our template. To do this, use the `ifhascontent` tag:

```liquid
{% ifhascontent javascripts %}
  <script type="text/javascript>
    {% contentblock javascripts %}
  </script>
{% endifhascontent %}
```

Similarly, there's the opposite tag, `ifnothascontent`:

```liquid
{% ifnothascontent sidebar %}
  <div>
    This is our default sidebar.
  </div>
{% endifnothascontent %}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### Running the tests

Try to make sure that your changes work with all of the latest point releases
of Jekyll. To do this, run the test suite:

```bash
> bundle
> bundle exec appraisal install
> bundle exec appraisal rpsec
```
