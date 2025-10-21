Icons for keep-display

Included:
- `keep_awake.svg` - A simple, flat SVG icon representing a clock to indicate 'stay awake'.

Converting to ICO/PNG

On Windows you can use Inkscape or ImageMagick to convert the SVG to an ICO:

Using Inkscape (recommended for crisp results):

inkscape keep_awake.svg --export-type=png --export-filename=keep_awake.png -w 256 -h 256

Then convert to ICO with ImageMagick:

magick convert keep_awake.png -define icon:auto-resize=256,128,64,48,32,16 keep_awake.ico

Or directly with ImageMagick (if compiled with rsvg support):

magick convert keep_awake.svg -background none -resize 256x256 keep_awake.png

License: You can use and modify the icons freely in this repository.
