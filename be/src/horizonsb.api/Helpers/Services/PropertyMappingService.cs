using System;
using System.Collections.Generic;
using horizonsb.be.model.Events;
using horizonsb.be.model.Events.Markets;
using horizonsb.be.model.Events.Markets.Odds;
using horizonsb.be.model.Sports;
using horizonsb.be.model.Tournaments;
using horizonsb.common.infrastructure.PropertyMappings;
using horizonsb.commons.vm.Dtos.Events;
using horizonsb.commons.vm.Dtos.Markets;
using horizonsb.commons.vm.Dtos.Odds;
using horizonsb.commons.vm.Dtos.Sports;
using horizonsb.commons.vm.Dtos.Tournaments;

namespace horizonsb.api.Helpers.Services
{
  public class PropertyMappingService : BasePropertyMapping
  {
    private readonly Dictionary<string, PropertyMappingValue> _sportPropertyMapping =
      new Dictionary<string, PropertyMappingValue>(StringComparer.OrdinalIgnoreCase)
      {
        { "id", new PropertyMappingValue(new List<string>() { "id" } ) },
        { "name", new PropertyMappingValue(new List<string>() { "name"}) },
        { "priority", new PropertyMappingValue(new List<string>() { "priority"}) },
        { "sportid", new PropertyMappingValue(new List<string>() { "sportid"}) },
      };

    private readonly Dictionary<string, PropertyMappingValue> _tournamentPropertyMapping =
      new Dictionary<string, PropertyMappingValue>(StringComparer.OrdinalIgnoreCase)
      {
        { "id", new PropertyMappingValue(new List<string>() { "id" } ) },
        { "name", new PropertyMappingValue(new List<string>() { "name"}) },
        { "priority", new PropertyMappingValue(new List<string>() { "priority"}) },
        { "tournamentid", new PropertyMappingValue(new List<string>() { "tournamentid"}) },
      };

    private readonly Dictionary<string, PropertyMappingValue> _eventPropertyMapping =
      new Dictionary<string, PropertyMappingValue>(StringComparer.OrdinalIgnoreCase)
      {
        { "id", new PropertyMappingValue(new List<string>() { "id" } ) },
        { "name", new PropertyMappingValue(new List<string>() { "name"}) },
        { "priority", new PropertyMappingValue(new List<string>() { "priority"}) },
        { "upcomingLive", new PropertyMappingValue(new List<string>() { "upcomingLive"}) },
        { "livepriority", new PropertyMappingValue(new List<string>() { "livepriority"}) },
        { "eventid", new PropertyMappingValue(new List<string>() { "eventid"}) },
        { "dateevent", new PropertyMappingValue(new List<string>() { "dateevent"}) },
      };

    private readonly Dictionary<string, PropertyMappingValue> _marketPropertyMapping =
      new Dictionary<string, PropertyMappingValue>(StringComparer.OrdinalIgnoreCase)
      {
        { "id", new PropertyMappingValue(new List<string>() { "id" } ) },
        { "name", new PropertyMappingValue(new List<string>() { "name"}) },
      };

    private readonly Dictionary<string, PropertyMappingValue> _oddPropertyMapping =
      new Dictionary<string, PropertyMappingValue>(StringComparer.OrdinalIgnoreCase)
      {
        { "id", new PropertyMappingValue(new List<string>() { "id" } ) },
        { "name", new PropertyMappingValue(new List<string>() { "name"}) },
      };

    private static readonly IList<IPropertyMapping> PropertyMappings = new List<IPropertyMapping>();

    public PropertyMappingService() : base(PropertyMappings)
    {
      PropertyMappings.Add(new PropertyMapping<SportUiModel, Sport>(_sportPropertyMapping));
      PropertyMappings.Add(new PropertyMapping<TournamentUiModel, Tournament>(_tournamentPropertyMapping));
      PropertyMappings.Add(new PropertyMapping<EventUiModel, Match>(_eventPropertyMapping));
      PropertyMappings.Add(new PropertyMapping<MarketUiModel, Market>(_marketPropertyMapping));
      PropertyMappings.Add(new PropertyMapping<OddUiModel, Odd>(_oddPropertyMapping));
    }
  }
}
