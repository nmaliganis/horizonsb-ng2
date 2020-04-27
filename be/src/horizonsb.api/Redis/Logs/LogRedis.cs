namespace horizonsb.api.Redis.Logs
{
    public class LogRedis
    {
        public string Id { get; set; }
        public string Created { get; set; }
        public string LastModified { get; set; }
        public string LastModifiedUpcomingLive { get; set; }
        public string LastModifiedPostgres { get; set; }
        public string LastModifiedClearCache{ get; set; }
        public string LastModifiedWs { get; set; }
        public string LastModifiedEventChanged { get; set; }
        public string LastModifiedChangedEventId { get; set; }
        public string LastModifiedMarketChanged { get; set; }
        public string LastModifiedChangedMarketId { get; set; }
    }
}
