using System.Threading.Tasks;
using horizonsb.api.WSs;
using Microsoft.AspNetCore.Http;

public class WsMiddleware
{
  private readonly IWsConfiguration _wsConfiguration;

  public WsMiddleware(RequestDelegate next, IWsConfiguration wsConfiguration)
  {
    this._wsConfiguration = wsConfiguration;
    _wsConfiguration.EstablishConnection();
  }

  public async Task Invoke(HttpContext context)
  {
    await context.Response.WriteAsync("Ws response");
  }
}