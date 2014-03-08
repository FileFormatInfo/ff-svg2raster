package info.fileformat;

import org.mortbay.jetty.*;
import org.mortbay.jetty.webapp.*;

public class DevServer
{
	public static void main(String[] args) throws Exception
	{
		Server server = new Server(8080);

		WebAppContext context = new WebAppContext();
		context.setDescriptor("/home/amarcuse/site/ff-pdf2txt/www/WEB-INF/web.xml");
		context.setResourceBase("/home/amarcuse/site/ff-pdf2txt/www");
		context.setContextPath("/");
		context.setParentLoaderPriority(true);

		server.setHandler(context);
		server.start();
		server.join();
	}
}
