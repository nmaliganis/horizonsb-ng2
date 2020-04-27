using System;
using System.Net;
using System.Threading.Tasks;
using horizonsb.api.WSs;
using Microsoft.AspNetCore.Http;

namespace horizonsb.api.Middlewares
{
  public class ExceptionHandlingMiddleware
  {
    private readonly IWsConfiguration _wsConfiguration;

    private readonly RequestDelegate _next;

    public ExceptionHandlingMiddleware(RequestDelegate next, IWsConfiguration wsConfiguration)
    {
      _next = next;
      _wsConfiguration = wsConfiguration;
    }

    public async Task Invoke(HttpContext context)
    {
      try
      {
        await _next.Invoke(context);
      }
      catch (Exception ex)
      {
        await HandleExceptionAsync(context, ex, _wsConfiguration);
      }
    }

    private static Task HandleExceptionAsync(HttpContext context, Exception exception,
      IWsConfiguration wsConfiguration)
    {
      var code = HttpStatusCode.InternalServerError; // 500 if unexpected

      wsConfiguration.EstablishConnection();

      context.Response.ContentType = "application/json";
      context.Response.StatusCode = (int)code;
      return context.Response.WriteAsync("An error occured.");
    }
  }
}