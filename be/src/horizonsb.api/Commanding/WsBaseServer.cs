using System;
using System.Collections.Generic;
using horizonsb.api.Commanding.Events.Args;
using horizonsb.api.Commanding.Inbound;
using horizonsb.api.Commanding.OutBound;
using horizonsb.api.Configurations.Commanding.Events.Args;

namespace horizonsb.api.Commanding
{
  public abstract class WsBaseServer
  {
    public event EventHandler<KeepAliveDetectionEventArgs> KeepAliveRequestDetector;
    public event EventHandler<RegisterEventStartedDetectionEventArgs> RegisterEventStartedRequestDetector;
    public event EventHandler<RegisterEventEndedDetectionEventArgs> RegisterEventEndedRequestDetector;
    public event EventHandler<RegisterEventDetectionEventArgs> RegisterEventRequestDetector;
    public event EventHandler<RegisterMarketsForEventsDetectionEventArgs> RegisterMarketRequestDetector;
    public event EventHandler<RegisterEventWithAllMarketsForEventsDetectionEventArgs> RegisterEventWithAllMarketsRequestDetector;
    public event EventHandler<KeepAliveDetectionEventArgs> KeepAliveResponseDetector;

    #region Keep Alive Request detection Event Manipulation

    private void OnKeepAliveDetection(KeepAliveDetectionEventArgs e)
    {
      KeepAliveRequestDetector?.Invoke(this, e);
    }

    public void RaiseKeepAliveRequestDetection()
    {
      OnKeepAliveDetection(new KeepAliveDetectionEventArgs());
    }

    public void Attach(IKeepAliveRequestDetectionActionListener listener)
    {
      KeepAliveRequestDetector += listener.Update;
    }

    public void Detach(IKeepAliveRequestDetectionActionListener listener)
    {
      KeepAliveRequestDetector -= listener.Update;
    }

    #endregion

    #region Register Event Started Request detection Event Manipulation

    private void OnRegisterEventStartedDetection(RegisterEventStartedDetectionEventArgs e)
    {
      RegisterEventStartedRequestDetector?.Invoke(this, e);
    }

    public void RaiseRegisterEventStartedRequestDetection(string eventId)
    {
      OnRegisterEventStartedDetection(new RegisterEventStartedDetectionEventArgs(eventId));
    }

    public void Attach(IRegisterEventStartedRequestDetectionActionListener listener)
    {
      RegisterEventStartedRequestDetector += listener.Update;
    }

    public void Detach(IRegisterEventStartedRequestDetectionActionListener listener)
    {
      RegisterEventStartedRequestDetector -= listener.Update;
    }

    #endregion

    #region Register Event Ended Request detection Event Manipulation

    private void OnRegisterEventEndedDetection(RegisterEventEndedDetectionEventArgs e)
    {
      RegisterEventEndedRequestDetector?.Invoke(this, e);
    }

    public void RaiseRegisterEventEndedRequestDetection(string eventId)
    {
      OnRegisterEventEndedDetection(new RegisterEventEndedDetectionEventArgs(eventId));
    }

    public void Attach(IRegisterEventEndedRequestDetectionActionListener listener)
    {
      RegisterEventEndedRequestDetector += listener.Update;
    }

    public void Detach(IRegisterEventEndedRequestDetectionActionListener listener)
    {
      RegisterEventEndedRequestDetector -= listener.Update;
    }

    #endregion

    #region Register Event Request detection Event Manipulation

    private void OnRegisterEventDetection(RegisterEventDetectionEventArgs e)
    {
      RegisterEventRequestDetector?.Invoke(this, e);
    }

    public void RaiseRegisterEventRequestDetection(string eventId)
    {
      OnRegisterEventDetection(new RegisterEventDetectionEventArgs(eventId));
    }

    public void Attach(IRegisterEventRequestDetectionActionListener listener)
    {
      RegisterEventRequestDetector += listener.Update;
    }

    public void Detach(IRegisterEventRequestDetectionActionListener listener)
    {
      RegisterEventRequestDetector -= listener.Update;
    }

    #endregion

    #region Register Market Request detection Market Manipulation

    private void OnRegisterMarketDetection(RegisterMarketsForEventsDetectionEventArgs e)
    {
      RegisterMarketRequestDetector?.Invoke(this, e);
    }

    public void RaiseRegisterMarketRequestDetection(string eventId, string market)
    {
      OnRegisterMarketDetection(new RegisterMarketsForEventsDetectionEventArgs(eventId, market));
    }

    public void Attach(IRegisterMarketRequestDetectionActionListener listener)
    {
      RegisterMarketRequestDetector += listener.Update;
    }

    public void Detach(IRegisterMarketRequestDetectionActionListener listener)
    {
      RegisterMarketRequestDetector -= listener.Update;
    }

    #endregion

    #region Register Event With All Markets Request detection Market Manipulation

    private void OnRegisterEventWithAllMarketDetection(RegisterEventWithAllMarketsForEventsDetectionEventArgs e)
    {
      RegisterEventWithAllMarketsRequestDetector?.Invoke(this, e);
    }

    public void RaiseRegisterEventWithAllMarketsRequestDetection(string eventId)
    {
      OnRegisterEventWithAllMarketDetection(new RegisterEventWithAllMarketsForEventsDetectionEventArgs(eventId));
    }

    public void Attach(IRegisterEventWithAllMarketRequestDetectionActionListener listener)
    {
      RegisterEventWithAllMarketsRequestDetector += listener.Update;
    }

    public void Detach(IRegisterEventWithAllMarketRequestDetectionActionListener listener)
    {
      RegisterEventWithAllMarketsRequestDetector -= listener.Update;
    }

    #endregion

    #region Keep Alive Response detection Event Manipulation

    private void OnAttributeDetection(KeepAliveDetectionEventArgs e)
    {
      KeepAliveResponseDetector?.Invoke(this, e);
    }

    public void RaiseKeepAliveResponseDetection()
    {
      OnAttributeDetection(new KeepAliveDetectionEventArgs());
    }

    public void Attach(IKeepAliveResponseDetectionActionListener listener)
    {
      KeepAliveResponseDetector += listener.Update;
    }

    public void Detach(IKeepAliveResponseDetectionActionListener listener)
    {
      KeepAliveResponseDetector -= listener.Update;
    }

    #endregion
  }
}