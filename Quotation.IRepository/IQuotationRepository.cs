using System;
using System.Collections.Generic;

namespace Quotation.IRepository
{
    public interface IQuotationRepository
    {
        Quotation.Model.Model.Quotation SubmitQuotation(Quotation.Model.Model.Quotation quotation);
        List<Quotation.Model.Model.Quotation> GetQuotation(long quotationId, long userId);
        bool DeleteQuotation(string quotationNumber, long userId);

        void UpdateQoutationStatus(string quotationNumber, long userId, long status);
    }
}
