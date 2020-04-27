using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Sports;

namespace horizonsb.be.contracts.Sports
{
    public interface ICreateSportProcessor
    {
        Task<SportUiModel> CreateSportAsync(SportForCreationUiModel newSportUiModel);
    }
}