{#- Social Links -#}
{%- include "./_footer/social.swig" -%}

<div class="copyright">
  <span class="power-by">
    {{ __('footer.powered', '<a class="hexo-link" href="https://hexo.io/">Hexo</a>') }}
  </span>
  <span class="division">|</span>
  <span class="theme-info">
    {{ __('footer.theme') }} -
    <a class="theme-link" href="https://github.com/ahonn/hexo-theme-even">Even</a>
  </span>

  <span class="copyright-year">
    {%- set current = date(Date.now(), "YYYY") -%}
    &copy;
    {%- if theme.since and theme.since != current -%}
      {{ theme.since }} - {{ current }}
    {%- else -%}
      {{ current }}
    {%- endif -%}

    <span class="heart">
      <i class="iconfont icon-heart"></i>
    </span>
    <span class="author">{{ config.author }}</span>
    <br/>
     Copyright © {{ current }} All rights reserved. | <a href="https://beian.miit.gov.cn/#/Integrated/index" target="_blank">皖ICP备17025334号</a>
  </span>
</div>
