using horizonsb.api.Commanding;

public sealed class WsServer : WsBaseServer
{
  private WsServer()
  {

  }
  public static WsServer GetWsServer { get; } = new WsServer();
}