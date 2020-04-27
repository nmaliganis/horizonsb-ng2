using System.Linq;
using AutoMapper;
using horizonsb.be.model.Events;
using horizonsb.commons.vm.Dtos.Events;

namespace horizonsb.api.Configurations.AutoMappingProfiles
{
    public class EventEntityToEventUiAutoMapperProfile : Profile
    {
        public EventEntityToEventUiAutoMapperProfile()
        {
            ConfigureMapping();
        }

        public void ConfigureMapping()
        {
            CreateMap<Match, EventUiModel>()
                .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
                .ForMember(dest => dest.Name, opt => opt.MapFrom(src => src.Name))
                .ForMember(dest => dest.EventId, opt => opt.MapFrom(src => src.MatchId))
                .ForMember(dest => dest.Event_Id, opt => opt.MapFrom(src => src.EventId))
                .ForMember(dest => dest.Code, opt => opt.MapFrom(src => src.Code))
                .ForMember(dest => dest.UpcomingLive, opt => opt.MapFrom(src => src.UpcomingLive))
                .ForMember(dest => dest.Favorite, opt => opt.MapFrom(src => src.IsFavorite))
                .ForMember(dest => dest.Priority, opt => opt.MapFrom(src => src.Priority))
                .ForMember(dest => dest.StatusValue, opt => opt.MapFrom(src => src.Status))
                .ForMember(dest => dest.LivePriority, opt => opt.MapFrom(src => src.LivePriority))
                .ForMember(dest => dest.NumberOfMarkets, opt => opt.MapFrom(src => src.Markets.Count))
                .ForMember(dest => dest.Description, opt => opt.MapFrom(src => src.Status))
                .ForMember(dest => dest.AmericanGround, opt => opt.MapFrom(src => src.AmericanGround))
                .ForMember(dest => dest.DateEvent, opt => opt.MapFrom(src => src.DateEvent.ToString("yyyy-MM-ddTHH:mm:ss")))
                .ForMember(dest => dest.KickoffDate, opt => opt.MapFrom(src => src.DateEvent.ToString("yyyy-MM-ddTHH:mm:ss")))
                .ForMember(dest => dest.Timestamp, opt => opt.MapFrom(src => src.Timestamp))
                .ForMember(dest => dest.EventTeamHome, opt => opt.MapFrom(src => src.Teams.FirstOrDefault(t => t.IsHome == true).Name))
                .ForMember(dest => dest.EventTeamAway, opt => opt.MapFrom(src => src.Teams.FirstOrDefault(t => t.IsHome == false).Name))
                .ForMember(dest => dest.EventTournamentName, opt => opt.MapFrom(src => src.Tournament.Name))
                .ForMember(dest => dest.EventTournamentShortName, opt => opt.MapFrom(src => src.Tournament.ShortName))
                .ForMember(dest => dest.EventSportName, opt => opt.MapFrom(src => src.Tournament.Category.Sport.Name))
                .ForMember(dest => dest.EventSportConfiguration, opt => opt.MapFrom(src => src.Tournament.Category.Sport.Configuration))
                .ForMember(dest => dest.Markets, opt => opt.MapFrom(src => src.Markets))
                .ForMember(dest => dest.Message, opt => opt.Ignore())
                .ForMember(dest => dest.Status, opt => opt.Ignore())
                .MaxDepth(1)
                ;
        }
    }
}