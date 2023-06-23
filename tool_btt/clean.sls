# vim: ft=sls

{#-
    *Meta-state*.

    Undoes everything performed in the ``tool_btt`` meta-state
    in reverse order.
#}

include:
  - .priohelper.clean
  - .license.clean
  - .package.clean
