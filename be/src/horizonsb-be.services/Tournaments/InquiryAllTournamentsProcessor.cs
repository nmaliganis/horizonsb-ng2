using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using horizonsb.be.contracts.Tournaments;
using horizonsb.be.model.Tournaments;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.Extensions;
using horizonsb.common.infrastructure.Helpers.ResourceParameters;
using horizonsb.common.infrastructure.Paging;
using horizonsb.common.infrastructure.PropertyMappings;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.commons.vm.Dtos.Tournaments;

namespace horizonsb.be.services.Tournaments
{
    public class InquiryAllTournamentsProcessor : IInquiryAllTournamentsProcessor
    {
        private readonly IAutoMapper _autoMapper;
        private readonly ITournamentRepository _tournamentRepository;
        private readonly IPropertyMappingService _propertyMappingService;

        public InquiryAllTournamentsProcessor(IAutoMapper autoMapper,
                            ITournamentRepository tournamentRepository, IPropertyMappingService propertyMappingService)
        {
            _autoMapper = autoMapper;
            _tournamentRepository = tournamentRepository;
            _propertyMappingService = propertyMappingService;
        }

        public Task<PagedList<Tournament>> GetTournamentsAsync(TournamentsResourceParameters tournamentsResourceParameters)
        {
            var collectionBeforePaging =
                QueryableExtensions.ApplySort(_tournamentRepository
                        .FindAllTournamentsPagedOf(tournamentsResourceParameters.Offset,
                            tournamentsResourceParameters.Limit), 
                    tournamentsResourceParameters.OrderColumn + " " + tournamentsResourceParameters.OrderDirection, 
                    _propertyMappingService.GetPropertyMapping<TournamentUiModel, Tournament>());

            return Task.Run(() => PagedList<Tournament>.Create(collectionBeforePaging,
                tournamentsResourceParameters.Offset,
                tournamentsResourceParameters.Limit));
        }

        public Task<PagedList<Tournament>> GetTournamentsAsync(Guid sportId, TournamentsResourceParameters tournamentsResourceParameters)
        {
          var collectionBeforePaging =
            QueryableExtensions.ApplySort(_tournamentRepository
                .FindAllTournamentsWithSportIdPagedOf(sportId, tournamentsResourceParameters.Offset,
                  tournamentsResourceParameters.Limit),
              tournamentsResourceParameters.OrderColumn + " " + tournamentsResourceParameters.OrderDirection,
              _propertyMappingService.GetPropertyMapping<TournamentUiModel, Tournament>());

          return Task.Run(() => PagedList<Tournament>.Create(collectionBeforePaging,
            tournamentsResourceParameters.Offset,
            tournamentsResourceParameters.Limit));
        }

        public Task<int> GetTotalCountTournamentsAsync()
        {
          return Task.Run(() => _tournamentRepository.FindAllTournamentsPagedOf(-1, -1).QueriedItems.Count());
        }
    }
}