---
title: Page Three
layout: default
---

# CONTENT

This page defines several blocks with the same name, each with its own front
matter, and the layout loops over them.

{% contentfor testimonial %}
---
author: Ada Lovelace
---
A **delightful** plugin.
{% endcontentfor %}

{% contentfor testimonial %}
---
author: Alan Turing
---
Saved us hours of work.
{% endcontentfor %}

{% contentfor testimonial %}
Anonymous, but happy.
{% endcontentfor %}
