using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Quotation.Common;
using Quotation.IRepository;
using Quotation.Model.Model;
using Quotation.Model.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;

namespace QuotationApi.Controllers
{
    [Route("api")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        private readonly IUserRepository userRepository;
        private readonly IConfiguration config;
        public LoginController(IUserRepository iUserRepository, IConfiguration configuration)
        {
            userRepository = iUserRepository;
            config = configuration;
        }

        [HttpPost("signup")]
        public IActionResult SignUp(User user)
        {
            try
            {
                long userId = userRepository.SignUpUser(user);

                if (userId > 0)
                {
                    return Ok(new GenericResponse<dynamic>(StatusCodes.Status200OK.ToString(), true, "User successfully signed up", null));
                }
                else
                {
                    return Ok(new GenericResponse<dynamic>(StatusCodes.Status200OK.ToString(), true, "User already exist!", null));
                }

            }
            catch (System.Exception ex)
            {
                return BadRequest(new GenericResponse<dynamic>(StatusCodes.Status400BadRequest.ToString(), false, ex.Message, null));
            }


        }

        [HttpPost("authenticate")]
        public IActionResult Authenticate(User user)
        {
            try
            {
                var userResult = userRepository.Authenticate(user);

                if (userResult != null)
                {
                    var loginViewModel = new LoginViewModel(
                        userResult.Name,
                        userResult.EmailAddress,
                        string.Empty,
                        GenerateToken.GenerateJSONWebToken(config, userResult));
                    return Ok(new GenericResponse<LoginViewModel>(StatusCodes.Status200OK.ToString(), true, "User successfully logged in.", loginViewModel));
                }
                else
                {
                    return Ok(new GenericResponse<dynamic>(StatusCodes.Status200OK.ToString(), true, "Incorrect login credentials", null));
                }

            }
            catch (System.Exception ex)
            {
                return BadRequest(new GenericResponse<dynamic>(StatusCodes.Status400BadRequest.ToString(), false, ex.Message, null));
            }
        }
    }
}
