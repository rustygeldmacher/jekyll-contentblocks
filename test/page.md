---
title: A test page
layout: default
---

{% contentfor css %}

  div {
    font-weight: bold;
  }

{% endcontentfor %}

This page is here to test the opposite of index.md

{% contentfor footer %}
  <div id="custom-footer">
  This is the custom footer for hte page.
  </div>
{% endcontentfor %}
