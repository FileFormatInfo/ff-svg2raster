<%@ page contentType="text/html;charset=utf-8"
		 errorPage="/500.jsp"
		 import="java.io.*,
		 		 java.text.*,
		 		 java.util.*,
		 		 java.util.logging.Logger,
		 		 java.util.regex.*,
		 		 org.apache.batik.transcoder.*,
		 		 org.apache.batik.transcoder.image.*,
		 		 org.apache.commons.fileupload.*,
		 		 org.apache.commons.fileupload.servlet.*,
		 		 org.apache.commons.fileupload.util.*,
		 		 org.apache.commons.lang3.*"
%><%!
    private static final Logger log = Logger.getLogger("convert.jsp");
    private static final Pattern refpat = Pattern.compile("^https?://www\\.fileformat\\.info/.*");
%><%

	if (request.getMethod().equalsIgnoreCase("post") == false)
	{
		response.sendRedirect("https://www.fileformat.info/convert/image/svg2raster.htm");
		return;
	}

	String referrer = request.getHeader("Referer");
	if (referrer == null)
	{
	    log.info("No referrer");
	}
	else if (refpat.matcher(referrer).matches() == false)
	{
	    log.warning("Foreign referrer: '" + referrer + "'");
    }
    
%><!DOCTYPE html>
<html>
<head>
<title>SVG2RASTER</title>
</head>
<body>
<pre>
<%
	out.println("Starting");
	Map<String, String> params = new HashMap<String, String>();
	byte[] data = null;
	String mimeType = null;
	byte[] result = null;

	try
	{
		ServletFileUpload upload = new ServletFileUpload();

		FileItemIterator iterator = upload.getItemIterator(request);
		while (iterator.hasNext())
		{
			FileItemStream item = iterator.next();
			InputStream stream = item.openStream();

			if (item.isFormField())
			{
				String value = Streams.asString(stream);
				out.println("DEBUG: form field: " + escape(item.getFieldName()) + "=" + escape(value));
				params.put(item.getFieldName(), value);
			}
			else
			{
				out.println("DEBUG: uploading file: " + escape(item.getFieldName()) + ", original name = " + escape(item.getName()));

				int total = 0;
				int len;
				byte[] buffer = new byte[8192];
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				while ((len = stream.read(buffer, 0, buffer.length)) != -1)
				{
					total += len;
					baos.write(buffer, 0, len);
				}
				out.println("INFO: file size=" + total);
				log.info("Uploaded file is " + total + " bytes");
				data = baos.toByteArray();
			}
		}
	}
	catch (Exception e)
	{
		out.print("UPLOAD ERROR: " + escape(e.getMessage()));
		log.severe("Exception during upload: " + e.getMessage());
		return;
	}
	out.println("INFO: upload complete");

	if (data == null || data.length == 0)
	{
		out.println("ERROR: no file!  Pick the .svg file you want to convert!");
		log.severe("No file uploaded");
		return;
	}

	try
	{
        String target = params.get("target");
        if (target == null)
        {
            target = "png";
        }

        Transcoder t;

        /*
         * Batik doesn't work with Java7, since they use internal com.sun classes that no longer exist.
         * In theory, I could use ImageIO to load & resave the png, but why isn't png good enough?
        if (target.equalsIgnoreCase("jpeg") || target.equalsIgnoreCase("jpg"))
        {
            t = new JPEGTranscoder();
            int quality = parseInt(params.get("quality"), 80);
            if (quality < 1 || quality > 100)
            {
                out.println("WARNING: Invalid JPEG quality '" + quality + "': reset to 80");
                quality = 80;
            }
            t.addTranscodingHint(JPEGTranscoder.KEY_QUALITY, new Float(.8));	//LATER: quality / 100.0
            mimeType = "image/jpeg";
        }
        else if (target.equalsIgnoreCase("tiff") || target.equalsIgnoreCase("tif"))
        {
            t = new TIFFTranscoder();
            mimeType = "image/tiff";
        }
        else*/
        {
            t = new PNGTranscoder();
            mimeType = "image/png";
        }

        int height = parseInt(params.get("height"), -1);
        if (height > 0 && height < 10000)
        {
            t.addTranscodingHint(PNGTranscoder.KEY_HEIGHT, new Float(height));
        }
        int width = parseInt(params.get("width"), -1);
        if (width > 0 && width < 10000)
        {
            t.addTranscodingHint(PNGTranscoder.KEY_WIDTH, new Float(width));
        }

        t.setErrorHandler(new BatikErrorHandler(new PrintWriter(out)));

        InputStream inStream = new ByteArrayInputStream(data);
        TranscoderInput input = new TranscoderInput(inStream);


        ByteArrayOutputStream outStream = new ByteArrayOutputStream(); //result.getOutputStream();
        TranscoderOutput output = new TranscoderOutput(outStream);
        // save the image
        t.transcode(input, output);

        result = outStream.toByteArray();

        out.println("INFO: complete.  file size=" + (result == null ? -1 : result.length));
        log.info("Complete!  svg size is " + (result == null ? -1 : result.length));
    }
    catch (Exception e)
    {
    	out.println("ERROR: " + e.getMessage());
    	e.printStackTrace(new PrintWriter(out, true));
    	log.severe("Exception during processing: " + e.getMessage());
    }
    out.println("INFO: done");
    out.println("</pre>");

    if (result != null && result.length > 0 && mimeType != null)
    {
    	out.print("<p>");
    	out.print("<img alt=\"Your converted image\" src=\"data:");
    	out.print(mimeType);
    	out.print(";base64,");
    	out.print(Base64.getMimeEncoder().encodeToString(result));
    	out.print("\" />");
    	out.println("</p>");
    }

%></body>
</html><%!
	int parseInt(String s, int defaultValue)
	{
		try
		{
			return Integer.parseInt(s);
		}
		catch (Exception e)
		{
		}
		return defaultValue;
	}

	class BatikErrorHandler
		implements ErrorHandler
	{
		PrintWriter out;

		public BatikErrorHandler(PrintWriter out)
		{
			this.out = out;
		}

		public void error(TranscoderException ex)
			throws TranscoderException
		{
			out.println("BATIK ERROR: " + escape(ex.getMessage()));
			ex.printStackTrace(out);
		}

		public void fatalError(TranscoderException ex)
			throws TranscoderException
		{
			out.println("BATIK FATAL ERROR: " + escape(ex.getMessage()));
			ex.printStackTrace(out);
		}

		public void warning(TranscoderException ex)
			throws TranscoderException
		{
			out.println("BATIK WARNING: " + escape(ex.getMessage()));
			ex.printStackTrace(out);
		}
	}

	static public String escape(String raw)
	{
		return raw == null ? "(null)" : StringEscapeUtils.escapeHtml4(raw);
	}
%>
