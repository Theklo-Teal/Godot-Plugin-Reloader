# Godot-Plugin-Reloader
A Godot Plugin that helps reloading other plugins.
Once enabled in `Project/Project Settings/Plugins`, it will show a button on the toolbar where you execute your project labeled "Re-Plug". Pressing this button will disable, then re-enable any plugins selected under the list at `Project/Tools/Re-Plug`. This way, you don't have to check the "Project Settings" window all the time, when testing your own plugins.

The list is updated when the Reloader is enabled and when the Re-Plug button is pressed. It will only show plugins enabled in the Project Settings. So you can have a mess of plugins and not have them affected or make it difficult to pick the ones you are developing.

# Installation
Copy the "plugin_reload" folder to an "addons" folder in your Godot project directory. In Linux, a symlink of the "plugin_reload" will also work. Then don't forget to enable it in the Project Settings.
