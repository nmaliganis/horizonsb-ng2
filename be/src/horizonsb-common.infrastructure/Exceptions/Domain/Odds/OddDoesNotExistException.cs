using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Odds
{
    public class OddDoesNotExistException : Exception
    {
        public Guid OddId { get; }
        public string OddOddId { get; }

        public OddDoesNotExistException(Guid sportId)
        {
            OddId = sportId;
        }
        public OddDoesNotExistException(string sportId)
        {
          OddOddId = sportId;
        }

        public override string Message => $"Odd with Id: {OddId} and Or marketid:{OddOddId}  doesn't exists!";
    }
}
