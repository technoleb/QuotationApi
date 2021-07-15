using System.ComponentModel.DataAnnotations;

namespace Quotation.Model.ViewModel
{
    public class LoginViewModel
    {
        [Display(Name = "name")]
        public string Name { get; set; }
        [Display(Name = "emailaddress")]
        public string EmailAddress { get; set; }
        [Display(Name = "password")]
        public string Password { get; set; }
        [Display(Name = "token")]
        public string Token { get; set; }

        public LoginViewModel(string name, string emailAddress, string password, string token)
        {
            this.Name = name;
            this.EmailAddress = emailAddress;
            this.Password = password;
            this.Token = token;
        }
    }
}
