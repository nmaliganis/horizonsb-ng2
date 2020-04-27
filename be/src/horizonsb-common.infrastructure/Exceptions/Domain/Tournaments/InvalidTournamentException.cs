using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Tournaments
{
    public class InvalidTournamentException : Exception
    {
        public string BrokenRules { get; private set; }

        public InvalidTournamentException(string brokenRules)
        {
            BrokenRules = brokenRules;
        }
    }
}
