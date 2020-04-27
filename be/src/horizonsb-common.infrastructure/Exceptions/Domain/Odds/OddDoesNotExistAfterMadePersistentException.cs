using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Odds
{
    public class OddDoesNotExistAfterMadePersistentException : Exception
    {
        public string Name { get; private set; }

        public OddDoesNotExistAfterMadePersistentException(string name)
        {
            Name = name;
        }

        public override string Message => $" Odd with Name: {Name} was not made Persistent!";
    }
}