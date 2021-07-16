using System.ComponentModel.DataAnnotations;

namespace Quotation.Model.Model
{
    public class User
    {
        [Display(Name = "userid")]
        [Key]
        public long UserId { get; set; }
        [Display(Name = "name")]
        public string Name { get; set; }
        [Display(Name = "emailaddress")]
        public string EmailAddress { get; set; }
        [Display(Name = "password")]
        public string Password { get; set; }
        public bool IsDeleted { get; set; }
    }
}
