# jekyll-contentblocks

Gives you a mechanism in Jekyll to pass content up from pages into their parent layouts. It's kind of like having Rails' content_for available ion Jekyll.

## Installation

### Bundler (recommended)

Add this line to your Jekyll project's `Gemfile`:
```ruby
gem 'jekyll-contentblocks'
```

Then execute:
```bash
$ bundle install
```

Make sure your have a plugin that initializes Bundler:
```ruby
# _plugins/bundler.rb
require "rubygems"
require "bundler/setup"
Bundler.require(:default)
```

### Standalone
Execute:
```bash
$ gem install jekyll-contentblocks
```

And initialize it in plugin:
```ruby
# _plugins/ext.rb
require "rubygems"
require "jekyll-contentblocks"
```

## Usage

In your layout files, define `contentblock` blocks that say where content will end up. For example, say the file `_layouts/default.md` looks like this:
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
			{% contentblock sidebar}
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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
