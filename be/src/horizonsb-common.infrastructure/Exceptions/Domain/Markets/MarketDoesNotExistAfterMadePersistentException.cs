using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Markets
{
    public class MarketDoesNotExistAfterMadePersistentException : Exception
    {
        public string Name { get; private set; }

        public MarketDoesNotExistAfterMadePersistentException(string name)
        {
            Name = name;
        }

        public override string Message => $" Market with Name: {Name} was not made Persistent!";
    }
}