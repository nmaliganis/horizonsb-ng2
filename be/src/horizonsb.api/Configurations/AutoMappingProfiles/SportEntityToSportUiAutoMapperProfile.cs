using AutoMapper;
using horizonsb.be.model.Sports;
using horizonsb.commons.vm.Dtos.Sports;

namespace horizonsb.api.Configurations.AutoMappingProfiles
{
    public class SportEntityToSportUiAutoMapperProfile : Profile
    {
        public SportEntityToSportUiAutoMapperProfile()
        {
            ConfigureMapping();
        }

        public void ConfigureMapping()
        {
            CreateMap<Sport, SportUiModel>()
                .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
                .ForMember(dest => dest.Name, opt => opt.MapFrom(src => src.Name))
                .ForMember(dest => dest.SportId, opt => opt.MapFrom(src => src.SportId))
                .ForMember(dest => dest.Highlight, opt => opt.MapFrom(src => src.Highlight))
                .ForMember(dest => dest.NumEvents, opt => opt.MapFrom(src => src.NumEvents))
                .ForMember(dest => dest.NumInPlayEvents, opt => opt.MapFrom(src => src.NumInPlayEvents))
                .ForMember(dest => dest.Configuration, opt => opt.MapFrom(src => src.Configuration))
                .ForMember(dest => dest.ConfigurationValue, opt => opt.MapFrom(src => src.Configuration.ToString()))
                .ForMember(dest => dest.Message, opt => opt.Ignore())
                .MaxDepth(1)
                ;
        }
    }
}