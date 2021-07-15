using Dapper;
using Quotation.Common;
using Quotation.Data;
using Quotation.IRepository;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Quotation.Repository
{
    public class QuotationRepository : IQuotationRepository
    {
        private readonly IDapperConnection dapper;
        public QuotationRepository(IDapperConnection iDapper)
        {
            dapper = iDapper;
        }

        public List<Quotation.Model.Model.Quotation> SubmitQuotation(Quotation.Model.Model.Quotation quotation)
        {
            SqlParameters sqlParameters = new SqlParameters();
            sqlParameters.StoreProcedureName = "SubmitQuotation";

            var quotationList = new List<Quotation.Model.Model.Quotation>();
            quotationList.Add(quotation);

            DataTable dtQuotation = ListToDataTable.ToDataTable<Quotation.Model.Model.Quotation>(quotationList);
            dtQuotation.Columns.Remove("QuotationDetails");
            quotation.QuotationDetails.ToList().ForEach(x => x.UserId = quotation.UserId);

            DataTable dtQuotationDetails = ListToDataTable.ToDataTable<Quotation.Model.Model.QuotationDetails>(quotation.QuotationDetails.ToList());
            Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
            parameters.Add("@Quotation", dtQuotation.AsTableValuedParameter("dbo.UT_Quotation"));
            parameters.Add("@QuotationDetail", dtQuotationDetails.AsTableValuedParameter("dbo.UT_QuotationDetail"));
            sqlParameters.Parameters = parameters;

            var result = dapper.ExecuteQuery<dynamic>(sqlParameters).FirstOrDefault();

            var response = this.GetQuotation(result.Inserted, quotation.UserId);

            return response;
        }

        public List<Quotation.Model.Model.Quotation> GetQuotation(long quotationId, long userId)
        {
            SqlParameters sqlParameters = new SqlParameters();

            sqlParameters.StoreProcedureName = "GetQuotation";

            Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();

            parameters.Add("@QuotationById", quotationId);
            parameters.Add("@UserId", userId);

            sqlParameters.Parameters = parameters;

            var quotation = dapper.ExecuteQuery<Quotation.Model.Model.Quotation>(sqlParameters);

            // Quotation Details
            sqlParameters.StoreProcedureName = "GetQuotationDetails";

            sqlParameters.Parameters = parameters;
            var quotationDetails = dapper.ExecuteQuery<Quotation.Model.Model.QuotationDetails>(sqlParameters);

            return ConcatQuotation(quotation, quotationDetails);

        }

        public bool DeleteQuotation(string quotationNumber, long userId)
        {
            SqlParameters sqlParameters = new SqlParameters();
            sqlParameters.StoreProcedureName = "DeleteQuotation";
            Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
            parameters.Add("@QuotationNumber", quotationNumber);
            parameters.Add("@UserId", userId);
            sqlParameters.Parameters = parameters;
            var result = dapper.ExecuteQuery<dynamic>(sqlParameters).FirstOrDefault();
            return (bool)result.Result;
        }

        public void UpdateQoutationStatus(string quotationNumber, long userId, long status)
        {
            SqlParameters sqlParameters = new SqlParameters();
            sqlParameters.StoreProcedureName = "UpdateQuotationStatus";
            Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
            parameters.Add("@QuotationNumber", quotationNumber);
            parameters.Add("@UserId", userId);
            parameters.Add("@Status", status);
            sqlParameters.Parameters = parameters;
            dapper.ExecuteQuery<dynamic>(sqlParameters);
        }

        private List<Quotation.Model.Model.Quotation> ConcatQuotation(List<Quotation.Model.Model.Quotation> quotations, List<Quotation.Model.Model.QuotationDetails> quotationDetails)
        {
            quotations.ForEach(x => x.QuotationDetails
            = quotationDetails.Where(y => y.QuotationId == x.QuotationId)
            .ToList());
            return quotations;
        }
    }
}
