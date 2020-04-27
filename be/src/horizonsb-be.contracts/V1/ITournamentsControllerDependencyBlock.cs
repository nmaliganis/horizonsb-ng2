using horizonsb.be.contracts.Tournaments;

namespace horizonsb.be.contracts.V1
{
    public interface ITournamentsControllerDependencyBlock
    {
        ICreateTournamentProcessor CreateTournamentProcessor { get; }
        IInquiryTournamentProcessor InquiryTournamentProcessor { get; }
        IUpdateTournamentProcessor UpdateTournamentProcessor { get; }
        IInquiryAllTournamentsProcessor InquiryAllTournamentsProcessor { get; }
        IDeleteTournamentProcessor DeleteTournamentProcessor { get; }
    }
}