{% extends '_layout.swig' %}
{% block title %}{{ page.title }} | {{ title }}{% endblock %}
{% import '_macro/sidebar.swig' as sidebar_template with context %}

{% block content %}

  {{ partial('_macro/contact.swig', {post: page}) }}

{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(false) }}
{% endblock %}
