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

			var s = context.Request.QueryString["env"].ToLower();
			context.Response.TrySkipIisCustomErrors = true;
			if (string.IsNullOrEmpty(appSetting))
			{
				context.Response.StatusCode = (int)HttpStatusCode.ServiceUnavailable;
				context.Response.Write("[Environment] setting missing from config file");
			}
			else if (!string.IsNullOrEmpty(s) && s != appSetting)
			{
				context.Response.StatusCode = (int)HttpStatusCode.Conflict;
				context.Response.Write(string.Format("Environment is not {0} it's {1}", s, appSetting));
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