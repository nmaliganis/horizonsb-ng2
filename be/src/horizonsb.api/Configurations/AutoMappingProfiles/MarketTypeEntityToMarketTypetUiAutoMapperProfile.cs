using AutoMapper;
using horizonsb.be.model.MarketTypes;
using horizonsb.be.model.Sports;
using horizonsb.commons.vm.Dtos.MarketTypes;
using horizonsb.commons.vm.Dtos.Sports;

namespace horizonsb.api.Configurations.AutoMappingProfiles
{
    public class MarketTypeEntityToMarketTypetUiAutoMapperProfile : Profile
    {
        public MarketTypeEntityToMarketTypetUiAutoMapperProfile()
        {
            ConfigureMapping();
        }

        public void ConfigureMapping()
        {
            CreateMap<MarketType, MarketTypeUiModel>()
                .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
                .ForMember(dest => dest.MarketTypes, opt => opt.MapFrom(src => src.Type.Jsonb))
                .ForMember(dest => dest.Message, opt => opt.Ignore())
                .MaxDepth(1)
                ;
        }
    }
}