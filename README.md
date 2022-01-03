# Bettertouchtool Formula
Sets up and configures BetterTouchTool (as far as possible without much effort). BetterTouchTool is sadly not really friendly for automatic configuration and I did not want to put the time into it to figure out some hacky solution.

## Usage
Applying `tool-btt` will make sure `btt` is configured as specified.

## Configuration
### Pillar
#### General `tool` architecture
Since installing user environments is not the primary use case for saltstack, the architecture is currently a bit awkward. All `tool` formulas assume running as root. There are three scopes of configuration:
1. per-user `tool`-specific
  > e.g. generally force usage of XDG dirs in `tool` formulas for this user
2. per-user formula-specific
  > e.g. setup this tool with the following configuration values for this user
3. global formula-specific (All formulas will accept `defaults` for `users:username:formula` default values in this scope as well.)
  > e.g. setup system-wide configuration files like this

**3** goes into `tool:formula` (e.g. `tool:git`). Both user scopes (**1**+**2**) are mixed per user in `users`. `users` can be defined in `tool:users` and/or `tool:formula:users`, the latter taking precedence. (**1**) is namespaced directly under `username`, (**2**) is namespaced under `username: {formula: {}}`.

```yaml
tool:
######### user-scope 1+2 #########
  users:                         #
    username:                    #
      xdg: true                  #
      dotconfig: true            #
      formula:                   #
        config: value            #
####### user-scope 1+2 end #######
  formula:
    formulaspecificstuff:
      conf: val
    defaults:
      yetanotherconfig: somevalue
######### user-scope 1+2 #########
    users:                       #
      username:                  #
        xdg: false               #
        formula:                 #
          otherconfig: otherval  #
####### user-scope 1+2 end #######
```

#### User-specific
The following shows an example of `tool-btt` pillar configuration. Namespace it to `tool:users` and/or `tool:btt:users`.
```yaml
user:
  btt:
    priohelper: true    # see formula-specific description
    license: |
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
```

#### Formula-specific
```yaml
tool:
  btt:
    defaults:                           # default formula configuration for all users
      priohelper: true                  # if one user has it as true, this always installs the helper system-wide and therefore overrides other user's settings
                                        # this is what BTT does by default if it's installed system-wide, did not want to fiddle around with it for the moment
```

### Dotfiles
`tool-btt.configsync` will recursively apply templates from 

- `salt://dotconfig/<user>/btt` or
- `salt://dotconfig/btt`

to the user's config dir for every user that has it enabled (see `user.dotconfig`). The target folder will not be cleaned by default (ie files in the target that are absent from the user's dotconfig will stay).

## Todo
- figure out some reliable way to automatically export/import presets for dotconfig compatibility
