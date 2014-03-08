<%@ page contentType="text/plain;charset=utf-8"
		 errorPage="/_err/500.htm"
		 import="java.io.*,
		 		 java.text.*,
		 		 java.util.*,
		 		 org.apache.commons.fileupload.*,
		 		 org.apache.commons.fileupload.servlet.*"
%><%

	out.println("start");

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
			  out.println("Got a form field: " + item.getFieldName());
			}
			else
			{
				out.println("Got an uploaded file: " + item.getFieldName() + ", name = " + item.getName());

				int total = 0;
				int len;
				byte[] buffer = new byte[8192];
				while ((len = stream.read(buffer, 0, buffer.length)) != -1)
				{
					total += len;
					//res.getOutputStream().write(buffer, 0, len);
				}
				out.println("file size=" + total);
			}
		}
	}
	catch (Exception e)
	{
		out.print("ERROR: " + e.getMessage());
	}
	out.println("end");

%>
