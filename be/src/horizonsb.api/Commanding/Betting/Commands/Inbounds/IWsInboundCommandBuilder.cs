using horizonsb.api.Commanding.Betting.Commands.Inbounds.Commands.Base;

namespace horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds
{
  public interface IWsInboundCommandBuilder
  {
    WsInboundCommand Build(string wsPackage);
  }
}