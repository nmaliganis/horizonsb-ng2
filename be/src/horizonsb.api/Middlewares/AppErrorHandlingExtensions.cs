using System;
using Microsoft.AspNetCore.Builder;

namespace horizonsb.api.Middlewares
{
  public static class AppErrorHandlingExtensions
  {
    public static IApplicationBuilder UseWsExceptionHandling(this IApplicationBuilder app)
    {
      if (app == null)
        throw new ArgumentNullException(nameof(app));
      return app.UseMiddleware<ExceptionHandlingMiddleware>();
    }
  }
}