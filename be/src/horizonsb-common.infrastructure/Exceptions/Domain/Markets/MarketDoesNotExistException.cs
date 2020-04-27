using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Markets
{
    public class MarketDoesNotExistException : Exception
    {
        public Guid MarketId { get; }
        public string MarketMarketId { get; }

        public MarketDoesNotExistException(Guid sportId)
        {
            MarketId = sportId;
        }
        public MarketDoesNotExistException(string sportId)
        {
          MarketMarketId = sportId;
        }

        public override string Message => $"Market with Id: {MarketId} and Or marketid:{MarketMarketId}  doesn't exists!";
    }
}
