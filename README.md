# jekyll-contentblocks

Gives you a mechanism in Jekyll to pass content up from pages into their parent
layouts, with front matter and loopability. It's kind of like having Rails' 
content_for available for Jekyll.

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

We can write multiple blocks in our page with the same block name:

```html
---
layout: default
---

Here are the various academic qualifications I have been awarded over the years:

{% contentfor qualification %}
# Undergraduate Degree
* University of Edinburgh
* **Computational Phyics BSc**
* **Graduated**: 2018
* Grade: Upper Second with Honours
{% endcontentfor %}


{% contentfor qualification %}
# Masters' Degree
* University of Copenhagen
* **Advanced Machine Learning**
* **Graduated**: 2019
* Grade: First with Honours
{% endcontentfor %}


{% contentfor qualification %}
# Doctorate
* University of Southampton
* **Large-Scale Modelling using Neural Networks**
* **Completed**: 2022
{% endcontentfor %}
```

Then we can iterate over them in the layout file like so:

```html
<html>
  <head>
    {% contentblock scripts %}
  </head>
  <body>
    <div class="heading">
      {{ content }}
    </div>
    <hr/>
    <div class="qualifications">
      {% for qualification in page.contentblocks.qualifications %}
        {{ qualification.content }}
      {% endfor %}
    </div>
  </body>
</html>
```

For each block type, an object is available under `page.contentblocks` with the block type's name. 
The different blocks are then in an array under this object. We can access the content using
 the key `content`, but we can also use the key `data` to access
any front matter from the block. This allows us quite a fine level of control in our posts, 
and allows adding quite complex pages but sourcing the data only from some very simple markdown,
that a client without technical knowledge, for example, would be able to edit.

Using the above example, say that we want to add an image of our graduation ceremony,
a link to the university's website, and a logo for the university. This would look
a bit clumsy if done in plain markdown, because the text would be inline, but by using front 
matter we can specify the images just as links, format these nicely within html, and include
our specific content afterwards:

```html
---
layout: default
---

Here are the various academic qualifications I have been awarded over the years:

{% contentfor qualification %}
---
photo: /img/uoe-graduation-2018.jpg
photo_alt: "I will never forget the day I graduated in the beautiful McEwan Hall, in front of friends and family."
logo: "https://www.ed.ac.uk/assets/logo_big.png"
link: "https://www.ed.ac.uk/"
---
# Undergraduate Degree
* University of Edinburgh
* **Computational Phyics BSc**
* **Graduated**: 2018
* Grade: Upper Second with Honours
{% endcontentfor %}


{% contentfor qualification %}
---
photo: /img/masters.jpg
photo_alt: "Copenhagen is quite possibly the most beautiful city in Europe; studying here was a pleasure and a privilege"
logo: "/img/ku.jpg"
link: "https://www.ku.dk/"
---
# Masters' Degree
* University of Copenhagen
* **Advanced Machine Learning**
* **Graduated**: 2019
* Grade: First with Honours
{% endcontentfor %}


{% contentfor qualification %}
---
photo: /img/soton.png
photo_alt: "So glad to have that final viva voce out of the way!"
logo: "https://soton.ac.uk/assets/logos/soton-logo.jpg"
link: "https://www.soton.ac.uk"
---
# Doctorate
* University of Southampton
* **Large-Scale Modelling using Neural Networks**
* **Completed**: 2022
{% endcontentfor %}
```

```html
<html>
  <head>
    {% contentblock scripts %}
  </head>
  <body>
    <div class="Heading">
      {{ content }}
    </div>
    <hr/>
    <div class="qualifications">
      <div class="image_carousel">
		{% for qualification in page.contentblocks.qualifications %}
		  <div class="vertical_layout"> 
		    <div>
              <img class="popup rounded_corners mouse_over_highlight" 
                  href={{ qualification.data.photo }} alt={{ qualification.photo_alt }}>
            </div>
            <div>
              <a href={{ qualification.data.link }}>
                <img href={{ qualification.data.logo }}/>
              </a>
            <div class=content_box> 
			  {{ qualification.content }}
			</div>
		  </div>
	    {% endfor %}
	  </div>
    </div>
  </body>
</html>
```

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
  <script type="text/javascript">
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
