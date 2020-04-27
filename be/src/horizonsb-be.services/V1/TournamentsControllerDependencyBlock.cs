using horizonsb.be.contracts.Tournaments;
using horizonsb.be.contracts.V1;

namespace horizonsb.be.services.V1
{
    public class TournamentsControllerDependencyBlock : ITournamentsControllerDependencyBlock
    {
        public TournamentsControllerDependencyBlock(ICreateTournamentProcessor createTournamentProcessor,
                                                        IInquiryTournamentProcessor inquiryTournamentProcessor,
                                                        IUpdateTournamentProcessor updateTournamentProcessor,
                                                        IInquiryAllTournamentsProcessor allTournamentProcessor,
                                                        IDeleteTournamentProcessor deleteTournamentProcessor)

        {
            CreateTournamentProcessor = createTournamentProcessor;
            InquiryTournamentProcessor = inquiryTournamentProcessor;
            UpdateTournamentProcessor = updateTournamentProcessor;
            InquiryAllTournamentsProcessor = allTournamentProcessor;
            DeleteTournamentProcessor = deleteTournamentProcessor;
        }

        public ICreateTournamentProcessor CreateTournamentProcessor { get; private set; }
        public IInquiryTournamentProcessor InquiryTournamentProcessor { get; private set; }
        public IUpdateTournamentProcessor UpdateTournamentProcessor { get; private set; }
        public IInquiryAllTournamentsProcessor InquiryAllTournamentsProcessor { get; private set; }
        public IDeleteTournamentProcessor DeleteTournamentProcessor { get; private set; }
    }
}