using System;
using System.Configuration;
using System.Net;
using System.Web;

namespace Dummy
{
	public class StatusHandler : IHttpHandler
	{
		public void ProcessRequest(HttpContext context)
		{
			var appSetting = ConfigurationManager.AppSettings["Environment"];

			if (string.IsNullOrEmpty(appSetting))
			{
				context.Response.AddHeader("X-7d-CustomMessage", "[Environment] setting missing from config file");
				context.Response.StatusCode = (int)HttpStatusCode.ServiceUnavailable;
			}
			else
			{
				context.Response.Write(DateTime.Now);
				context.Response.Write(Environment.NewLine);
				context.Response.StatusCode = (int)HttpStatusCode.OK;
				context.Response.Write(appSetting);
			}
			context.Response.Flush();
		}

		public bool IsReusable
		{
			get { return false; }
		}
	}
}