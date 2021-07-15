using Quotation.Common;
using Quotation.Data;
using Quotation.IRepository;
using Quotation.Model.Model;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Quotation.Repository
{
    public class UserRepository : IUserRepository
    {
        private readonly IDapperConnection dapper;
        public UserRepository(IDapperConnection iDapper)
        {
            dapper = iDapper;
        }

        public long SignUpUser(User user)
        {
            SqlParameters sqlParameters = new SqlParameters();
            sqlParameters.StoreProcedureName = "SignUp";
            Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
            parameters.Add("@Name", user.Name);
            parameters.Add("@EmailAddress", user.EmailAddress);
            parameters.Add("@Password", user.Password);
            sqlParameters.Parameters = parameters;
            var result = dapper.ExecuteQuery<dynamic>(sqlParameters).FirstOrDefault();
            return Convert.ToInt64(result.Inserted);
        }

        public User Authenticate(User user)
        {
            SqlParameters sqlParameters = new SqlParameters();
            sqlParameters.StoreProcedureName = "dbo.Authenticate";
            Dictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();            
            parameters.Add("@EmailAddress", user.EmailAddress);
            parameters.Add("@Password", user.Password);
            sqlParameters.Parameters = parameters;
            var result = dapper.ExecuteQuery<User>(sqlParameters).FirstOrDefault();
            return result as User;
        }
    }
}
