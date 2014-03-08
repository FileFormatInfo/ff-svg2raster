# Convert a SVG to a PNG

This is a simple web server that converts from SVG to PNG using [Apache Batik](http://xmlgraphics.apache.org/batik/using/transcoder.html).  You can see it in action by looking at the form at [FileFormat.Info](http://www.fileformat.info/convert/image/svg2png.htm).

The code is deliberately simple to avoid dependencies.  All necessary libraries are included.

You will need Jetty installed to run in development.  The included deploy script pushes to [AppFog](https://www.appfog.com/) but should work on any recent Java web server.

## License

Copyright © 2005-2014 Andrew Marcuse

ff-svg2raster is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

ff-svg2raster is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero Public License for more details.

You should have received a copy of the GNU Affero Public License
along with Foobar.  If not, see <http://www.gnu.org/licenses/>.