using System.Collections.Generic;
using horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds;
using horizonsb.common.infrastructure.Exceptions.Commanding;

namespace horizonsb.api.Commanding.Betting.CommandRepositories
{
  public sealed class WsInboundCommandBuilderRepository
  {
    private readonly Dictionary<string, IWsInboundCommandBuilder> _cmdBuilders;


    private WsInboundCommandBuilderRepository()
    {
      _cmdBuilders = new Dictionary<string, IWsInboundCommandBuilder>()
      {
        //{"connected",
        //  new ConnectedDetectedInboundCommandBuilder()},
        //{"3",
        //  new AckDetectedInboundCommandBuilder()},
        //{"eventChanged",
        //  new EventChangedDetectedInboundCommandBuilder()},     
        //{"eventWithMarketsChanged’",
        //  new EventWithMarketChangedDetectedInboundCommandBuilder()},
        //{"eventStarted",
        //  new EventStartedDetectedInboundCommandBuilder()},
        //{"eventEnded",
        //  new EventEndedDetectedInboundCommandBuilder()},
        //{"marketChanged",
        //  new MarketChangedDetectedInboundCommandBuilder()},
      };
    }

    public static WsInboundCommandBuilderRepository GetCommandBuilderRepository { get; } = new WsInboundCommandBuilderRepository();

    public IWsInboundCommandBuilder this
      [string index]
    {
      get
      {
        try
        {
          return _cmdBuilders[index];
        }
        catch (KeyNotFoundException)
        {
          throw new WsCommandNotFoundException();
        }
      }
    }
  }
}