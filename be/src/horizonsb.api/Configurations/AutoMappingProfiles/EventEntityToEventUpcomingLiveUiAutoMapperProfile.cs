using AutoMapper;
using horizonsb.be.model.Events;
using horizonsb.commons.vm.Dtos.Events;

namespace horizonsb.api.Configurations.AutoMappingProfiles
{
    public class EventEntityToEventUpcomingLiveUiAutoMapperProfile : Profile
    {
        public EventEntityToEventUpcomingLiveUiAutoMapperProfile()
        {
            ConfigureMapping();
        }

        public void ConfigureMapping()
        {
            CreateMap<Match, EventUpcomingLiveUiModel>()
                .ForMember(dest => dest.EventId, opt => opt.MapFrom(src => src.EventId))
                .MaxDepth(1)
                ;
        }
    }
}