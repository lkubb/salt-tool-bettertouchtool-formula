# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as btt with context %}

BetterTouchTool is installed:
  pkg.installed:
    - name: {{ btt.lookup.pkg.name }}

BetterTouchTool setup is completed:
  test.nop:
    - name: Hooray, BetterTouchTool setup has finished.
    - require:
      - pkg: {{ btt.lookup.pkg.name }}
