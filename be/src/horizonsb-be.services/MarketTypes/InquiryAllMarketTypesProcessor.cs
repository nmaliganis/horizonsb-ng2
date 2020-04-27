using System.Collections.Generic;
using System.Threading.Tasks;
using horizonsb.be.contracts.MarketTypes;
using horizonsb.be.model.MarketTypes;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.PropertyMappings;
using horizonsb.common.infrastructure.TypeMappings;

namespace horizonsb.be.services.MarketTypes
{
  public class InquiryAllMarketTypesProcessor : IInquiryAllMarketTypesProcessor
  {
    private readonly IAutoMapper _autoMapper;
    private readonly IMarketTypeRepository _marketTypeRepository;
    private readonly IPropertyMappingService _propertyMappingService;

    public InquiryAllMarketTypesProcessor(IAutoMapper autoMapper,
      IMarketTypeRepository marketTypeRepository, IPropertyMappingService propertyMappingService)
    {
      _autoMapper = autoMapper;
      _marketTypeRepository = marketTypeRepository;
      _propertyMappingService = propertyMappingService;
    }



    public Task<IList<MarketType>> GetAllMarketTypesAsync()
    {
      return Task.Run(() => _marketTypeRepository.FindAll());
    }
  }
}