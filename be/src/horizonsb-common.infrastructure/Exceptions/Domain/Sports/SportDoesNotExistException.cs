using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Sports
{
    public class SportDoesNotExistException : Exception
    {
        public Guid SportId { get; }
        public string SportSportId { get; }

        public SportDoesNotExistException(Guid sportId)
        {
            SportId = sportId;
        }
        public SportDoesNotExistException(string sportId)
        {
          SportSportId = sportId;
        }

        public override string Message => $"Sport with Id: {SportId} and Or sportid:{SportSportId}  doesn't exists!";
    }
}
