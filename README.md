
#### WM agnostic window resizing script

----

 * Script to resize and move the active X11 window to any side of the screen.
 * Requires `xdotool` to be installed

Usage:

```
resizer.sh [top|left|bottom|right|restore]
```

----

#### Known Issues:

 * Yes. There is a delay before the window gets resized from one side to the other. Do note that this intermediate state was intentional to ensure that the 'restored' state does not get overwritten if the script is re-run to move it to another side of the screen.
