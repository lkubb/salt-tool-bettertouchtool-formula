{%- from 'tool-btt/map.jinja' import btt -%}

{%- for user in btt.users | selectattr('btt.license', 'defined') %}
BetterTouchTool is licensed for user {{ user.name }}:
  file.managed:
    - name: {{ user.home }}/Library/Application Support/BetterTouchTool/bettertouchtool.bttlicense
    - contents: |
        {{ user.btt.license | indent(8) }}
    - user: {{ user.name }}
    - group: {{ user.group }}
    - mode: '0600'
    - makedirs: True
{%- endfor %}
