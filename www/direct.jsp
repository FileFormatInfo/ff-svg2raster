<%@ page contentType="image/png"
		 errorPage="/500.jsp"
		 import="java.io.*,
		 		 java.text.*,
		 		 java.util.*,
		 		 org.apache.batik.transcoder.*,
		 		 org.apache.batik.transcoder.image.*,
		 		 org.apache.commons.fileupload.*,
		 		 org.apache.commons.fileupload.servlet.*,
		 		 org.apache.commons.fileupload.util.*,
		 		 org.apache.commons.lang3.*"
%><%

	if (request.getMethod().equalsIgnoreCase("post") == false)
	{
		response.sendRedirect("http://www.fileformat.info/convert/image/svg2png.htm");
		return;
	}

%><%
	Map<String, String> params = new HashMap<String, String>();
	byte[] data = null;
	byte[] result = null;

	ServletFileUpload upload = new ServletFileUpload();

	FileItemIterator iterator = upload.getItemIterator(request);
	while (iterator.hasNext())
	{
		FileItemStream item = iterator.next();
		InputStream stream = item.openStream();

		if (item.isFormField())
		{
			String value = Streams.asString(stream);
			params.put(item.getFieldName(), value);
		}
		else
		{
			int total = 0;
			int len;
			byte[] buffer = new byte[8192];
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			while ((len = stream.read(buffer, 0, buffer.length)) != -1)
			{
				total += len;
				baos.write(buffer, 0, len);
			}
			data = baos.toByteArray();
		}
	}

	if (data == null || data.length == 0)
	{
		throw new Exception("No file uploaded");
	}

	Transcoder t = new PNGTranscoder();

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

	InputStream inStream = new ByteArrayInputStream(data);
	TranscoderInput input = new TranscoderInput(inStream);

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
