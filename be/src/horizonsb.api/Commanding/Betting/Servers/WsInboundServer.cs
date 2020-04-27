using horizonsb.api.Commanding.Betting.Servers.Base;

namespace horizonsb.api.Commanding.Betting.Servers
{
  public sealed class WsInboundServer : WsInboundBaseServer
  {
    private WsInboundServer()
    {

    }
    public static WsInboundServer GetInboundServer { get; } = new WsInboundServer();
  }
}
