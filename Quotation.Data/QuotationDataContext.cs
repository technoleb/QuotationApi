using Microsoft.EntityFrameworkCore;
using Quotation.Model.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quotation.Data
{
    public class QuotationDataContext : DbContext
    {
        public QuotationDataContext(DbContextOptions<QuotationDataContext> options) : base(options)
        {

        }

        public DbSet<User> User { get; set; }
        public DbSet<QuotationDetail> QuotationDetail { get; set; }
        public DbSet<Quotation.Model.Model.Quotation> Quotation { get; set; }
    }
}
