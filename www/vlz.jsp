<%@ page contentType="image/png"
		 errorPage="/500.jsp"
		 import="java.awt.Color,
		 		 java.io.*,
		 		 java.net.*,
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
    private static final Logger log = Logger.getLogger("vlz.jsp");
    private static final Pattern refpat = Pattern.compile("^https?://www\\.vectorlogo\\.zone/.*");
%><%

	String referrer = request.getHeader("Referer");
	if (referrer == null)
	{
	    log.info("No referrer");
	}
	else if (refpat.matcher(referrer).matches() == false)
	{
	    log.warning("Foreign referrer: '" + referrer + "'");
    }

    String vlzPath = request.getParameter("svg");
    if (vlzPath == null) {
		log.severe("No SVG URL from " + referrer);
		throw new Exception("Error missing svg parameter");
    }

	StringBuilder data = new StringBuilder();
	byte[] result = null;

	URL svgURL = new URL("https", "www.vectorlogo.zone", vlzPath);
	try {
        BufferedReader in = new BufferedReader(new InputStreamReader(svgURL.openStream()));

        String inputLine;
        while ((inputLine = in.readLine()) != null) {
            data.append(inputLine);
		}
        in.close();
	}
	catch (Exception e) {
		log.severe("Unable to load SVG from " + svgURL.toString() + ": " + e.getMessage());
		throw new Exception("Error reading SVG", e);
	}

	if (data.length() == 0)
	{
	    log.severe("No file uploaded");
		throw new Exception("No file uploaded");
	}

	Transcoder t = new PNGTranscoder();

	t.addTranscodingHint(PNGTranscoder.KEY_BACKGROUND_COLOR, Color.WHITE);

	int height = parseInt(request.getParameter("height"), -1);
	if (height > 0 && height < 10000)
	{
		t.addTranscodingHint(PNGTranscoder.KEY_HEIGHT, new Float(height));
	}
	int width = parseInt(request.getParameter("width"), -1);
	if (width > 0 && width < 10000)
	{
		t.addTranscodingHint(PNGTranscoder.KEY_WIDTH, new Float(width));
	}
	t.addTranscodingHint(PNGTranscoder.KEY_FORCE_TRANSPARENT_WHITE, true);
	

	Reader reader = new StringReader(data.toString());
	TranscoderInput input = new TranscoderInput(reader);

	response.reset();
	response.setContentType("image/png");

	OutputStream os = response.getOutputStream();
	TranscoderOutput output = new TranscoderOutput(os);
	// save the image
	t.transcode(input, output);

	os.flush();
	os.close();
	if (1 == 1)
	{
		return;
	}

%><%!
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
%>
