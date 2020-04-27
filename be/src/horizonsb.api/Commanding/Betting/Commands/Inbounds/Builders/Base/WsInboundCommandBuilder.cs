using System.Linq;
using System.Text.RegularExpressions;

namespace horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Builders.Base
{
  public abstract class WsInboundCommandBuilder
  {
    public string Message { get; set; }
    public string[] Messages { get; set; }
    public abstract void BuildPayload();
    public abstract bool IsBuildHeader();

    public virtual string BuildHeader(string payload)
    {
      int startIndex = payload.IndexOf('{');
      int endIndex = payload.Length - payload.IndexOf('{');
      string changedJson = payload.Substring(startIndex, endIndex);
      changedJson = changedJson.Remove(changedJson.Length - 1);
      return changedJson;
    }   
    
    public virtual string[] BuildMessages(string payload)
    {
      return new Regex("(?<=\")[^\"]*(?=\")|[^\" ]+")
        .Matches(payload).Cast<Match>().Select(m => m.Value).ToArray();
    }

    protected virtual void BuildMessage(string payload)
    {
      if(IsBuildHeader())
        Message = BuildHeader(payload);

      Messages = BuildMessages(payload);
      BuildPayload();
    }
  }
}
