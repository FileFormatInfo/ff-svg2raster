# Convert SVG to PNG

This is a simple web server that converts from SVG to PNG using [Apache Batik](http://xmlgraphics.apache.org/batik/using/transcoder.html).  You can see it in action by submitting the [form on FileFormat.Info](http://www.fileformat.info/convert/image/svg2png.htm).

The code is deliberately simple to avoid dependencies.  All necessary libraries are included.

The included [run](run.sh) and [deploy](deploy.sh) shell scripts use Google AppEngine
but the code should work on any recent Java web server.

## License

Copyright © 2005-2017 Andrew Marcuse

ff-svg2raster is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

ff-svg2raster is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero Public License for more details.

You should have received a copy of the GNU Affero Public License
along with ff-svg2raster.  If not, see <http://www.gnu.org/licenses/>.
