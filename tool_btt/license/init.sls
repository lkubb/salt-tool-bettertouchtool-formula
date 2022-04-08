# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ ".package.install" %}
{%- from tplroot ~ "/map.jinja" import mapdata as btt with context %}

include:
  - {{ sls_package_install }}

{%- for user in btt.users | selectattr('btt.license', 'defined') | selectattr('btt.license') %}

BetterTouchTool is licensed for user {{ user.name }}:
  file.managed:
    - name: {{ user._btt.datadir | path_join('bettertouchtool.bttlicense') }}
    - contents: |
        {{ user.btt.license | indent(8) }}
    - user: {{ user.name }}
    - group: {{ user.group }}
    - mode: '0600'
    - dir_mode: '0700'
    - makedirs: true
    - require:
      - sls: {{ sls_package_install }}
{%- endfor %}
