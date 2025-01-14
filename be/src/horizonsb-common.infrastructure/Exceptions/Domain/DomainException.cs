﻿using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain
{
    public class DomainException : Exception
    {
        private string _notApplicableMsg;

        public DomainException(string notApplicableMsg)
        {
            this._notApplicableMsg = notApplicableMsg;
        }
    }
}