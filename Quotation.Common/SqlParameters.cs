using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quotation.Common
{
    public class SqlParameters
    {
        public string StoreProcedureName { get; set; }
        public Dictionary<string, dynamic> Parameters { get; set; }
    }
}
