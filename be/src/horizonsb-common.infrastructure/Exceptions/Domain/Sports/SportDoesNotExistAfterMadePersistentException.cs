using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Sports
{
    public class SportDoesNotExistAfterMadePersistentException : Exception
    {
        public string Name { get; private set; }

        public SportDoesNotExistAfterMadePersistentException(string name)
        {
            Name = name;
        }

        public override string Message => $" Sport with Name: {Name} was not made Persistent!";
    }
}