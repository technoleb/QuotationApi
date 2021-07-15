﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Quotation.Model.Model
{
    public class Quotation
    {
        [Display(Name = "quotationid")]
        public long QuotationId { get; set; }
        [Display(Name = "quotationdate")]
        public string QuotationDate { get; set; }
        [Display(Name = "quotationnumber")]
        public string QuotationNumber { get; set; }
        [Display(Name = "customername")]
        public string CustomerName { get; set; }
        [Display(Name = "customeraddress")]
        public string CustomerAddress { get; set; }
        [Display(Name = "totalamount")]
        public decimal TotalAmount { get; set; }
        [Display(Name = "totalvat")]
        public decimal TotalVat { get; set; }
        [Display(Name = "totalincludingvat")]
        public decimal TotalIncludingVat { get; set; }
        [Display(Name = "status")]
        public long Status { get; set; }
        [Display(Name = "userid")]
        public long UserId { get; set; }
        [Display(Name = "quotationdetails")]
        public IEnumerable<QuotationDetails> QuotationDetails { get; set; }
    }
}
