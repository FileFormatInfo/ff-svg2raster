<%@ page buffer="16kb"
		 contentType="text/plain;charset=utf-8"
		 import="java.io.*,
		 		 java.sql.*,
				 java.util.*"
		 session="false"
%><%
	response.setHeader("X-Robots-Tag", "NOINDEX");

	StringWriter sw = new StringWriter();
	PrintWriter pw = new PrintWriter(sw, true);

	pw.println("500 Server Error");
	pw.println();

	Throwable jspException = (Throwable)request.getAttribute("javax.servlet.jsp.jspException");
	if (jspException != null)
	{
		pw.println();
		pw.println("JSP Exception");
		pw.println("=============");
		toString(pw, jspException);
	}

	Throwable servletException = (Throwable)request.getAttribute("javax.servlet.error.exception");
	if (servletException != null)
	{
		pw.println();
		pw.println("Servlet Exception");
		pw.println("=================");
		toString(pw, servletException);
	}

	out.print(sw.getBuffer());

%><%!
	public static void toString(PrintWriter out, Throwable t)
	{
		if (t == null)
		{
			out.println("(no exception)");
			return;
		}
		out.print("Message: ");
		out.println(t.getMessage());
		out.print("Class:   ");
		out.println(t.getClass().getName());
		out.print("String:  ");
		out.println(t.toString());

		if (t instanceof SQLException)
		{
			SQLException sqlex = (SQLException)t;
			out.print("SQL State :");
			out.println(sqlex.getSQLState());
			out.print("SQL code: ");
			out.println(sqlex.getErrorCode());
		}
		out.println("Stack: ");
		t.printStackTrace(out);

		Throwable cause = t.getCause();
		if (cause != null)
		{
			toString(out, cause);
		}
		out.println();
	}
%>
