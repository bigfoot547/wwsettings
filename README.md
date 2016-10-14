# Description
This mod adds an API for map-wide settings instead of game-wide settings.
The settings file is in **settings.dat** in your world folder.

## Documentation
This mod adds 2 commands as well as an API for other mods.

### Commands
  * Set a setting using the /wwset command!
  * Get a setting using the /wwset command!

### API
  * *wwsettings.setting_get(setting)*: This function returns the setting or *\<not set\>*.
  * *wwsettings.setting_set(setting, value)*: This funtion returns *true* for success or *false* for failure.
  But, if the function fails, minetest will probably crash instead.

# Mod status
This mod has been created and is now version **0.1**! YAY!

# Changelog
**0.1**: Just some minor stuff... such as its ***creation***!

# License
The code is licensed under the **LGPL v2.1+**
