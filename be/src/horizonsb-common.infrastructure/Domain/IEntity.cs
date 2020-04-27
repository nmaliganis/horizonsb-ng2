
namespace horizonsb.common.infrastructure.Domain
{
    public interface IEntity<TId>
    {
        TId Id { get; set; }
    }
}
