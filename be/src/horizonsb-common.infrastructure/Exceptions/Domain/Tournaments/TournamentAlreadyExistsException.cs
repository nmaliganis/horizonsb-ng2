using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Tournaments
{
    public class TournamentAlreadyExistsException : Exception
    {
        public string Name { get; }
        public string BrokenRules { get; }

        public TournamentAlreadyExistsException(string name, string brokenRules)
        {
            Name = name;
            BrokenRules = brokenRules;
        }

        public override string Message => $" Tournament with Name:{Name} already Exists!\n Additional info:{BrokenRules}";
    }
}
