  {##################}
  {### POST BLOCK ###}
  {##################}
  <article itemscope itemtype="http://schema.org/Article" class="post-block" lang="{{ post.lang or config.language }}">
    <link itemprop="mainEntityOfPage" href="{{ post.permalink }}">

    <span hidden itemprop="author" itemscope itemtype="http://schema.org/Person">
      <meta itemprop="image" content="{{ url_for(theme.avatar.url or theme.images + '/avatar.gif') }}">
      <meta itemprop="name" content="{{ author }}">
      <meta itemprop="description" content="{{ description }}">
    </span>

    {#################}
    {### POST BODY ###}
    {#################}
    <div class="post-body{%- if post.direction and post.direction.toLowerCase() === 'rtl' %} rtl{%- endif %}" itemprop="articleBody">

      {# Gallery support #}
      {%- if post.photos and post.photos.length %}
        <div class="post-gallery" itemscope itemtype="http://schema.org/ImageGallery">
          {%- for photo in post.photos %}
            <img src="{{ url_for(photo) }}" itemprop="contentUrl">
          {%- endfor %}
        </div>
      {%- endif %}

      {%- if is_index %}
        {%- if post.description and theme.excerpt_description %}
          <p>{{ post.description }}</p>
          <!--noindex-->
          {%- if theme.read_more_btn %}
            <div class="post-button">
              <a class="btn" href="{{ url_for(post.path) }}">
                {{ __('post.read_more') }} &raquo;
              </a>
            </div>
          {%- endif %}
          <!--/noindex-->
        {% elif post.excerpt %}
          {{ post.excerpt }}
          <!--noindex-->
          {%- if theme.read_more_btn %}
            <div class="post-button">
              <a class="btn" href="{{ url_for(post.path) }}" rel="contents">
                {{ __('post.read_more') }} &raquo;
              </a>
            </div>
          {%- endif %}
          <!--/noindex-->
        {% else %}
          {{ post.content }}
        {%- endif %}
      {% else %}
        {{ post.content }}
      {%- endif %}
    </div>

    {#####################}
    {### END POST BODY ###}
    {#####################}

    {%- if theme.related_posts.enable and (theme.related_posts.display_in_home or not is_index) %}
      {{ partial('_partials/post/post-related.swig') }}
    {%- endif %}

    {%- if not is_index %}
      {{- next_inject('postBodyEnd') }}

      <footer class="post-footer">
        {%- if post.tags and post.tags.length %}
          {%- if theme.tag_icon %}
            {%- set tag_indicate = '<i class="fa fa-tag"></i>' %}
          {% else %}
            {%- set tag_indicate = '#' %}
          {%- endif %}
          <div class="post-tags">
            {%- for tag in post.tags.toArray() %}
              <a href="{{ url_for(tag.path) }}" rel="tag">{{ tag_indicate }} {{ tag.name }}</a>
            {%- endfor %}
          </div>
        {%- endif %}

        {{ partial('_partials/post/post-footer.swig', {}, {cache: theme.cache.enable}) }}

        {{ post_nav(post) }}
      </footer>
    {% else %}
      <footer class="post-footer">
        <div class="post-eof"></div>
      </footer>
    {%- endif %}
  </article>
  {######################}
  {### END POST BLOCK ###}
  {######################}
