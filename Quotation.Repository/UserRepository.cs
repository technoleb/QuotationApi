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

        private readonly QuotationDataContext _QuotationDataContext = null;
        public UserRepository(QuotationDataContext quotationDataContext)
        {
            _QuotationDataContext = quotationDataContext;
        }

        public long SignUpUser(User user)
        {
            if (!_QuotationDataContext.User.Any(x => x.EmailAddress == user.EmailAddress))
            {
                _QuotationDataContext.Add(user);
                _QuotationDataContext.SaveChanges();
                return Convert.ToInt64(user.UserId);
            }
            else
            {
                return 0;
            }
        }

        public User Authenticate(User user)
        {
            return _QuotationDataContext
                .User
                .FirstOrDefault(x => x.EmailAddress == user.EmailAddress
                && x.Password == user.Password);
        }
    }
}
