using Dapper;
using Quotation.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Quotation.Data
{
    public class DapperConnection : IDapperConnection
    {
        private readonly IDbConnection _iDbConnection;
        public DapperConnection(IDbConnection iDbConnection)
        {
            _iDbConnection = iDbConnection;
        }

        public List<T> ExecuteQuery<T>(SqlParameters sqlParameters) where T : class
        {
            return _iDbConnection.Query<T>(sqlParameters.StoreProcedureName, SetDynamicParameters(sqlParameters), commandType: CommandType.StoredProcedure).ToList();
        }

        private DynamicParameters SetDynamicParameters(SqlParameters sqlParameters)
        {
            var dynamicParameters = new DynamicParameters();
            sqlParameters.Parameters.ToList().ForEach(delegate (KeyValuePair<string, dynamic> keyValuePair)
                {
                    dynamicParameters.Add(keyValuePair.Key, keyValuePair.Value);
                });
            return dynamicParameters;
        }

    }
}
