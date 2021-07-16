using Dapper;
using Microsoft.EntityFrameworkCore;
using Quotation.Common;
using Quotation.Data;
using Quotation.IRepository;
using Quotation.Model.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Quotation.Repository
{
    public class QuotationRepository : IQuotationRepository
    {
        private readonly QuotationDataContext _QuotationDataContext = null;
        public QuotationRepository( QuotationDataContext quotationDataContext)
        {
            
            _QuotationDataContext = quotationDataContext;
        }

        public Quotation.Model.Model.Quotation SubmitQuotation(Quotation.Model.Model.Quotation quotation)
        {
            quotation.QuotationDetail.ToList().ForEach(delegate (QuotationDetail quotationDetail)
            {
                quotationDetail.TotalAmount = (quotationDetail.Quantity * quotationDetail.UnitPrice);
                quotationDetail.TotalVat = (quotationDetail.TotalAmount * 14) / 100;
                quotationDetail.TotalIncludingVat = (quotationDetail.TotalAmount + quotationDetail.TotalVat);
                quotationDetail.UserId = quotation.UserId;
            });

            quotation.TotalVat = quotation.QuotationDetail.Sum(x => x.TotalVat);
            quotation.TotalIncludingVat = quotation.QuotationDetail.Sum(x => x.TotalIncludingVat);
            quotation.TotalAmount = quotation.QuotationDetail.Sum(x => x.TotalAmount);
            _QuotationDataContext.Add(quotation);
            _QuotationDataContext.SaveChanges();
            quotation.QuotationNumber = "QUOTE-" + Convert.ToString(quotation.QuotationId);
            _QuotationDataContext.SaveChanges();
            return quotation;
        }

        public List<Quotation.Model.Model.Quotation> GetQuotation(long quotationId, long userId)
        {
            if (quotationId == 0)
            {
                return _QuotationDataContext.Quotation.Where(x => x.UserId == userId)
                    .Include(x=>x.QuotationDetail)
                    .ToList();
            }
            else
            {
                return _QuotationDataContext.Quotation.Where(x => x.UserId == userId && x.QuotationId == quotationId).Include(x => x.QuotationDetail).ToList();
            }
        }

        public bool DeleteQuotation(string quotationNumber, long userId)
        {

            Quotation.Model.Model.Quotation quotation = _QuotationDataContext.Quotation.Where(x => x.QuotationNumber == quotationNumber && x.UserId == userId).Include(x => x.QuotationDetail).FirstOrDefault();
            if (quotation != null)
            {
                _QuotationDataContext.Quotation.Remove(quotation);
                _QuotationDataContext.SaveChanges();
                return true;
            }
            return false;
        }

        public void UpdateQoutationStatus(string quotationNumber, long userId, long status)
        {
            Quotation.Model.Model.Quotation quotation = _QuotationDataContext.Quotation.FirstOrDefault(x => x.QuotationNumber == quotationNumber && x.UserId == userId);
            if (quotation != null)
            {
                quotation.Status = status;
                _QuotationDataContext.SaveChanges();
            }
        }
    }
}
