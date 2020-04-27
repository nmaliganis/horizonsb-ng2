namespace horizonsb.common.infrastructure.Helpers.ResourceParameters
{
    public abstract class BaseResourceParameters
    {
        /// <summary>
        /// <param name="OrderDirection">asc/desc, default:desc</param>
        /// </summary>
        public string OrderDirection { get; set; }

        private const int MaxPageSize = 10;
        /// <summary>
        /// <param name="Offset">Optional. Index of Page</param>
        /// </summary>

        public virtual int? Offset { get; set; } = 0;

        private int _limit = 10;
        /// <summary>
        /// <param name="PageSize">Optional. Size of Page</param>
        /// </summary>
        public virtual int Limit
        {
            get => _limit;
            set => _limit = ((value > MaxPageSize) ? MaxPageSize : value);
        }

        public abstract string OrderColumn { get; set; }
        public abstract string SearchQuery { get; set; }
        public abstract string SearchColumn { get; set; }
    }
}
