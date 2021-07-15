using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Quotation.Common;
using Quotation.IRepository;
using System;
using System.Collections.Generic;
using System.Linq;

namespace QuotationApi.Controllers
{
    [Authorize]
    [Route("api")]
    [ApiController]
    public class QuotationController : ControllerBase
    {
        private readonly IQuotationRepository quotationRepository = null;
        public QuotationController(IQuotationRepository iQuotationRepository)
        {
            quotationRepository = iQuotationRepository;
        }

        [Authorize]
        [HttpPost("submit")]
        public IActionResult SubmitQuotation(Quotation.Model.Model.Quotation quotation)
        {

            try
            {
                quotation.UserId = Convert.ToInt32(HttpContext.User.Identity.Name);

                var quotationResonse = quotationRepository.SubmitQuotation(quotation);

                if (quotationResonse != null && quotationResonse.Any())
                {
                    return Ok(new GenericResponse<Quotation.Model.Model.Quotation>(StatusCodes.Status200OK.ToString(), true, "Quotation submitted successfully", quotationResonse.FirstOrDefault()));
                }
                else
                {
                    return Ok(new GenericResponse<dynamic>(StatusCodes.Status200OK.ToString(), true, "Error while saving quotation data.", null));
                }

            }
            catch (System.Exception ex)
            {
                return BadRequest(new GenericResponse<dynamic>(StatusCodes.Status400BadRequest.ToString(), false, ex.Message, null));
            }
        }

        [Authorize]
        [HttpPut("update-status")]
        public IActionResult UpdateQuotationStatus(string quotationNumber, string status)
        {
            try
            {
                quotationRepository.UpdateQoutationStatus(quotationNumber, Convert.ToInt32(HttpContext.User.Identity.Name), Convert.ToInt32(status));
                return Ok(new GenericResponse<dynamic>(StatusCodes.Status200OK.ToString(), true, "Qoutation status updated successfully", null));
            }
            catch (System.Exception ex)
            {
                return BadRequest(new GenericResponse<dynamic>(StatusCodes.Status400BadRequest.ToString(), false, ex.Message, null));
            }
        }

        [Authorize]
        [HttpGet("get")]
        public IActionResult GetQuotationList()
        {
            try
            {
                var quotationResonse = quotationRepository.GetQuotation(0, Convert.ToInt32(HttpContext.User.Identity.Name));

                if (quotationResonse != null && quotationResonse.Any())
                {
                    return Ok(new GenericResponse<List<Quotation.Model.Model.Quotation>>(StatusCodes.Status200OK.ToString(), true, "Data loaded succefully", quotationResonse));
                }
                else
                {
                    return Ok(new GenericResponse<dynamic>(StatusCodes.Status200OK.ToString(), true, "No records found", null));
                }
            }
            catch (System.Exception ex)
            {
                return BadRequest(new GenericResponse<dynamic>(StatusCodes.Status400BadRequest.ToString(), false, ex.Message, null));
            }
        }

        [Authorize]
        [HttpDelete("delete")]
        public IActionResult DeleteQuotation(string quotationNumber)
        {
            try
            {
                if (quotationRepository.DeleteQuotation(quotationNumber, Convert.ToInt32(HttpContext.User.Identity.Name)))
                {
                    return Ok(new GenericResponse<dynamic>(StatusCodes.Status200OK.ToString(), true, "Qoutation deleted successfully", null));
                }
                else
                {
                    return Ok(new GenericResponse<dynamic>(StatusCodes.Status200OK.ToString(), true, "Error while deleting quotation", null));
                }

            }
            catch (System.Exception ex)
            {
                return BadRequest(new GenericResponse<dynamic>(StatusCodes.Status400BadRequest.ToString(), false, ex.Message, null));
            }
        }
    }
}
