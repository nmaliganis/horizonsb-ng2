using System;
using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Sports;

namespace horizonsb.be.contracts.Sports
{
    public interface IUpdateSportProcessor
    {
        Task<SportUiModel> UpdateSportAsync(Guid sportIdToBeUpdated, SportForModificationUiModel updatedSport);
        Task<SportUiModel> UpdateConfigurationSportAsync(string sportIdToBeUpdated, SportForModificationConfigurationUiModel updatedSport);
    }
}
