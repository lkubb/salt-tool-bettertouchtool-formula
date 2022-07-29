# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as btt with context %}


{%- for user in btt.users | selectattr('btt.license', 'defined') | selectattr('btt.license') %}

BetterTouchTool is licensed for user {{ user.name }}:
  file.absent:
    - name: {{ user._btt.datadir | path_join('bettertouchtool.bttlicense') }}
{%- endfor %}
