using Quotation.Model.Model;

namespace Quotation.IRepository
{
    public interface IUserRepository
    {
        User Authenticate(User user);
        long SignUpUser(Quotation.Model.Model.User user);
    }
}
