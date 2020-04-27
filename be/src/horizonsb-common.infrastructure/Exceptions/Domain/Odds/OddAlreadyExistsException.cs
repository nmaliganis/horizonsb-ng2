﻿using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Odds
{
    public class OddAlreadyExistsException : Exception
    {
        public string Name { get; }
        public string BrokenRules { get; }

        public OddAlreadyExistsException(string name, string brokenRules)
        {
            Name = name;
            BrokenRules = brokenRules;
        }

        public override string Message => $" Odd with Name:{Name} already Exists!\n Additional info:{BrokenRules}";
    }
}
