using System;
using horizonsb.api.Commanding.Betting.Events.Args;
using horizonsb.api.Commanding.Betting.Listeners;
using horizonsb.api.Configurations.Commanding.Betting.Events.Args;
using horizonsb.api.Models.Live.EventChanged;
using horizonsb.api.Models.Live.MarketChanged;

namespace horizonsb.api.Commanding.Betting.Servers.Base
{
  public abstract class WsInboundBaseServer
  {
    public event EventHandler<ConnectedDetectionEventArgs> ConnectedDetector;
    public event EventHandler<AckDetectionEventArgs> AckDetector;
    public event EventHandler<EventChangedDetectionEventArgs> EventChangedDetector;
    public event EventHandler<EventWithMarketChangedDetectionEventArgs> EventWithMarketChangedDetector;
    public event EventHandler<MarketChangedDetectionEventArgs> MarketChangedDetector;
    public event EventHandler<EventStartedDetectionEventArgs> EventStartedDetector;
    public event EventHandler<EventEndedDetectionEventArgs> EventEndedDetector;

    #region Connected detection Event Manipulation

    private void OnConnectedDetection(ConnectedDetectionEventArgs e)
    {
      ConnectedDetector?.Invoke(this, e);
    }

    public void RaiseConnectedDetection(string payload)
    {
      OnConnectedDetection(new ConnectedDetectionEventArgs(payload));
    }

    public void Attach(IConnectedDetectionActionListener listener)
    {
      ConnectedDetector += listener.Update;
    }

    public void Detach(IConnectedDetectionActionListener listener)
    {
      ConnectedDetector -= listener.Update;
    }

    #endregion

    #region Ack detection Event Manipulation

    private void OnAckDetection(AckDetectionEventArgs e)
    {
      AckDetector?.Invoke(this, e);
    }

    public void RaiseAckDetection(string payload)
    {
      OnAckDetection(new AckDetectionEventArgs(payload));
    }

    public void Attach(IAckDetectionActionListener listener)
    {
      AckDetector += listener.Update;
    }

    public void Detach(IAckDetectionActionListener listener)
    {
      AckDetector -= listener.Update;
    }

    #endregion

    #region Event Changed detection Event Manipulation

    private void OnEventChangedDetection(EventChangedDetectionEventArgs e)
    {
      EventChangedDetector?.Invoke(this, e);
    }

    public void RaiseEventChangedDetection(EventChanged eventChanged, string payload)
    {
      OnEventChangedDetection(new EventChangedDetectionEventArgs(eventChanged, payload));
    }

    public void Attach(IEventChangedDetectionActionListener listener)
    {
      EventChangedDetector += listener.Update;
    }

    public void Detach(IEventChangedDetectionActionListener listener)
    {
      EventChangedDetector -= listener.Update;
    }

    #endregion

    #region Event Started detection Event Manipulation

    private void OnEventStartedDetection(EventStartedDetectionEventArgs e)
    {
      EventStartedDetector?.Invoke(this, e);
    }

    public void RaiseEventStartedDetection(string payload)
    {
      OnEventStartedDetection(new EventStartedDetectionEventArgs(payload));
    }

    public void Attach(IEventStartedDetectionActionListener listener)
    {
      EventStartedDetector += listener.Update;
    }

    public void Detach(IEventStartedDetectionActionListener listener)
    {
      EventStartedDetector -= listener.Update;
    }

    #endregion

    #region Event Ended detection Event Manipulation

    private void OnEventEndedDetection(EventEndedDetectionEventArgs e)
    {
      EventEndedDetector?.Invoke(this, e);
    }

    public void RaiseEventEndedDetection(string payload)
    {
      OnEventEndedDetection(new EventEndedDetectionEventArgs(payload));
    }

    public void Attach(IEventEndedDetectionActionListener listener)
    {
      EventEndedDetector += listener.Update;
    }

    public void Detach(IEventEndedDetectionActionListener listener)
    {
      EventEndedDetector -= listener.Update;
    }

    #endregion

    #region Market Changed detection Market Manipulation

    private void OnMarketChangedDetection(MarketChangedDetectionEventArgs e)
    {
      MarketChangedDetector?.Invoke(this, e);
    }

    public void RaiseMarketChangedDetection(MarketChanged marketChanged, string payload)
    {
      OnMarketChangedDetection(new MarketChangedDetectionEventArgs(marketChanged, payload));
    }

    public void Attach(IMarketChangedDetectionActionListener listener)
    {
      MarketChangedDetector += listener.Update;
    }

    public void Detach(IMarketChangedDetectionActionListener listener)
    {
      MarketChangedDetector -= listener.Update;
    }

    #endregion

    #region Event With Market Changed detection Market Manipulation

    private void OnEventWithMarketChangedDetection(EventWithMarketChangedDetectionEventArgs e)
    {
      EventWithMarketChangedDetector?.Invoke(this, e);
    }

    public void RaiseEventWithMarketChangedDetection(string command, string payload)
    {
      OnEventWithMarketChangedDetection(new EventWithMarketChangedDetectionEventArgs(command, payload));
    }

    public void Attach(IEventWithMarketChangedDetectionActionListener listener)
    {
      EventWithMarketChangedDetector += listener.Update;
    }

    public void Detach(IEventWithMarketChangedDetectionActionListener listener)
    {
      EventWithMarketChangedDetector -= listener.Update;
    }

    #endregion

  }
}