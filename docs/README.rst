.. _readme:

BetterTouchTool Formula
=======================

Manages BetterTouchTool in the user environment (as far as possible without much effort). BetterTouchTool is sadly not really friendly for automatic configuration and I did not want to put the time into it to figure out some hacky solution.

.. contents:: **Table of Contents**
   :depth: 1

Usage
-----
Applying ``tool_btt`` will make sure ``btt`` is configured as specified.

Configuration
-------------

This formula
~~~~~~~~~~~~
The general configuration structure is in line with all other formulae from the `tool` suite, for details see :ref:`toolsuite`. An example pillar is provided, see :ref:`pillar.example`. Note that you do not need to specify everything by pillar. Often, it's much easier and less resource-heavy to use the ``parameters/<grain>/<value>.yaml`` files for non-sensitive settings. The underlying logic is explained in :ref:`map.jinja`.

User-specific
^^^^^^^^^^^^^
The following shows an example of ``tool_btt`` per-user configuration. If provided by pillar, namespace it to ``tool_global:users`` and/or ``tool_btt:users``. For the ``parameters`` YAML file variant, it needs to be nested under a ``values`` parent key. The YAML files are expected to be found in

1. ``salt://tool_btt/parameters/<grain>/<value>.yaml`` or
2. ``salt://tool_global/parameters/<grain>/<value>.yaml``.

.. code-block:: yaml

  user:

      # Persist environment variables used by this formula for this
      # user to this file (will be appended to a file relative to $HOME)
    persistenv: '.config/zsh/zshenv'

      # Add runcom hooks specific to this formula to this file
      # for this user (will be appended to a file relative to $HOME)
    rchook: '.config/zsh/zshrc'

      # This user's configuration for this formula. Will be overridden by
      # user-specific configuration in `tool_btt:users`.
      # Set this to `false` to disable configuration for this user.
    btt:
      license: |-
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
          <key>Product</key>
          <string>BetterTouchTool</string>
          <key>Name</key>
          <string>user</string>
          <key>Email</key>
          <string>user@example.com</string>
          <key>OrderID</key>
          <string>d8e8fca2dc0f896fd7cb4cb0031ba249</string>
          <key>LicenseType</key>
          <string>paddle_lifetime</string>
          <key>Licenses</key>
          <string>1</string>
          <key>Timestamp</key>
          <string>1234567890</string>
          <key>CheckoutName</key>
          <string>Us Er</string>
          <key>TransactionID</key>
          <string>123456789-123456789abcdef-abcdef0123</string>
          <key>Signature</key>
          <data>c0ff3ebab3=
        </data>
        </dict>
        </plist>
        # Installs the priority helper service.
        # If one user has it as true, this always installs the helper system-wide
        # and therefore overrides other user's settings.
        # This is what BTT does by default if it's installed system-wide,
        # did not want to fiddle around with it for the moment
      priohelper: true

Formula-specific
^^^^^^^^^^^^^^^^

.. code-block:: yaml

  tool_btt:

      # Specify an explicit version (works on most Linux distributions) or
      # keep the packages updated to their latest version on subsequent runs
      # by leaving version empty or setting it to 'latest'
      # (again for Linux, brew does that anyways).
    version: latest

      # Default formula configuration for all users.
    defaults:
      license: default value for all users

Development
-----------

Contributing to this repo
~~~~~~~~~~~~~~~~~~~~~~~~~

Commit messages
^^^^^^^^^^^^^^^

Commit message formatting is significant.

Please see `How to contribute <https://github.com/saltstack-formulas/.github/blob/master/CONTRIBUTING.rst>`_ for more details.

pre-commit
^^^^^^^^^^

`pre-commit <https://pre-commit.com/>`_ is configured for this formula, which you may optionally use to ease the steps involved in submitting your changes.
First install  the ``pre-commit`` package manager using the appropriate `method <https://pre-commit.com/#installation>`_, then run ``bin/install-hooks`` and
now ``pre-commit`` will run automatically on each ``git commit``.

.. code-block:: console

  $ bin/install-hooks
  pre-commit installed at .git/hooks/pre-commit
  pre-commit installed at .git/hooks/commit-msg

State documentation
~~~~~~~~~~~~~~~~~~~
There is a script that semi-autodocuments available states: ``bin/slsdoc``.

If a ``.sls`` file begins with a Jinja comment, it will dump that into the docs. It can be configured differently depending on the formula. See the script source code for details currently.

This means if you feel a state should be documented, make sure to write a comment explaining it.

Todo
----
* figure out some reliable way to automatically export/import presets for dotconfig compatibility
