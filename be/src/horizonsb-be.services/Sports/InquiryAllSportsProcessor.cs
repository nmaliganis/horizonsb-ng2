using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using horizonsb.be.contracts.Sports;
using horizonsb.be.model.Sports;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.Extensions;
using horizonsb.common.infrastructure.Helpers.ResourceParameters;
using horizonsb.common.infrastructure.Paging;
using horizonsb.common.infrastructure.PropertyMappings;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.commons.vm.Dtos.Sports;

namespace horizonsb.be.services.Sports
{
  public class InquiryAllSportsProcessor : IInquiryAllSportsProcessor
  {
    private readonly ISportRepository _sportRepository;
    private readonly IPropertyMappingService _propertyMappingService;

    public InquiryAllSportsProcessor(IAutoMapper autoMapper,
      ISportRepository sportRepository, IPropertyMappingService propertyMappingService)
    {
      _sportRepository = sportRepository;
      _propertyMappingService = propertyMappingService;
    }

    public Task<IList<Sport>> GetSportsAllAsync()
    {
      return Task.Run(() => _sportRepository.FindAll());
    }

    public Task<PagedList<Sport>> GetSportsAsync(SportsResourceParameters sportsResourceParameters)
    {
      sportsResourceParameters.Offset = (sportsResourceParameters.Offset/10) + 1;

      var collectionBeforePaging =
        QueryableExtensions.ApplySort(_sportRepository
            .FindAllSportsPagedOf(sportsResourceParameters.Offset,
              sportsResourceParameters.Limit),
            sportsResourceParameters.OrderColumn + " " + sportsResourceParameters.OrderDirection, 
          _propertyMappingService.GetPropertyMapping<SportUiModel, Sport>());

      return Task.Run(() => PagedList<Sport>.Create(collectionBeforePaging,
        sportsResourceParameters.Offset,
        sportsResourceParameters.Limit));
    }

    public Task<int> GetTotalCountSportsAsync()
    {
      return Task.Run(() => _sportRepository.FindAllSportsPagedOf(-1, -1).QueriedItems.Count());
    }
  }
}