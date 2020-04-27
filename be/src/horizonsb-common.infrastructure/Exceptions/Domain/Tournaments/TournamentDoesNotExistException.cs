using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Tournaments
{
    public class TournamentDoesNotExistException : Exception
    {
        public Guid TournamentId { get; }
        public string TournamentTournamentId { get; }

        public TournamentDoesNotExistException(Guid tournamentId)
        {
            TournamentId = tournamentId;
        }
        public TournamentDoesNotExistException(string tournamentTournamentId)
        {
          TournamentTournamentId = tournamentTournamentId;
        }

        public override string Message => $"Tournament with Id: {TournamentId} and or {TournamentTournamentId}  doesn't exists!";
    }
}
