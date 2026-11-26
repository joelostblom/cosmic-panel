> [!TIP]
> **Try the panel pin shortcut on your COSMIC desktop**
>
> You can try this build without replacing the system package. These steps
> assume `cosmic-session` manages the panel and finds `~/.local/bin` before
> `/usr/bin` in its `PATH` (tested on Fedora).
>
> **Build and switch.** From the root of this checkout, run `pixi run build`
> for a release build without changing your desktop. To build and switch, run
> this in a terminal inside COSMIC:
>
> ```sh
> pixi run try-local
> ```
>
> This links the release binary into `~/.local/bin` and restarts the panel.
> It leaves existing files and links to other checkouts alone. The panel and
> dock may briefly disappear while COSMIC restarts them.
>
> **Bind the shortcut.** In **COSMIC Settings → Keyboard Shortcuts → Custom
> Shortcuts**, pick an unused key combination and give it this command:
>
> ```sh
> busctl --user call com.system76.CosmicPanel /com/system76/CosmicPanel com.system76.CosmicPanel TogglePanelPin
> ```
>
> With panel auto-hide enabled, the first press pins the panel on all displays
> where it is configured. The second press restores normal hover and overlap
> behavior. It doesn't change the dock or any saved settings.
>
> **Switch back.** Remove only this checkout's symlink and let COSMIC restart
> the packaged panel:
>
> ```sh
> pixi run restore-local
> ```

# Cosmic Panel (WIP)

### Building and Installing .deb

`dpkg-buildpackage -b -d`  
`cd ..`  
`sudo dpkg -i cosmic-panel_0.1.0_amd64.deb`  

### Configuring the panel / dock  
See the provided configs for the panel and dock in `data/default_schema`. 
The `com.system76.CosmicPanel` directory contains a key called entries, which is a list of profiles to be loaded. 
Each profile then has its own directory, for example, `com.system76.CosmicPanel.Panel`. 
You can make changes to the keys in this directory to alter the config. 
After making changes to copies of the provided config in data `data/`, you may install each to `$HOME/.config/cosmic/`
`find data/default_schema_copy -type f -exec install -Dm0644 {} {{$HOME/.config/cosmic}}/{} \;`

### Usage  
cosmic-panel

### Installing Plugins and Applets  
See the following for examples of applets and plugins which can be installed and used:  
https://github.com/pop-os/cosmic-applets  
 
