using AutoMapper;
using horizonsb.be.model.Tournaments;
using horizonsb.commons.vm.Dtos.Tournaments;

namespace horizonsb.api.Configurations.AutoMappingProfiles
{
    public class TournamentEntityToTournamentUiAutoMapperProfile : Profile
    {
        public TournamentEntityToTournamentUiAutoMapperProfile()
        {
            ConfigureMapping();
        }

        public void ConfigureMapping()
        {
            CreateMap<Tournament, TournamentUiModel>()
                .ForMember(dest => dest.id, opt => opt.MapFrom(src => src.Id))
                .ForMember(dest => dest.name, opt => opt.MapFrom(src => src.Name))
                .ForMember(dest => dest.shortName, opt => opt.MapFrom(src => src.ShortName))
                .ForMember(dest => dest.priority, opt => opt.MapFrom(src => src.Priority))
                .ForMember(dest => dest.tournamentId, opt => opt.MapFrom(src => src.TournamentId))
                .ForMember(dest => dest.highlight, opt => opt.MapFrom(src => src.Highlight))
                .ForMember(dest => dest.numEvents, opt => opt.MapFrom(src => src.NumEvents))
                .ForMember(dest => dest.numOutrightEvents, opt => opt.MapFrom(src => src.NumOutrightEvents))
                .ForMember(dest => dest.order, opt => opt.MapFrom(src => src.Order))
                .MaxDepth(1)
                ;
        }
    }
}