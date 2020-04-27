using AutoMapper;
using horizonsb.be.model.Events.Markets;
using horizonsb.commons.vm.Dtos.Markets;


namespace horizonsb.api.Configurations.AutoMappingProfiles
{
    public class MarketEntityToMarketUiAutoMapperProfile : Profile
    {
        public MarketEntityToMarketUiAutoMapperProfile()
        {
            ConfigureMapping();
        }

        public void ConfigureMapping()
        {
            CreateMap<Market, MarketUiModel>()
                .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
                .ForMember(dest => dest.Name, opt => opt.MapFrom(src => src.Name))
                .ForMember(dest => dest.MarketId, opt => opt.MapFrom(src => src.MarketId))
                .ForMember(dest => dest.Status, opt => opt.Ignore())
                .ForMember(dest => dest.Message, opt => opt.Ignore())
                .MaxDepth(1)
                ;
        }
    }
}