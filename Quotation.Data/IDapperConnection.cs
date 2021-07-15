using Quotation.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quotation.Data
{
    public interface IDapperConnection
    {
        List<T> ExecuteQuery<T>(SqlParameters sqlParameters) where T : class;
    }
}
