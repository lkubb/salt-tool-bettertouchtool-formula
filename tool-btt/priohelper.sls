{%- from 'tool-btt/map.jinja' import btt -%}

{%- if btt.users | selectattr('btt.priohelper', 'defined') | selectattr('btt.priohelper') %}
BetterTouchTool Priority Helper is launched on startup:
  file.managed:
    - name: /Library/LaunchDaemons/com.hegenberg.BetterTouchProcessPrioWatcher.plist
    - source:
      - /Applications/BetterTouchTool.app/Contents/Resources/com.hegenberg.BetterTouchProcessPrioWatcher.plist
      - salt://tool-btt/files/com.hegenberg.BetterTouchProcessPrioWatcher.plist
    - source_hash: a80f8c4a0543f7d1fd81286697a2fb565cce9653e0530edd4c6b10d0b1d40a84 # currently, should not change often
    - mode: '0600'
    - makedirs: True
{%- endif %}
