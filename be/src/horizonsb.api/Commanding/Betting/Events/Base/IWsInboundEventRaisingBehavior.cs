using horizonsb.api.Commanding.Betting.Servers.Base;

namespace horizonsb.api.Commanding.Betting.Events.Base

{
  public interface IWsInboundEventRaisingBehavior
  {
    void RaiseWsEvent(WsInboundBaseServer inboundEventServer);
  }
}