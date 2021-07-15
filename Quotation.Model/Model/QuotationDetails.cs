using System.ComponentModel.DataAnnotations;

namespace Quotation.Model.Model
{
    public class QuotationDetails
    {
        [Display(Name = "quotationdetailid")]
        public long QuotationDetailId { get; set; }
        [Display(Name = "quotationid")]
        public long QuotationId { get; set; }
        [Display(Name = "quotationdescription")]
        public string QuotationDescription { get; set; }
        [Display(Name = "quantity")]
        public decimal Quantity { get; set; }
        [Display(Name = "unitprice")]
        public decimal UnitPrice { get; set; }
        [Display(Name = "totalamount")]
        public decimal TotalAmount { get; set; }
        [Display(Name = "totalvat")]
        public decimal TotalVat { get; set; }
        [Display(Name = "totalincludingvat")]
        public decimal TotalIncludingVat { get; set; }

        [Display(Name = "userid")]
        public long UserId { get; set; }
    }
}
