---
title: Page Three
layout: default
---

# CONTENT

This page has multiple content sections under the same name.

{% contentfor multi %}
---
number: 1
---
  The first section
{% endcontentfor %}

{% contentfor multi %}
---
number: 2
---
  The second section
{% endcontentfor %}

{% contentfor multi %}
---
number: 3
---
  The third section
{% endcontentfor %}

