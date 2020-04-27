using horizonsb.api.Commanding.Betting.Commands.Base.dl.wm.suite.interprocess.api.Commanding.Commands.Base;
using horizonsb.api.Commanding.Betting.Events.Base;
using horizonsb.api.Commanding.Betting.Servers.Base;

namespace horizonsb.api.Commanding.Betting.Commands.Inbounds.Commands.Base
{
  public abstract class WsInboundCommand : WsCommand
  {
    public IWsInboundEventRaisingBehavior EventRaisingBehavior { get; set; }

    public void RaiseWsEvent(WsInboundBaseServer inboundEventServer)
    {
      EventRaisingBehavior.RaiseWsEvent(inboundEventServer);
    }
  }
}