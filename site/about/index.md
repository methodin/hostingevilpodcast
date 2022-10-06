---
layout: page
current: about
title: About
navigation: true
logo: 'assets/images/ghost.png'
class: page-template
subclass: 'post page'
---

<h2 class="center">Meet the authors</h2>

{% for author in site.data.authors %}
  <div class="site-header-content">
    <img class="author-profile-image" src="/{{author[1].picture}}" alt="{{author[1].username}}">
    <h1 class="site-title">{{author[1].name}}</h1>
    <h2 class="author-bio">{{author[1].bio}}</h2>
 </div>
{% endfor %}
