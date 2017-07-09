<%@ page contentType="text/plain;charset=utf-8"
		 import="org.json.simple.*"
%><%
	JSONObject retVal = new JSONObject();
	retVal.put("success", Boolean.TRUE);
	retVal.put("message", "OK");
	retVal.put("version", System.getProperty("java.version", "Unknown") + " (" + System.getProperty("java.vm.name", "Unknown VM") + ")");
	retVal.put("java.vendor", System.getProperty("java.vendor"));
	retVal.put("java.version", System.getProperty("java.version"));
	retVal.put("java.specification.version", System.getProperty("java.specification.version"));
	retVal.put("java.class.version", System.getProperty("java.class.version"));
	retVal.put("com.google.appengine.runtime.version", System.getProperty("com.google.appengine.runtime.version"));
	retVal.put("java.vm.version", System.getProperty("java.vm.version"));
	retVal.put("os.name", System.getProperty("os.name"));
	retVal.put("java.vm.specification.version", System.getProperty("java.vm.specification.version"));
	retVal.put("com.google.appengine.application.version", System.getProperty("com.google.appengine.application.version"));
	retVal.put("java.vm.vendor", System.getProperty("java.vm.vendor"));
	retVal.put("java.vm.name", System.getProperty("java.vm.name"));
	retVal.put("file.encoding", System.getProperty("file.encoding"));
	retVal.put("com.google.appengine.runtime.environment", System.getProperty("com.google.appengine.runtime.environment"));
	String json = retVal.toString();
	String callback = request.getParameter("callback");
	if (callback != null && callback.matches("[a-zA-Z][-a-zA-Z0-9_]*"))
	{
		out.print(callback);
		out.print("(");
		out.print(json);
		out.print(");");
	}
	else
	{
		out.print(json);
	}
%>
