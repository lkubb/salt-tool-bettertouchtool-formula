# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ ".package.install" %}
{%- from tplroot ~ "/map.jinja" import mapdata as btt with context %}

include:
  - {{ sls_package_install }}


{%- if btt.users | selectattr('btt.priohelper', 'defined') | selectattr('btt.priohelper') | list %}

BetterTouchTool Priority Helper service is installed:
  file.managed:
    - name: /Library/LaunchDaemons/{{ btt.lookup.service.name }}.plist
    - source:
        - /Applications/BetterTouchTool.app/Contents/Resources/com.hegenberg.BetterTouchProcessPrioWatcher.plist
        - salt://tool_btt/files/com.hegenberg.BetterTouchProcessPrioWatcher.plist
    - source_hash: 28611c5e87c32a3ef739c35c7949ae29466b8bdb83f0e5a804d3290378cdcfa3 # currently, should not change often
    - mode: '0644'
    - makedirs: true
    - require:
        - BetterTouchTool is installed

BetterTouchTool Priority Helper service is running:
  service.running:
    - name: {{ btt.lookup.service.name }}
    - enable: true
{%- endif %}
