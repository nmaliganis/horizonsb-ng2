using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Tournaments
{
    public class TournamentDoesNotExistAfterMadePersistentException : Exception
    {
        public string Name { get; private set; }

        public TournamentDoesNotExistAfterMadePersistentException(string name)
        {
            Name = name;
        }

        public override string Message => $" Tournament with Name: {Name} was not made Persistent!";
    }
}