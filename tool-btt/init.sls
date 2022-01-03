{%- from 'tool-btt/map.jinja' import btt -%}

include:
  - .package
{%- if btt.users | selectattr('license', 'defined') %}
  - .licensed
{%- endif %}
{%- if btt.users | selectattr('btt.priohelper', 'defined') | selectattr('btt.priohelper') %}
  - .priohelper
{%- endif %}
