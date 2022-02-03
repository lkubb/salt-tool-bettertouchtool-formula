{%- from 'tool-btt/map.jinja' import btt -%}

include:
  - .package

{%- if btt.users | selectattr('btt.priohelper', 'defined') | selectattr('btt.priohelper') %}

BetterTouchTool Priority Helper is launched on startup:
  file.managed:
    - name: /Library/LaunchDaemons/com.hegenberg.BetterTouchProcessPrioWatcher.plist
    - source:
        - /Applications/BetterTouchTool.app/Contents/Resources/com.hegenberg.BetterTouchProcessPrioWatcher.plist
        - salt://tool-btt/files/com.hegenberg.BetterTouchProcessPrioWatcher.plist
    - source_hash: 28611c5e87c32a3ef739c35c7949ae29466b8bdb83f0e5a804d3290378cdcfa3 # currently, should not change often
    - mode: '0600'
    - makedirs: True
    - require:
        - BetterTouchTool is installed
{%- endif %}
