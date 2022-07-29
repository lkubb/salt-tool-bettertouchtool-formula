# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as btt with context %}

{%- if btt.users | selectattr('btt.priohelper', 'defined') | selectattr('btt.priohelper') | list %}

BetterTouchTool Priority Helper service is dead:
  service.dead:
    - name: {{ btt.lookup.service.name }}
    - enable: false

BetterTouchTool Priority Helper service is uninstalled:
  file.absent:
    - name: /Library/LaunchDaemons/{{ btt.lookup.service.name }}.plist
{%- endif %}
