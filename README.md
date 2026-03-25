# Personnal-YASB-Scripts
I'll post my personnal python scripts that i use in here, mostly done with claude. Feel free to use, fork and edit, whatever.


# SCRIPTS

## Screenshot Full screen
This script takes a full-screen screenshot and saves it in ~\PICTURES\YASB_Screenshots as well as copying it in your clipboard.

### Add in your config.yml
```
  screenshot_fullscreen:
    type: "yasb.custom.CustomWidget"
    options:
      label: "<span>\uf030</span>"        # camera icon
      label_alt: "<span>\uf030</span>"
      class_name: "screenshot-widget"
      tooltip: true
      tooltip_label: "Full Screen"
      callbacks:
        on_left: "exec pythonw C:\\Users\\{USER}\\.config\\yasb\\scripts\\screenshot_fullscreen.py" 
        on_middle: "do_nothing"
        on_right: "do_nothing"
```
**Replace {User} with your username if you want to use the same directory i use or just change the directory to redirect to the .py file.

## Screenshot Region
This script launches the default windows screenshot tool in region selection mode.

### Add in your config.yml
```
  screenshot_region:
    type: "yasb.custom.CustomWidget"
    options:
      label: "<span>\uf247</span>"        # crop/region icon
      label_alt: "<span>\uf247</span>"
      class_name: "screenshot-widget"
      tooltip: true
      tooltip_label: "Select Region"
      callbacks:
        on_left: "exec pythonw C:\\Users\\{USER}\\.config\\yasb\\scripts\\screenshot_region.py"
        on_middle: "do_nothing"
        on_right: "do_nothing"
```
**Replace {User} with your username if you want to use the same directory i use or just change the directory to redirect to the .py file.


## Proton VPN
This script launches the protonVPN Systemtray popup in the top right corner. (visual glitches like popup sliding from bottom to top WILL happen)

### Add in your config.yml
```
protonvpn:
      type: "yasb.custom.CustomWidget"
      options:
        label: "<span>󰦝</span> VPN"
        label_alt: "<span>󰦝</span> VPN"
        class_name: "protonvpn-widget"
        tooltip: true
        tooltip_label: "VPN"
        callbacks:
          on_left: "exec powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File \"C:\\Users\\{USER}\\.config\\yasb\\scripts\\protonvpn_toggle.ps1\""
```
**Replace {User} with your username if you want to use the same directory i use or just change the directory to redirect to the .py file.  
**In the .ps1 file make sure your installation of ProtonVPN is in the same path as mine at line 63.
