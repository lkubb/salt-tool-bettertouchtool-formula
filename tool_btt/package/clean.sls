# vim: ft=sls

{#-
    Removes the BetterTouchTool package.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_config_clean = tplroot ~ ".config.clean" %}
{%- from tplroot ~ "/map.jinja" import mapdata as btt with context %}

include:
  - {{ sls_config_clean }}


BetterTouchTool is removed:
  pkg.removed:
    - name: {{ btt.lookup.pkg.name }}
    - require:
      - sls: {{ sls_config_clean }}
